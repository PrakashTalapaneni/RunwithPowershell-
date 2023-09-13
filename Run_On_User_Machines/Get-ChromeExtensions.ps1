<#
 This script can be run on user machines from a Remote monitoring and management software like N-central. 
 This script is to get chrome extensions. 
 The Script will check if current logged in user and looks for chrome extension JSON files like 'messages.Json' and 'manifest.Json', which contains
 information about the installed extension.
  
#>
$Current_LoggedInUser=(Get-CimInstance -ClassName Win32_ComputerSystem).UserName.Split('\')[1]
$ChromeExtension_Location = "C:\Users\$Current_LoggedInUser\AppData\Local\Google\Chrome\User Data\Default\Extensions"
$filetowatch = 'manifest.json'
$Data = Get-ChildItem -LiteralPath $ChromeExtension_Location

$InfoList = @()  # Create an empty array to store extension information

foreach ($Extension in $Data) {
    $ExtensionName = $Extension.Name
    $ExtensionPath = $Extension.FullName
    $manifestcontent= Get-ChildItem -Path $Extensionpath -Recurse -Filter $filetowatch | Get-Content -Raw | ConvertFrom-Json
    $ExtensionNameMatch = $ManifestContent.name
    IF($ExtensionNameMatch -match '^__MSG_(.*)__' ){
     $Test =Get-ChildItem -LiteralPath $ExtensionPath -Recurse  -Filter 'en' | Get-ChildItem -Filter 'messages.json' | Get-Content -Raw | ConvertFrom-Json
     
     if ($test.extname) {
        $appName = $test.extname | Select-Object -ExpandProperty Message
        $ExtensionNameMatch = $appName
    } elseif ($test.app_name) {
        $appName = $test.app_name | Select-Object -ExpandProperty Message
        $ExtensionNameMatch = $appName
    }
    $ExtensionVersionMatch = $ManifestContent.version 
     }
    $Info = [PSCustomObject]@{
        ExtensionName = $ExtensionNameMatch
        ExtensionVersion = $ExtensionVersionMatch
        ExtensionID = $ExtensionName  # Assuming extension name is used as the ID
    }
   
    $InfoList += $Info  # Add the extracted info to the list
    
}
# Output the information in a table format
$InfoList | Format-Table -AutoSize
