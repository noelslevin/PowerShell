$Username = Read-Host -Prompt "Enter the local user to update"
$Password = Read-Host -Prompt "Enter the new password for the user"

# Find out if this device is a laptop
$PCType = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty PCSystemType

# Set the password to use, if required
$EventsPassword = ConvertTo-SecureString $Password -AsPlainText -Force

# If the device is a laptop
if ($PCType -eq 2) {
    # Check if the named user exists
    $User = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue
    # If the local user exists, update it
    if ($User) {
        Set-LocalUser -Name $Username -Password $EventsPassword -PasswordNeverExpires $True -UserMayChangePassword $false
    }
    # If the local user doesn't exist, create it
    else {
        New-LocalUser -Name $Username -Password $EventsPassword -PasswordNeverExpires -UserMayNotChangePassword
    }
}
# If this device isn't a laptop
else {
    # Do nothing. This user account is only needed on laptops
}