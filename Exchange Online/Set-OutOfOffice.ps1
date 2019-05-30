$user = Read-Host "Email address"
$internal = Read-Host "Internal message"
$external = Read-Host "External message"
Set-MailboxAutoReplyConfiguration -Identity $user -InternalMessage $internal -ExternalMessage $external -AutoReplyState Enabled