#This csv contains usernames. Make sure that the header attribute is username
$CSV_Path = "C:\Temp\Users.CSV"

#Adding the data to array
$Data = @(Import-Csv -Path $CSV_Path)

#Add your proxy address domain to $string
$String = "@Test.com"
Import-Module -Name ActiveDirectory 
#Using foreach to iterate through the Array data

foreach ($User in $Data){
       $Item = $User.username
    Write-output "Adding Proxyaddress to $Item"
    Get-Aduser -Identity $item | Set-AdUser -add @{ProxyAddresses = "smtp:$Item$String"}
    Write-output "Adding ProxyAddress completed"

}