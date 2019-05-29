# Get a list of servers from Active Directory
$tableName = "Disk Space Report"
$table = New-Object System.Data.DataTable $tableName
$col1 = New-Object System.Data.DataColumn Computer,([string])
$col2 = New-Object System.Data.DataColumn Size,([decimal])
$col3 = New-Object System.Data.DataColumn Space,([decimal])
$col4 = New-Object System.Data.DataColumn Percentage,([string])
$table.Columns.Add($col1)
$table.Columns.Add($col2)
$table.Columns.Add($col3)
$table.Columns.Add($col4)
$Computers = Get-ADComputer -Filter 'OperatingSystem -like "*Server*"' -Properties Name | Select Name | Sort-Object Name
Foreach ($Computer in $computers) {
    # Ping each computer
    if (Test-Connection $Computer.Name -Count 1 -Quiet) {
        $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $Computer.Name -Filter "DeviceID='C:'" | Select Size, FreeSpace
        $size = [math]::Round($disk.Size/1GB,2)
        $free = [math]::Round($disk.FreeSpace/1GB,2)
        $percent = ($free/$size).ToString("P")
        $row = $table.NewRow()
        $row.Computer = $Computer.Name
        $row.Size = $size
        $row.Space = $free
        $row.Percentage = $percent
        $table.Rows.Add($row)
    }
    else {
        # Could not reach computer
    }
}
$table | Out-GridView