#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
function exitIfFailed { if ($LASTEXITCODE -ne 0) { exit } }

$exe = ".\sumatra_website.exe"
$plat = $PSVersionTable["Platform"]
if ($plat = "Unix") {
    $exe = "./sumatra_website"
}
go build -o $exe
exitIfFailed
Start-Process -Wait -FilePath $exe
Remove-Item -Path $exe

netlifyctl deploy -b www
# get-childitem . -include blog_app* | ForEach-Object ($_) {remove-item $_.fullname}
