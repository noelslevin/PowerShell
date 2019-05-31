Get-Content D:\PCs.txt | Foreach-Object { 
    $return = Test-Connection -ComputerName $_ -quiet 
    if ($return) {
        Write-Host $_ is responding.
        }
    else {
        Write-Host $_ is not responding.
    }
}