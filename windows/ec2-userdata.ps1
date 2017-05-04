<powershell>

write-output "Running user data script"
write-host "(host) Running user data script"

net user /add vagrant VerySecuredPassword
net localgroup administrators vagrant /add

Set-ExecutionPolicy -ExecutionPolicy bypass -Force

# Supress network location Prompt
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force

# Set network to private
$ifaceinfo = Get-NetConnectionProfile
Set-NetConnectionProfile -InterfaceIndex $ifaceinfo.InterfaceIndex -NetworkCategory Private

# WinRM 
winrm quickconfig -q
winrm quickconfig '-transport:http'
winrm set "winrm/config" '@{MaxTimeoutms="1800000"}'
winrm set "winrm/config/winrs" '@{MaxMemoryPerShellMB="512"}'
winrm set "winrm/config/service" '@{AllowUnencrypted="true"}'
winrm set "winrm/config/client" '@{AllowUnencrypted="true"}'
winrm set "winrm/config/service/auth" '@{Basic="true"}'
winrm set "winrm/config/client/auth" '@{Basic="true"}'
winrm set "winrm/config/service/auth" '@{CredSSP="true"}'
winrm set "winrm/config/listener?Address=*+Transport=HTTP" '@{Port="5985"}'
netsh advfirewall firewall set rule group="remote administration" new enable=yes 
netsh firewall add portopening TCP 5985 "Port 5985" 
net stop winrm 
sc config winrm start= auto
net start winrm
wmic useraccount where "name='vagrant'" set PasswordExpires=FALSE

# RDP
netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

# Enable the WinRM Firewall rule, which will likely already be enabled due to the 'winrm quickconfig' command above
Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"

sc.exe config winrm start= auto

exit 0

</powershell>
