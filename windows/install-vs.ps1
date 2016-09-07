Write-Host "Installing Visual Studio"
$isoPath = "C:\vs2015_pro.iso"
$rc = Mount-DiskImage -PassThru -ImagePath $isoPath
$driveLetter = ($rc | Get-Volume).DriveLetter
$installPath = Join-Path "${driveLetter}:" "vs_professional.exe"
Start-Process -FilePath $installPath -ArgumentList "/adminfile C:\vs2015_pro_adminfile /quiet /norestart" -NoNewWindow -Wait
Dismount-DiskImage -ImagePath $isoPath
Remove-Item -Force -Path $isoPath 
