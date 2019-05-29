$email = Read-Host "Email address"

Set-MailboxAutoReplyConfiguration $email -AutoReplyState Disabled  -ExternalMessage $null -InternalMessage $null