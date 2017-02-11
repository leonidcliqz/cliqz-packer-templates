if([environment]::OSVersion.version.Major -lt 6) { return }

# You cannot change the network location if you are joined to a domain, so abort
if(1,3,4,5 -contains (Get-WmiObject win32_computersystem).DomainRole) { return }

# Get network connections
$networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
$connections = $networkListManager.GetNetworkConnections()

$connections |foreach {
    Write-Host $_.GetNetwork().GetName()"category was previously set to"$_.GetNetwork().GetCategory()
    $_.GetNetwork().SetCategory(1)
    Write-Host $_.GetNetwork().GetName()"changed to category"$_.GetNetwork().GetCategory()
}

