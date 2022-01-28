# initialize
.$PSScriptRoot\Tests\Unit\init\init.ps1

# test
$pestercommand = Get-Command Invoke-Pester
"`n`tSTATUS: Testing with PowerShell $($PSVersionTable.PSVersion.ToString())"
"`tSTATUS: Testing with Pester $($pestercommand.version)`n"

$container = New-PesterContainer -Path (Join-Path -Path $PSScriptRoot -ChildPath "Tests\Unit\")
$container | Where-Object {$_.Item -like "*PSSA*"} | Foreach-Object {
    $_.Data = @{
        TestLocation = "$PSScriptRoot\Scripts"
    }
}

$configuration = New-PesterConfiguration
$configuration.Run.PassThru = $true
$configuration.Run.Container = $container
$configuration.TestResult.Enabled = $true
$configuration.TestResult.OutputPath = "testresults.important.xml"
$configuration.Filter.Tag = @("Error")

# Run the tests which are tagged Error
Invoke-Pester -Configuration $configuration

$configuration.TestResult.OutputPath = "testresults.information.xml"
$configuration.Filter.Tag = @("Information","Warning")

# Run the tests which are tagged Information or Warning
Invoke-Pester -Configuration $configuration