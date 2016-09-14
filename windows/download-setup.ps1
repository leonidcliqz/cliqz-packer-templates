#Perfect hack to download files from host to the virtual machine
$setups = "DXSDK_Jun10.exe", "nss.zip", "vs2015_pro.iso","mozilla-build.zip","go1.6.3.windows-amd64.msi","vs2015_pro_adminfile"
$ftpserver = "ftp://cliqznas/packerwindowsfiles"
foreach($setup in $setups){
	$download_url = $ftpserver + "/" + $setup
	$output = "C:\" + $setup
	$client = new-object System.Net.WebClient
	$client.DownloadFile($download_url, $output)
}
