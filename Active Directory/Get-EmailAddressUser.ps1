$email = Read-Host -Prompt 'Email address to check'
$user = Get-ADUser -Properties proxyAddresses -Filter "proxyAddresses -like '*$email*'" | Select SamAccountName
if ($user) {
    Write-Host $user.SamAccountName
}

else {
    Write-Host "The email address is not assigned."
}