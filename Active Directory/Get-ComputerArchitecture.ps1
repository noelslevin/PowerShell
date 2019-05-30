$computers = Get-ADComputer -Filter {OperatingSystem -like 'Windows 7*'} | Sort Name
foreach ($computer in $computers) {
    If (Test-Connection $computer.Name -count 1 -quiet) {
        $arch = (Get-WmiObject Win32_OperatingSystem -computername $computer.Name).OSArchitecture
        Write-Host $computer.Name $arch
    }
}