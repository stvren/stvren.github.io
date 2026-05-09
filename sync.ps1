# ============================================================
#  sync.ps1  -  Auto-sync app info into index.html
# ============================================================

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$AppDir = Join-Path $ScriptDir "app"
$HtmlFile = Join-Path $ScriptDir "index.html"

Write-Host "=== App Sync Tool ===" -ForegroundColor Cyan

# Find app file
$files = Get-ChildItem -Path $AppDir -File | Where-Object {
    $_.Name -notmatch '\.(png|ico|jpg|jpeg|svg|bmp|txt|md)$' -and
    $_.Name -notlike 'README*'
}

if ($files.Count -eq 0) {
    Write-Host "[WARN] No app file found, creating placeholder" -ForegroundColor Yellow
    $dummyFile = Join-Path $AppDir "myapp.exe"
    "placeholder" | Out-File $dummyFile -Encoding ASCII
    $files = Get-ChildItem $dummyFile
}

$f = $files[0]
$fn = $f.Name
$sz = $f.Length

# Format size
if ($sz -gt 1GB) { $fs = "{0:N2} GB" -f ($sz / 1GB) }
elseif ($sz -gt 1MB) { $fs = "{0:N2} MB" -f ($sz / 1MB) }
elseif ($sz -gt 1KB) { $fs = "{0:N2} KB" -f ($sz / 1KB) }
else { $fs = "$sz B" }

# Extract name + version from filename
$base = [System.IO.Path]::GetFileNameWithoutExtension($fn)
$ver = "1.0.0"
$name = $base
$m = [regex]::Match($base, '[_\- ](v?\d+\.\d+(?:\.\d+)?)')
if ($m.Success) {
    $ver = $m.Groups[1].Value
    $name = $base.Substring(0, $m.Index).TrimEnd('_', '-', ' ')
}
if ([string]::IsNullOrWhiteSpace($name)) { $name = $base }

Write-Host ("  Name:    " + $name) -ForegroundColor Green
Write-Host ("  Version: " + $ver) -ForegroundColor Green
Write-Host ("  File:    " + $fn) -ForegroundColor Green
Write-Host ("  Size:    " + $fs) -ForegroundColor Green

# Find logo
$logo = Get-ChildItem -Path $AppDir -File | Where-Object {
    $_.Name -like "logo.*" -or $_.Name -like "icon.*"
} | Select-Object -First 1

# Read HTML
$html = Get-Content -Path $HtmlFile -Raw -Encoding UTF8

# Update fields using regex
$html = $html -replace '(?<=<div class="app-name" id="appName">).*?(?=</div>)', $name
$html = $html -replace '(?<=<div class="app-version" id="appVersion">\u7248\u672C\s).*?(?=</div>)', ($ver + ' Build 0420')
$html = $html -replace '(?<=<span class="value" id="fileName">).*?(?=</span>)', $fn
$html = $html -replace '(?<=<span class="value" id="fileSize">).*?(?=</span>)', $fs
$html = $html -replace '(?<=<span class="value" id="fileVersion">).*?(?=</span>)', $ver
$html = $html -replace '(?<=<a\s+id="downloadBtn"\s+href=").*?(?=")', ("./app/" + $fn)

# Update icon if logo exists
if ($logo) {
    $bytes = [System.IO.File]::ReadAllBytes($logo.FullName)
    $b64 = [Convert]::ToBase64String($bytes)
    $ext = $logo.Extension.ToLower()
    switch ($ext) {
        ".png"  { $mime = "image/png" }
        ".ico"  { $mime = "image/x-icon" }
        ".jpg"  { $mime = "image/jpeg" }
        ".jpeg" { $mime = "image/jpeg" }
        ".svg"  { $mime = "image/svg+xml" }
        ".bmp"  { $mime = "image/bmp" }
        default { $mime = "image/png" }
    }
    $uri = "data:" + $mime + ";base64," + $b64
    $html = $html -replace '<div class="app-icon"[^>]*>[^<]*</div>', ('<img class="app-icon" src="' + $uri + '" alt="' + $name + '" />')
    $html = $html -replace '<span class="xp-icon">[^<]*</span>', ('<span class="xp-icon"><img src="' + $uri + '" style="width:16px;height:16px;" alt="" /></span>')
}

# Write back
$html | Set-Content -Path $HtmlFile -Encoding UTF8

Write-Host "=== Sync complete! ===" -ForegroundColor Green
