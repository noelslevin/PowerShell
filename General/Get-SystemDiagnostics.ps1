cls

# Get the name given to the computer
$PCName = $env:COMPUTERNAME

# Get the serial number
$Serial = (Get-WmiObject Win32_Bios).SerialNumber

# Get the BIOS version
$Bios = (Get-WmiObject Win32_Bios).Version

# Get the MAC address of the wired network adapter
$Mac = (Get-NetAdapter -Name Ethernet).MacAddress

# Check the connection state of the wired network adapter
$EthernetStatus = (Get-NetAdapter -Name Ethernet).Status

# Check the connection speed of the wired network adapter
$EthernetSpeed = (Get-NetAdapter -Name Ethernet).LinkSpeed

# How much free space on the system drive?
$SystemDriveFree = [math]::Round((Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'").FreeSpace / 1GB,2)

# How much capacity does the system drive have?
$SystemDriveSize = [math]::Round((Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'").Size / 1GB,2)

# What percentage of space is free on the system drive?
$SpacePercent = [math]::Round((($SystemDriveFree / $SystemDriveSize) * 100),2)

# Get current user
$Username = $env:USERNAME

# Get domain context of current user
$Domain = $env:USERDOMAIN

# Get profile path of current user
$ProfilePath = $env:USERPROFILE

# Get number of items in current user's downloads directory
$DirStats = Get-ChildItem -Path "$env:USERPROFILE\Downloads\" -Recurse | Measure-Object -Sum Length

# Count items in current user's downloads directory
$Items = $DirStats.Count

# Calculate size of files in user's downloads directory
$Size = [math]::Round(($DirStats.Sum / 1GB),2)

Write-Host $PCName
Write-Host $Serial
Write-Host $Bios
Write-Host $Mac
Write-Host $EthernetStatus
Write-Host $EthernetSpeed
Write-Host $SystemDriveFree
Write-Host $SystemDriveSize
Write-Host $SpacePercent
Write-Host $Username
Write-Host $Domain
Write-Host $ProfilePath
Write-Host $Items
Write-Host $Size