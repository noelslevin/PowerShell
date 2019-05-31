$backupsource = Read-Host -Prompt "Enter path of the folder to back up"
$destinationfolder = Read-Host "Enter the path of the folder in which to place the backup"
$date = Get-Date -UFormat "%Y-%m-%d"
$filename = "Data.zip"
$fullpath = $destinationfolder + $date + "-" + $filename
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::CreateFromDirectory($backupsource, $fullpath)