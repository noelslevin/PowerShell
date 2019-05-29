# File name is required to determine the script to sign
Param(
 [Parameter(Position=0,Mandatory=$True,
 HelpMessage="What is the name of the script to sign?")]
[string]$Filename
)

# Need to retrieve a valid code signing certificate to sign the file
$cert = (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert -ExpiringInDays 366)

# This server will verify the signing time
# This allows the script to run even after the signing certificate has expired
$timestampserver = "http://timestamp.digicert.com"

# Append the file extension, as it's almost always this
$Filename = $Filename.trim() + ".ps1"

try {
    Set-AuthenticodeSignature -FilePath $Filename -Certificate $cert -TimestampServer $timestampserver -ErrorAction Stop
}
catch {
    Write-Warning "Failed to sign the file $Filename"
    # Display the generated error message
    Write-Warning $_.Exception.Message
}