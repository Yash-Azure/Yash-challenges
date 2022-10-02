#Get the Azure storage account where the main state file will be hosted

$RESOURCE_GROUP_NAME = "terraform-rg" 
$STORAGE_ACCOUNT_NAME = "tfstate1234"

$ACCOUNT_KEY=(Get-AzStorageAccountKey -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME)[0].value
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY