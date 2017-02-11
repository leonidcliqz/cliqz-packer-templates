Write-Host "Installing Visual Studio"
$isoPath = "C:\\jenkins\\tools\\vs2015_pro.iso"
$rc = Mount-DiskImage -PassThru -ImagePath $isoPath
$driveLetter = ($rc | Get-Volume).DriveLetter
$installPath = Join-Path "${driveLetter}:" "vs_professional.exe"
Start-Process -FilePath $installPath -ArgumentList "/adminfile C:\\jenkins\tools\\vs2015_pro_adminfile /quiet /norestart" -NoNewWindow -Wait
Write-Host "Unmounting Image"
Dismount-DiskImage -ImagePath $isoPath
Write-Host "Removing Path"
Remove-Item -Force -Path $isoPath 
