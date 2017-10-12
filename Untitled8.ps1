$ErrorActionPreference = "silentlycontinue"
Get-Content C:\private\tspathusers.txt | foreach {
   get-ADUser $user | select DistinguishedName | out-file c:\private\usersDN.csv  -NoTypeInformation 
   }



$users = ForEach ($user in $(Get-Content C:\private\tspathusers.txt)){
  Get-ADUser $user | select DistinguishedName | export-csv c:\private\usersDN.csv  -NoTypeInformation        
}
$Allusers = Get-ADUser -Filter * | select DistinguishedName,Samaccountname,GivenName,Surname
 foreach ($user in $Allusers) 
    {
    $userSearch = [adsi]("LDAP://" + $user.DistinguishedName)
    $TermPath = $userSearch.psbase.InvokeGet(“terminalservicesprofilepath”)   
    $prop = @{
            samaccountname = $user.Samaccountname
            firstname = $user.GivenName
            lastname = $user.Surname
            TermPath = $termPath
            }
    $result = New-Object -TypeName PSObject -Property $Prop
    $Results += $result
    }
    $results.Count
    

