<#
  Scenario: If a workstation is connected to AD Domain and for unknown reasons the workstation doesn't have the recovery key in AD,
   You can use this script on User machines to enable BitLocker encryption and send the Keys to Active Directory. 
#>

#You can use this code in combination of any Remote Monitoring and Management software like N-central to run the code on user machines as a recurring script. 

$ErrorActionPreference = 'SilentlyContinue'
$Sever = "<Use your Server Name or IP address>"
#The Below If-Statement will only execute if the workstation can successfully ping the server
IF(Test-Connection -ComputerName $Sever -count 02){
    $Details = manage-bde -status
    $BitLocker_Status =  (Get-BitLockerVolume -MountPoint C: | Select-Object *).ProtectionStatus
    If($BitLocker_Status -eq "Off"){
    Write-Output "Enabling BitLocker encryption"
    Manage-bde -on c: -recoverypassword -s 
    $Details
    }else{
        $Details
    }
}else{
    Write-Output "User not connected to the network"
}
