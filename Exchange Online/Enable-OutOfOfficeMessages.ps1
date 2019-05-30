$email = Read-Host "Email address"
$external = Read-Host "External out-of-office message"
$internal = Read-Host "Internal out-of-office message"

Set-MailboxAutoReplyConfiguration $email -AutoReplyState Enabled  -ExternalMessage $external -InternalMessage $internal