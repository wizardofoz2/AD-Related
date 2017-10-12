$UserCredential = Get-Credential

 

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

 

Import-PSSession $Session

Get-Mailbox -Identity pdodd@kineticsnoise.com |fl


$assoc =New-Object psobject -Property @{
id =42
name = "test"
owner= "test"

}

Write-Host "$($assoc.id)  - $($assoc.name)  -  $($assoc.owner)"
write-host ("{0}  -{1} - {2}" -f $assoc.id, $assoc.name, $assoc.owner)

