$PSEmailServer = Read-Host -Prompt "Enter the IP address or FQDN of the SMTP server"
$FromAddress = Read-Host -Prompt "Enter the email address the generated email should appear from"
$ToAddress = Read-Host -Prompt "Enter the email address to send the confirmation email to"

# Username is required to process the password change.
Param(
 [Parameter(Position=0,Mandatory=$True,
 HelpMessage="What is the user's SAMAccountname?")]
[string]$Username
)

# This is the password scheme for generated passwords.
# It's designed like for ease of pronunciation and short-term memory.
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

# Password must be converted to a secure string.
$SecurePassword = (ConvertTo-SecureString -AsPlainText $password -Force)

# This is the text of the email to be generated. It's only used if successful.
$body = "The password for user $user has been changed to $password."

# Hash table of parameter values for Set-ADAccountPassword
$paramHash = @{
    Identity = $Username
    NewPassword = $SecurePassword
    Reset = $True
    Confirm = $True
    ErrorAction = "Stop"
}

Try {
    Set-ADAccountPassword @paramHash
    Send-MailMessage -From $FromAddress -To $ToAddress -Subject "AD Password change for $Username" -Body "$body"
    Write-Host "The password for user $Username has been changed to $password. Confirmation has been emailed."
}
Catch {
    Write-Warning "Failed to reset password for $Username"
    # Display the generated error message
    Write-Warning $_.Exception.Message
}