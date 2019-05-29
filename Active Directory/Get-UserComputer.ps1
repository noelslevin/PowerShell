$User = Read-Host "User"
(Get-ADComputer -Filter * -Properties CN, Description | Where-Object { $_.Description -eq $User }).CN