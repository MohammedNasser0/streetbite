param(
    [string]$OutputPath = '.delivery/StreetBite-review.zip',
    [string]$AndroidSdkPath = $env:ANDROID_SDK_ROOT
)

$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
Push-Location $projectRoot
try {
    $sourceChanges = @(& git status --porcelain --untracked-files=normal)
    if ($LASTEXITCODE -ne 0) { throw 'Unable to inspect source state.' }
    if ($sourceChanges.Count -gt 0) { throw 'Commit the reviewed source and documentation before packaging.' }
    $apk = Join-Path $projectRoot 'flutter_app/build/app/outputs/flutter-apk/app-release.apk'
    if (-not (Test-Path -LiteralPath $apk)) { throw 'Build the beta APK before packaging.' }
    if ([string]::IsNullOrWhiteSpace($AndroidSdkPath)) { $AndroidSdkPath = $env:ANDROID_HOME }
    if ([string]::IsNullOrWhiteSpace($AndroidSdkPath) -and $env:LOCALAPPDATA) {
        $AndroidSdkPath = Join-Path $env:LOCALAPPDATA 'Android/sdk'
    }
    if ([string]::IsNullOrWhiteSpace($AndroidSdkPath)) { throw 'Supply -AndroidSdkPath to verify APK metadata.' }
    $aapt = Get-ChildItem -LiteralPath (Join-Path $AndroidSdkPath 'build-tools') -Filter 'aapt.exe' -Recurse -File |
        Sort-Object FullName -Descending | Select-Object -First 1
    if ($null -eq $aapt) { throw 'Android SDK build-tools/aapt is required to verify APK metadata.' }
    $badging = (& $aapt.FullName dump badging $apk) -join "`n"
    if ($LASTEXITCODE -ne 0) { throw 'Unable to read APK metadata.' }
    $sourceVersion = [regex]::Match((Get-Content -LiteralPath 'flutter_app/pubspec.yaml' -Raw), '(?m)^version:\s*([^\s+]+)\+(\d+)\s*$')
    $apkVersion = [regex]::Match($badging, "versionName='([^']+)'")
    $apkBuild = [regex]::Match($badging, "versionCode='(\d+)'")
    if (-not $sourceVersion.Success -or -not $apkVersion.Success -or -not $apkBuild.Success -or
        $sourceVersion.Groups[1].Value -ne $apkVersion.Groups[1].Value -or
        $sourceVersion.Groups[2].Value -ne $apkBuild.Groups[1].Value) {
        throw 'APK version does not match committed source. Build and verify the current source before packaging.'
    }
    $currentDeck = 'StreetBite-project-review-build' + $sourceVersion.Groups[2].Value + '.pptx'
    if (-not (Test-Path -LiteralPath (Join-Path 'presentation' $currentDeck))) {
        throw 'Prepare the presentation for the current build before packaging.'
    }
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
        # Historical decks stay in Git; the delivery archive contains the current deck only.
        $historicalDecks = @($archive.Entries | Where-Object {
            $_.FullName.StartsWith('streetbite-capstone/presentation/') -and
            $_.FullName.EndsWith('.pptx') -and
            $_.FullName -ne ('streetbite-capstone/presentation/' + $currentDeck)
        })
        foreach ($historical in $historicalDecks) {
            $historical.Delete()
        }
        function Add-EvidenceFile([string]$Source, [string]$Entry) {
            if (Test-Path -LiteralPath $Source -PathType Leaf) {
                [IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                    $archive, $Source, ('streetbite-capstone/' + $Entry),
                    [IO.Compression.CompressionLevel]::Optimal) | Out-Null
            }
        }
        Add-EvidenceFile $apk 'beta/StreetBite.apk'
        $privateEvidence = Join-Path $projectRoot '.delivery/verification'
        Add-EvidenceFile (Join-Path $privateEvidence 'emulator-beta5/biometric-prompt-windows.png') 'private-evidence/emulator-beta5/biometric-prompt-windows.png'
        foreach ($name in @('help-center-build12.png', 'contact-build12.png')) {
            Add-EvidenceFile (Join-Path $privateEvidence ('emulator-beta12-support-passed/' + $name)) ('private-evidence/emulator-beta12/' + $name)
        }
        foreach ($name in @('firebase-testers.png', 'firebase-release-testers.png', 'firebase-beta9-release.json', 'firebase-beta10-release.json', 'firebase-beta11-release.json', 'firebase-beta12-release.json', 'firebase-beta13-release.json', 'jira-street3-evidence.md', 'jira-streetbite.jpg', 'jira-evidence.md')) {
            Add-EvidenceFile (Join-Path $privateEvidence $name) ('private-evidence/' + $name)
        }
        # Only visually reviewed screenshots go into the private delivery ZIP.
        foreach ($build in @('physical-beta4', 'physical-beta5', 'physical-beta9', 'physical-beta13')) {
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
