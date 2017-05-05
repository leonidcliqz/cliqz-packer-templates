Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip "C:\jenkins\tools\mozilla-build.zip" "C:\"
Unzip "C:\jenkins\tools\nss.zip" "C:\"
