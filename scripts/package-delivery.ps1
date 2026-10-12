param([string]$OutputPath = '.delivery/StreetBite-review.zip')

$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
Push-Location $projectRoot
try {
    $sourceChanges = @(& git status --porcelain --untracked-files=normal)
    if ($LASTEXITCODE -ne 0) { throw 'Unable to inspect source state.' }
    if ($sourceChanges.Count -gt 0) { throw 'Commit the reviewed source and documentation before packaging.' }
    $zipPath = [IO.Path]::GetFullPath((Join-Path $projectRoot $OutputPath))
    if (-not $zipPath.StartsWith($projectRoot + [IO.Path]::DirectorySeparatorChar)) {
        throw 'Delivery archive must remain inside the project workspace.'
    }
    if (Test-Path -LiteralPath $zipPath) { throw 'Choose a new archive filename; an archive already exists.' }
    New-Item -ItemType Directory -Force (Split-Path $zipPath) | Out-Null
    # Git archive includes committed source only, excluding ignored credentials/config/logs.
    & git archive --format=zip --prefix=streetbite-capstone/ --output=$zipPath HEAD
    if ($LASTEXITCODE -ne 0) { throw 'Source archive failed.' }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [IO.Compression.ZipFile]::Open($zipPath, [IO.Compression.ZipArchiveMode]::Update)
    try {
        function Add-EvidenceFile([string]$Source, [string]$Entry) {
            if (Test-Path -LiteralPath $Source -PathType Leaf) {
                [IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                    $archive, $Source, ('streetbite-capstone/' + $Entry),
                    [IO.Compression.CompressionLevel]::Optimal) | Out-Null
            }
        }
        $apk = Join-Path $projectRoot 'flutter_app/build/app/outputs/flutter-apk/app-release.apk'
        if (-not (Test-Path -LiteralPath $apk)) { throw 'Build the beta APK before packaging.' }
        Add-EvidenceFile $apk 'beta/StreetBite.apk'
        $privateEvidence = Join-Path $projectRoot '.delivery/verification'
        Add-EvidenceFile (Join-Path $privateEvidence 'emulator-beta5/biometric-prompt-windows.png') 'private-evidence/emulator-beta5/biometric-prompt-windows.png'
        foreach ($name in @('firebase-testers.png', 'firebase-release-testers.png', 'jira-streetbite.jpg', 'jira-evidence.md')) {
            Add-EvidenceFile (Join-Path $privateEvidence $name) ('private-evidence/' + $name)
        }
        # Only visually reviewed screenshots go into the private delivery ZIP.
        foreach ($build in @('physical-beta4', 'physical-beta5')) {
            $physical = Join-Path $privateEvidence ($build + '/reviewed-screenshots')
            foreach ($file in Get-ChildItem -LiteralPath $physical -Filter '*.png' -File -ErrorAction SilentlyContinue) {
                Add-EvidenceFile $file.FullName ('private-evidence/' + $build + '/' + $file.Name)
            }
        }
        $entry = $archive.CreateEntry('streetbite-capstone/beta/SHA256.txt')
        $writer = [IO.StreamWriter]::new($entry.Open())
        try { $writer.WriteLine((Get-FileHash -LiteralPath $apk -Algorithm SHA256).Hash.ToLower() + '  StreetBite.apk') }
        finally { $writer.Dispose() }
        $entry = $archive.CreateEntry('streetbite-capstone/SOURCE_COMMIT.txt')
        $writer = [IO.StreamWriter]::new($entry.Open())
        try { $writer.WriteLine((& git rev-parse HEAD)) }
        finally { $writer.Dispose() }
    } finally {
        $archive.Dispose()
    }
    Get-Item -LiteralPath $zipPath | Select-Object FullName, Length
} finally {
    Pop-Location
}
