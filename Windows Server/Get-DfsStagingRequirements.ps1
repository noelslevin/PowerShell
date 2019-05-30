$path = Read-Host "File Path to check"
$big32 = Get-ChildItem $path -recurse | Sort-Object length -descending | select-object -first 32 | measure-object -property length -sum
$size = $big32.sum /1GB
$staging = [math]::Ceiling($size)
Write-Host $staging GB required for DFS staging