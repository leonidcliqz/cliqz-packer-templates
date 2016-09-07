#Perfect hack to download files from host to the virtual machine
$setups = "DXSDK_Jun10.exe", "vs2015_pro.iso","mozilla-build.zip","go1.6.3.windows-amd64.msi","adminfile"
$ftpserver = "ftp://cliqznas.local"
foreach($setup in $setups){
	Write-host $webserver
	$download_url = $webserver + "/" + $setup
	$output = "C:\" + $setup
	wget $download_url -Outfile $output
}