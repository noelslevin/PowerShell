$User = Read-Host "User"
$Computer = Get-ADComputer -Filter { Description -eq $User } | Select Name
Set-Clipboard $Computer.Name