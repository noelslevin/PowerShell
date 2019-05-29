# This must be set to the IP address of the internal SMTP server
$smtpServerIP = ""

# This must be set to the email address the email should come from
$fromAddress = ""

<# 
This must be set to the email address blind copied in to the email
You could use this to copy in your helpdesk,
This could be useful so you can see it until the user has confirmed access, but this may cause compliance issues
This will likely be removed in future because of the compliance issue
#>
$BccAddress = ""

$ProgressPreference='SilentlyContinue'
Import-Module ActiveDirectory
$email = Get-ADUser -Identity $env:UserName | Select UserPrincipalName
$user = Read-Host "Username to reset (format: firstname.lastname)"

$upper="B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Y","Z"
$lower="b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"
$vowel="a","e","i","o","u"
$nums="1","2","3","4","5","6","7","8","9","0"
$1 = $upper | GET-RANDOM
$2 = $vowel | GET-RANDOM
$3 = $lower | GET-RANDOM
$4 = $vowel | GET-RANDOM
$5 = $lower | GET-RANDOM
$6 = $nums | GET-RANDOM
$7 = $nums | GET-RANDOM
$8 = $nums | GET-RANDOM
$9 = $nums | GET-RANDOM
$10 = $nums | GET-RANDOM

$password = $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10

$SecurePassword = (ConvertTo-SecureString -AsPlainText $password -Force)

try {
    Set-ADAccountPassword -Identity $user -NewPassword $SecurePassword -Reset
    $body = "The password for user $user has been changed to $password."
    Send-MailMessage -From $fromAddress -To $email.UserPrincipalName -Bcc $BccAddress -Subject "AD Password change confirmation" -Body "$body" -SmtpServer $smtpServerIP
    Write-Host "The password for user $user has been changed to $password by $($email.UserPrincipalName)."
    
    }
catch {
    Write-Host $_
    $body = "$($email.UserPrincipalName) tried to change the password for $user. Error message: $_"
    Send-MailMessage -From $fromAddress -To $BccAddress -Subject "AD Password change failure" -Body "$body"
    }
$exit = Read-Host "Press enter to exit"