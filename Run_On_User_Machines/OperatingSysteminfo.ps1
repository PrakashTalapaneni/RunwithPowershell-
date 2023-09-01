<#
This script can be useful when you want to get more info about the operating system.
The script can be run from N-central as a one time run script and the output will be directly passed on to the Scheduled script status on N-central.

Output:
ComputerName    BuildVersion    OSName                        OSVersion
------------    ------------    ------                        ---------
DESKTOP-ASKUSER Windows 11 22H2 Microsoft Windows 11          10.0.22621
#>

$ErrorActionPreference = 'SilentlyContinue'
function OS_Info {
    $ComputerName = (Get-wmiobject  -class win32_ComputerSystem).Name
    $OSName =(Get-WmiObject -class Win32_OperatingSystem).Caption
    $OSVersion = (Get-WmiObject -class Win32_OperatingSystem).Version
    $versionMapping = @{
        "10.0.22621" = "Windows 11 22H2"
        "10.0.22000" = "Windows 11 22H1"
        "10.0.19045" = "Windows 10 22H2"
        "10.0.19044" = "Windows 10 21H2"
        "10.0.19043" = "Windows 10 21H1"
        "10.0.19042" = "Windows 10 20H2"
    }
        $OSBuild = $versionMapping[$OSVersion]
        if (!$OSBuild) {
            $OSBuild = "Unknown Windows version."
        }
        New-Object -TypeName PSObject -Property @{
            ComputerName = $ComputerName
            OSName = $OSName
            OSVersion = $OSVersion
            BuildVersion = $OSBuild
        }
}
OS_Info 