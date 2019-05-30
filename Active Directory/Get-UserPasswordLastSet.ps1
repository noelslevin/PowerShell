$user = Read-Host "Enter user to look up"
Get-ADUser -Identity $user -Properties PasswordLastSet | Select PasswordLastSet