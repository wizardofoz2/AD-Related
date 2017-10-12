Import-Module ActiveDirectory
$Filter = <define a filter for Get-ADUser here>
$Path = <define the roaming profile path here>
Get-ADUser -Filter $Filter | ForEach-Object {
    $ADSI = [ADSI]('LDAP://{0}' -f $_.DistinguishedName)
    try {
        $ADSI.InvokeSet('TerminalServicesProfilePath',$Path)
        $ADSI.SetInfo()
    }
    catch {
        Write-Error $Error[0]
    }
}


$Path = <define the roaming profile path here>

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


Invoke-Command -ComputerName dc -FilePath C:\Private\set-oztsprofile.ps1





