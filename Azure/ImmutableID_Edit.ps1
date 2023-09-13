<#To edit properties of a On-prem account in azure,
  you should first move the account to a non-sync OU and perform a delta sync 
  and Go to Microsoft 365  and check the deleted users and restore the user.
  after doing that remove the immutableID for the user and edit the properties like "Hide from GAL" (Which in some scenarios will not permit as the 
  the domain doesn't have Exchange attaributes available to make the change in AD ) 

#>

<#On the server after moving the User to non-Sync "OU" 
Open Powershell - Administrator
The below command will be only available on the server on which ADConnect is already installed
#>
Start-ADSyncSynccycle -PolicyType delta

#Now on your computer Open powershell as Administrator.
#Set the executionpolicy to Remotesigned or Bypass
Set-ExecutionPolicy -ExecutionPolicy Bypass
#Install the module
Install-Module -Name AzureAD
Import-Module -Name AzureAD
Install-Module -Name MSonline
Import-Module -Name MSonline
Install-module -name ExchangeonlineManagement
Import-module -name ExchangeonlineManagement

Connect-Msolservice
Get-Msoluser -UserprincipalName <Username> | Select-Object immutableID
#Now copy the immutableID to a txt file.
Get-Msoluser -UserprincipalName <Username> | Set-MsolUser -ImmutableID "$null"

#Now make the necessary changes to the user account in AzureAD or Microsoft 365. After finishing set the ImmutableID back to original from that txt file

Get-MsolUser -UserprincipalName <Username> | Set-MSoluser -ImmutableID "<original ImmutableID>"