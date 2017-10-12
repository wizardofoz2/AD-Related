$userCredential =Get-Credential
Connect-MsolService -Credential $usercredential

Get-AzureADApplicationOwner
Get-Command -Module AzureAD

connect-azuread

Get-AzureADSubscribedSku | select sku*, *units

Get-AzureADSubscribedSku | Select -Property Sku*,ConsumedUnits -ExpandProperty PrepaidUnits

$licenses = Get-AzureADSubscribedSku
$licenses[0].SkuPartNumber
$licenses[0].ServicePlans
$licenses[1].ServicePlans

Get-AzureADUser -SearchString jakeedwards@kineticsnoisecontrol.onmicrosoft.com| fl