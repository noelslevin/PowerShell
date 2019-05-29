function Show-Menu
{
    param (
        [string]$Title = 'WSUS Ring Selection'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for Bleeding Edge."
    Write-Host "2: Press '2' for Fast Ring."
    Write-Host "3: Press '3' for Slow Ring."
    Write-Host "Q: Press 'Q' to quit."
}

Show-Menu -Title 'WSUS Ring Selection'
 $selection = Read-Host "Please choose a WSUS update ring"
 switch ($selection)
 {
     '1' {
         $Identity = "Windows 10 Bleeding Edge"
     } '2' {
         $Identity = "Windows 10 Fast Ring"
     } '3' {
         $Identity = "Windows 10 Slow Ring"
     } 'q' {
         return
     }
 }

$Users = Get-ADGroupMember -Identity $Identity | Get-ADComputer -Properties * | Select Description
Get-ADUser -Filter * | ?{$_.Name -in $Users.Description} | Select UserPrincipalName -ExpandProperty UserPrincipalName | Clip