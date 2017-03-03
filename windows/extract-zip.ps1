Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip "C:\jenkins\tools\mozilla-build.zip" "C:\tools\jenkins"
Unzip "C:\jenkins\tools\nss.zip" "C:\tools\jenkins"
