Login-AzAccount       # Login-AzureRmAccount 

Get-AzSubscription    # Get-AzureRmSubscription

Set-AzContext -SubscriptionName "IaaS for Devs" # Set-AzureRmContext

$location = "westus"
$rgName = "IaaS-ps-rg"
$vaultName = "IaaS-ps-akv"
$vmName = "IaaS-ps"

# Step 1 Create keyvault
$KeyVault = New-AzKeyVault -VaultName $vaultName -ResourceGroupName $rgName -Location $location

$KeyVaultResourceId = $KeyVault.ResourceId
$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri

#Step 2: Enable the vault for disk encryption.

Set-AzKeyVaultAccessPolicy -VaultName $vaultName `
            -ResourceGroupName $rgName `
            -EnabledForDiskEncryption

Set-AzKeyVaultAccessPolicy -VaultName $vaultName `
            -ResourceGroupName $rgName `
            -EnabledForDeployment

Set-AzKeyVaultAccessPolicy -VaultName $vaultName `
            -ResourceGroupName $rgName `
            -EnabledForTemplateDeployment

	 
#Step 3: Encrypt the disks of an existing IaaS VM
	 
Set-AzVMDiskEncryptionExtension -ResourceGroupName $rgName -VMName $vmName -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId