Describe "ConvertTo-ScriptJson" -Tag "Error" {

    It "Should convert a powershell script to a json file and output as a pipeline variable" {
        # Call the script with the TestScript.ps1
        $outvar = .$PSScriptRoot\..\..\..\Scripts\ConvertTo-ScriptJson.ps1 -Path (Join-Path -Path $PSScriptRoot -Childpath '..\..\..\Tests\Unit\resources\TestScript.ps1') -VariableName "test" 6>&1
    
        $expectedResult = '##vso[task.setvariable variable=test]"param (\r\n[Parameter(Mandatory = $true)] \r\n[string] $Var\r\n)\r\n\r\nWrite-Host \"Hello $Var!\""'

        $outvar | Should -Be $expectedResult
    }

    It "Should convert a powershell script to a json file and output as a string" -Tag "Error" {
        # Call the script with the TestScript.ps1
        $json = .$PSScriptRoot\..\..\..\Scripts\ConvertTo-ScriptJson.ps1 -Path (Join-Path -Path $PSScriptRoot -Childpath '..\..\..\Tests\Unit\resources\TestScript.ps1') 6>&1
    
        $expectedResult = '"param (\r\n[Parameter(Mandatory = $true)] \r\n[string] $Var\r\n)\r\n\r\nWrite-Host \"Hello $Var!\""'

        $json | Should -Be $expectedResult
    }
}