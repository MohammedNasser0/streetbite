param([string]$FlutterCommand = 'flutter')

$ErrorActionPreference = 'Stop'
$appRoot = Join-Path $PSScriptRoot '../flutter_app'
foreach ($relative in @('android/maps.properties', 'android/app/google-services.json', 'lib/core/firebase_options.dart')) {
    if (-not (Test-Path -LiteralPath (Join-Path $appRoot $relative))) {
        throw "Missing private beta configuration: $relative"
    }
}

Push-Location $appRoot
try {
    # Keep the configured native Maps feature enabled in every beta build.
    & $FlutterCommand build apk --release --dart-define=MAPS_CONFIGURED=true
    if ($LASTEXITCODE -ne 0) { throw "Flutter build failed: $LASTEXITCODE" }
    Get-FileHash -LiteralPath 'build/app/outputs/flutter-apk/app-release.apk' -Algorithm SHA256
} finally {
    Pop-Location
}
