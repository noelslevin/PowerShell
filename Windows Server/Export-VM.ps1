$path = "D:\Virtual Machines"
$date = (Get-Date).ToString("yyyy-MM-dd")
$vm = Read-Host "Select a server to back up"
Get-VM -Name $vm | Export-VM -Path "$path\$vm\$date"