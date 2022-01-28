Describe "ConvertTo-ScriptJson" -Tag "Error" {

    It "Should convert a powershell script to a json file" {
        # Call the script with the TestScript.ps1
        $json = .$PSScriptRoot\..\..\..\Scripts\ConvertTo-ScriptJson.ps1 -Path (Join-Path -Path $PSScriptRoot -Childpath '..\..\..\Tests\Unit\resources\TestScript.ps1') -VariableName "test" 6>&1
    
        $expectedResult = '##vso[task.setvariable variable=test]"param (\r\n[Parameter(Mandatory = $true)] \r\n[string] $Var\r\n)\r\n\r\nWrite-Host \"Hello $Var!\""'

        $json | Should -Be $expectedResult
    }
}