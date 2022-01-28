# initialize
.$PSScriptRoot\Tests\Unit\init\init.ps1

# test
$pestercommand = Get-Command Invoke-Pester
"`n`tSTATUS: Testing with PowerShell $($PSVersionTable.PSVersion.ToString())"
"`tSTATUS: Testing with Pester $($pestercommand.version)`n"

$container = New-PesterContainer -Path (Join-Path -Path $PSScriptRoot -ChildPath "Tests\Integration\")

$configuration = New-PesterConfiguration
$configuration.Run.PassThru = $true
$configuration.Run.Container = $container
$configuration.TestResult.Enabled = $true
$configuration.TestResult.OutputPath = "testresults.xml"

Invoke-Pester -Configuration $configuration