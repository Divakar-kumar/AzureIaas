Login-AzAccount       # Login-AzureRmAccount 

Get-AzSubscription    # Get-AzureRmSubscription

Set-AzContext -SubscriptionName "IaaS for Devs" # Set-AzureRmContext

$location = "westus"
$rgName = "IaaS-ps-rg"
$credential = Get-Credential

New-AzResourceGroup -Name $rgName -Location $location # New-AzureRmResourceGroup

New-AzVm `
    -ResourceGroupName $rgName `
    -Name "IaaS-ps" `
    -Location $location `
    -VirtualNetworkName "IaaS-ps-vnet" `
    -SubnetName "IaaS-ps-subnet" `
    -SecurityGroupName "IaaS-ps-nsg" `
    -PublicIpAddressName "IaaS-ps-ip" `
    -OpenPorts 80,3389 `
    -Credential $credential  # New-AzureRmVm

$ipAddress = Get-AzPublicIpAddress -ResourceGroupName Iaas-ps-rg `
         | Select-Object -ExpandProperty IpAddress  # Get-AzureRmPublicIpAddress

mstsc /v:$ipAddress
