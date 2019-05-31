$Expiring = (Get-Date).AddDays(-35)
$Expired = (Get-Date).AddDays(-36)
Get-ADUser -Filter { Enabled -eq $true -and PasswordNeverExpires -eq $false -and PasswordLastSet -lt $Expiring -and PasswordLastSet -gt $Expired } -Properties PasswordLastSet | Select Name, UserPrincipalName, PasswordLastSet | Sort-Object PasswordLastSet