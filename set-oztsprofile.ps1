$imported = Import-Csv "C:\private\testtspathusers.csv"
Foreach ($user in $imported) {
$AD = (Get-ADUser -Identity $user.samaccountname).distinguishedname
$ADUser = [ADSI]“LDAP://$AD”
try{
$ADUser.InvokeSet('TerminalServicesProfilePath',"\\file\scanned\cirtixprofiles\$($user.samaccountname)")
$ADUser.InvokeSet('TerminalServicesHomeDrive',"S:")
$ADUser.InvokeSet('TerminalServicesHomeDirectory',"\\file\scanned\visualusers\$($user.samaccountname)")

        $ADUser.SetInfo()
}catch {
Write-Error $error[0]
}
}

