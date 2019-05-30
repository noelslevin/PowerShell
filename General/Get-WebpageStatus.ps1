$Site = Read-Host -Prompt 'Web address to test'

$HTTP_Request = [System.Net.WebRequest]::Create($Site)

# Get a response from the site.
try { $HTTP_Response = $HTTP_Request.GetResponse() }
catch [System.Net.WebException] { $HTTP_Response = $_.Exception.Response }

# Get the HTTP code as an integer.
$HTTP_Status = [int]$HTTP_Response.StatusCode

if ($HTTP_Status -eq 200) {
  Write-Host "Success"
  }
elseif ($HTTP_Status -eq 401) {
  Write-Host "Unauthenticated"
  }
elseif ($HTTP_Status -eq 404) {
  Write-Host "Not Found"
}
elseif ($HTTP_Status -eq 500) {
  Write-Host "Internal Server Error"
}
else {
  Write-Host "Unexpected HTTP response ($HTTP_Status)"
}

# Clean up the http request by closing it.
$HTTP_Response.Close()