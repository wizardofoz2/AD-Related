$365Logon = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $365Logon -Authentication Basic -AllowRedirection
Import-PSSession $Session

Set-ExecutionPolicy RemoteSigned

Import-Module MSOnline
$msolCred = Get-Credential
Connect-MsolService –Credential $msolCred

$upn = ""
$User = Get-MsolUser -UserPrincipalName $upn -ErrorAction SilentlyContinue
If ($User -ne $Null) { 
"User exists in Azure AD" 
} Else {
"User not found in Azure AD"}


$adsession = New-PSSession -ComputerName dc
Enter-PSSession -Session $adsession

Get-MsolUser -all | Where-Object {$_.passwordneverexpires -eq $true} | select displayname, userprincipalname


Get-Mailbox -ResultSize Unlimited  | Get-MailboxStatistics |
Select DisplayName, @{n=”Total Size (MB)”;e={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}}, StorageLimitStatus

Get-MsolAccountSku | Select AccountSkuId,SkuPartNumber,ActiveUnits,ConsumedUnits

$plan = Get-MsolAccountSku | Where {$_.SkuPartNumber -eq "O365_business_essentials"}
$plan.ServiceStatus
Get-MsolSubscription | Select SkuPartNumber, Status, TotalLicenses

Search-ADAccount  –PasswordNeverExpires –SearchBase “DC=local” | Select-Object name, LastLogonDate, DistinguishedName | export-csv C:\nonexpiringusers_external_ou_date.csv –noclobber


Get-ChildItem -Recurse "C:\Private" | Where { $_.PSIsContainer } | Select Name,FullName
