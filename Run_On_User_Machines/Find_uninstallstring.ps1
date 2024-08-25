#Regedit_Paths
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall";
$app = Get-ChildItem -path $RegPath | Get-ItemProperty | Where-Object {$_.DisplayName -like "*Microsoft*"}
#Outputs UninstallString
write-output $app.UninstallString