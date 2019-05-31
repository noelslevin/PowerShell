$FromAddress = Read-Host "Email address to use for sending email alert"
$PSEmailServer = Read-Host -Prompt "Enter the IP address or FQDN of the SMTP server"
$Expiring = (Get-Date).AddDays(-41)
$Expired = (Get-Date).AddDays(-42)
$Users = Get-ADUser -Filter { Enabled -eq $true -and PasswordNeverExpires -eq $false -and PasswordLastSet -lt $Expiring -and PasswordLastSet -gt $Expired } -Properties PasswordLastSet | Select Name, UserPrincipalName, PasswordLastSet | Sort-Object PasswordLastSet

Foreach ($User in $Users) {
    $ExpiresDate = Get-Date $User.PasswordLastSet.AddDays(+42) -Format M
    $ExpiresTime = Get-Date $User.PasswordLastSet.AddDays(+42) -Format t
    $Name = $User.GivenName
    $body = "Hi $Name `n `nYour domain password is due to expire on $ExpiresDate at $ExpiresTime `n`nPlease change your password before that time to ensure you have continued access to internal resources."
    Send-MailMessage -From $FromAddress -To $User.UserPrincipalName -Subject "Notice: Your domain password is about to expire" -Body "$body"
}