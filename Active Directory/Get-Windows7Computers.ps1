﻿Get-ADComputer -Filter { OperatingSystem -Like '*Windows 7*' } | Select Name | Sort-Object Name | Export-Csv 'D:\Windows 7 PCs.csv'