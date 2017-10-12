# Get all users TSProfile path 
$Results = @()
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
    

