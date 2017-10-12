$Results = Get-ADUser -Filter * | Select @{Name="TermPath";Expression={([adsi]("LDAP://$($_.distinguishedName)")).psbase.InvokeGet("terminalservicesprofilepath")}}
$Results.termpath | Out-File c:\private\tspath.csv

