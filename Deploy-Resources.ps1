# Get the information about the role and convert it to json
$Role = Get-Content "$PSScriptRoot\Roles\Create-Deployment-Scripts.json" -Raw

Write-Host "Deploy Managed idenitity"
$templateoutput = New-AzSubscriptionDeployment -Name "deploy_mid" -TemplateFile "$PSScriptRoot\ArmTemplates\deploy_mid.json" -roleJson $Role -Location "westeurope"
$midOutput = ConvertTo-Json $templateoutput.Outputs

# Get the information about the policy and convert it to json
$Policy = Get-Content "$PSScriptRoot\Policies\TagLoadbalancedVMs.json" -Raw

# Get the script in json format
$Script = .$PSScriptRoot\Scripts\ConvertTo-ScriptJson.ps1 -Path (Join-Path -Path $PSScriptRoot -Childpath 'Scripts\Set-VmTag.ps1')

Write-Host "Deploy Policy"
$templateoutput = New-AzSubscriptionDeployment -Name "deploy_policy" -TemplateFile "$PSScriptRoot\ArmTemplates\deploy_policy.json" -midOutput $midOutput -policyJson $Policy -tagScriptJson $Script -Location "westeurope"