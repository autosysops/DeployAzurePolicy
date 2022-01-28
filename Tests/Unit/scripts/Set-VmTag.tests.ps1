Describe "Set-VMTag" -Tag "Error" {

    BeforeAll {
        # Create a function so the az module doesn't have to be downloaded and installed
        function Update-AzTag ($ResourceId,$Tag,$Operation) {}

        # Mock Update-AzTag so we can test what values are send to it
        Mock Update-AzTag -MockWith {}
    }

    It "Should call the az module with the right parameters" {
        # Create a tag object
        $tags = @(@{TestTag = "TestValue"})

        # Call the script with dummy data
        .$PSScriptRoot\..\..\..\Scripts\Set-VMTag.ps1 -VmId "TestVM" -Tags (ConvertTo-Json $tags)

        # Test Update-AzTag was called with the right parameters
        Assert-MockCalled -CommandName 'Update-AzTag' -ParameterFilter { $ResourceId -eq 'TestVM' -and ($Tag | ConvertTo-Json) -eq (@{TestTag = "TestValue"} | ConvertTo-Json) -and $Operation -eq "Merge" } -Exactly 1
    }

    It "Should call the az module multiple times if more tags are given" {
        # Create a tag object
        $tags = @(@{TestTag = "TestValue"}, @{TestTag2 = "TestValue2"}, @{TestTag3 = "TestValue3"})

        # Call the script with dummy data
        .$PSScriptRoot\..\..\..\Scripts\Set-VMTag.ps1 -VmId "TestVM" -Tags (ConvertTo-Json $tags)

        # Test Update-AzTag was called with the right parameters
        Assert-MockCalled -CommandName 'Update-AzTag' -Exactly 3
    }
}