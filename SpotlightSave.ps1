Add-Type -AssemblyName System.Drawing

$spotLightDir = $env:LOCALAPPDATA + "\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$saveDir = [Environment]::GetFolderPath("MyPictures") + "\Spotlight"
$saveFileExtension = ".jpg"

if (Test-Path ($saveDir + ".\")) { } else {
  New-Item -ItemType Directory $saveDir
}

$imageFileList = Get-ChildItem -Path $spotLightDir | Where-Object { $_.Length -ge 50KB }
$existingFileNameList = Get-ChildItem -Path $saveDir | ForEach-Object { $_.BaseName }
$newFileList = $imageFileList | Where-Object { $existingFileNameList -notContains ($_.BaseName) }

$fullHdImageList = $newFileList | Where-Object { 
  $img = [System.Drawing.Image]::FromFile($_.FullName)
  $img.Width -eq 1920 -and $img.Height -eq 1080
}

try {
  If ($fullHdImageList.Length -eq 0) { Write-Host "no new file for saving" }
  $fullHdImageList | ForEach-Object {
    $src = $_.FullName
    $dst = $saveDir + "\" + $_.BaseName + $saveFileExtension
    Copy-Item -Path $src -Destination $dst -ErrorAction Stop
    Write-Host "saved: $dst"
  }
}
catch {
  Write-Error("Error:" + $_.Exception)
}