Get-ADComputer -Filter * -Properties OperatingSystem, OperatingSystemVersion | Where {$_.OperatingSystemVersion -like '*16299*' -and $_.OperatingSystem -notlike '*server*' } | Select Name