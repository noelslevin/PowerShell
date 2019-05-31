$Expired = (Get-Date).AddDays(-42)
$LongExpired = (Get-Date).AddDays(-80)
Get-ADUser -Filter { Enabled -eq $true -and PasswordNeverExpires -eq $false -and PasswordLastSet -lt $Expired -and PasswordLastSet -gt $LongExpired -and } -Properties PasswordLastSet | Select Name, UserPrincipalName, PasswordLastSet | Sort-Object PasswordLastSet