# Get the information about the role and convert it to json
$Role = Get-Content "$PSScriptRoot\Roles\Create-Deployment-Scripts.json" -Raw

Write-Host "Deploy Managed idenitity"
$templateoutput = New-AzSubscriptionDeployment -Name "deploy_mid" -TemplateFile "$PSScriptRoot\ArmTemplates\deploy_mid.json" -roleJson $Role -Location "westeurope"
$midOutput = ConvertTo-Json $templateoutput.Outputs

# Get the information about the policy and convert it to json
$Policy = Get-Content "$PSScriptRoot\Policies\TagLoadbalancedVMs.json" -Raw

Write-Host "Deploy Policy"
$templateoutput = New-AzSubscriptionDeployment -Name "deploy_policy" -TemplateFile "$PSScriptRoot\ArmTemplates\deploy_policy.json" -midOutput $midOutput -policyJson $Policy -Location "westeurope"