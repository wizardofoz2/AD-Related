Enter-PSSession dc

Set-ADUser $_.SamAccountName -HomeDrive "H:" -HomeDirectory "\\serverName\shareName\$($_.SamAccountName)"

$userdn = (Get-ADUser -Identity jake).distinguishedname
$userinfo = [ADSI]"LDAP://$userDN"
$userinfo.terminalservicesprofilepath

Function get-Path{
Get-ADUser -Filter * -SearchBase 'DC=domain-1,DC=local' | ForEach {
    $userInfo = [ADSI]"LDAP://$($_.distinguishedName)"
    $userInfo.TerminalServicesProfilePath
}
}

get-Path | Out-File 'C:\private\terminal.txt'

Get-ADUser -Identity jake |select -ExpandProperty Homedirectory



$imported = Import-Csv "C:\private\tspathusers.csv"
Foreach ($user in $imported) {
$AD = (Get-ADUser -Identity $user.samaccountname).distinguishedname
$ADUser = [ADSI]“LDAP://$AD”
$ADUser.terminalservicesprofilepath
#$ADuser.setinfo()
}
