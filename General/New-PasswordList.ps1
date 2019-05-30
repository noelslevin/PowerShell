$Passwords = @()
$val = 0
$upper="B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Y","Z"
$lower="b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"
$vowel="a","e","i","o","u"
$nums="1","2","3","4","5","6","7","8","9","0"

while ($val -lt 26) {
    $val++
    $1 = $upper | GET-RANDOM
    $2 = $vowel | GET-RANDOM
    $3 = $lower | GET-RANDOM
    $4 = $vowel | GET-RANDOM
    $5 = $nums | GET-RANDOM
    $6 = $nums | GET-RANDOM
    $7 = $nums | GET-RANDOM
    $8 = $nums | GET-RANDOM
    $password = $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8
    $Passwords += $password
    }
$Passwords | Out-File 'D:\Password-List.csv'