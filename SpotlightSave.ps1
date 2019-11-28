Add-Type -AssemblyName System.Drawing

$spotLightDir = $env:LOCALAPPDATA + "\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$saveDir = $env:USERPROFILE + "\Pictures\Spotlight"
$saveFileExtension = ".jpg"

$imageFileList = Get-ChildItem -Path $spotLightDir | Where-Object{$_.Length -ge 50KB} | ForEach-Object {$_}
$saveFileList = $imageFileList | Where-Object {[System.Drawing.Image]::FromFile($_.FullName).Width -eq 1920} 
try {
  $saveFileList | ForEach-Object {
    $src = $_.FullName
    $dst = $saveDir + "\" + $_.BaseName + $saveFileExtension
    Copy-Item -Path $src -Destination $dst -ErrorAction Stop
    Write-Host "saved: $dst"
  }
} catch {
  Write-Error("Error:" + $_.Exception)
}