$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

$mailbox = Read-Host "Mailbox to grant access to"
$user = Read-Host "Username requiring access"
$automap = Read-Host "Press 1 to automap, or 0 to prevent automapping"

if ($automap -eq 1) {
    Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping $true
}

else {
    Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping $false
}

Get-PSSession | Remove-PSSession