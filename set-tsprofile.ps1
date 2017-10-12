
# Set TSProfile Path for users which are listed in .csv file in following format
# samaccountname
#castem04

$imported = Import-Csv "C:\private\tspathusers.csv"
Foreach ($user in $imported) {
$AD = get-aduser $user.samaccountname | select -ExpandProperty disting*
$ADUser = [ADSI]“LDAP://$AD”
$ADUser.psbase.InvokeGet(“terminalservicesprofilepath”,"")
#$ADuser.setinfo()
}
