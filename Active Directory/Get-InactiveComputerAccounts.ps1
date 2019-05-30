$PSEmailServer = Read-Host -Prompt "IP address or FQDN of email server"
$FromAddress = Read-Host -Prompt "Enter the email address to send the email notification from"
$ToAddress = Read-Host -Prompt "Enter the email address you want to send the email notification to"

$MinDays = 1
$MaxDays = 366
do {
    try {
        $NumOK = $true
        Write-Host "How many days since last activity should be treated as inactive?"
        [uint16]$InactiveDays = Read-Host -Prompt "Enter a number between $MinDays and $MaxDays"
    }
    catch {
        $NumOK = $false
    }
}
until (($InactiveDays -ge 1 -and $InactiveDays -lt 366) -and $NumOK)

$date_with_offset = (Get-Date).AddDays(-$InactiveDays)
$number = Get-ADComputer -Filter {OperatingSystem -like "Windows 7*" -and LastLogonDate -lt $date_with_offset} | measure
if ($number.Count -gt 0) {
    $body = Get-ADComputer -Filter {OperatingSystem -like "Windows 7*" -and LastLogonDate -lt $date_with_offset} -Properties LastLogonDate | Select-Object Name, LastLogonDate | Sort LastLogonDate | Out-String
    Send-MailMessage -From $FromAddress -To $ToAddress -Subject "Automated report: inactive computer accounts" -Body "$body"
}
else {
    Write-Host "No results returned. All computers have reported within the last $num days."

}