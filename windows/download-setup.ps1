#Perfect hack to download files from host to the virtual machine
$setups = "Git-2.10.0-32-bit.exe", "jre-8u101-windows-x64.exe", "DXSDK_Jun10.exe", "nss.zip", "vs2015_pro.iso","mozilla-build.zip","go1.6.3.windows-amd64.msi","vs2015_pro_adminfile"

$ftpServer = "ftp://cliqznas/packerwindowsfiles"
$baseDir = "c:\\jenkins\\tools"
New-Item -ItemType Directory -Force -Path $baseDir

foreach($setup in $setups) {
    $downloadUrl = $ftpServer + "/" + $setup
    $output = $baseDir + "\\" + $setup
    $client = new-object System.Net.Webclient
    try {
        $client.DownloadFile($downloadUrl, $output)
    } catch [Exception] {
        echo $_.Exception|format-list -force
    }
}

