Describe "Tag-LoadbalancedVMs" -Tag "Error" {

    It "Should add tag to VM with loadbalancer when created" {
        # Deploy a VM and Loadbalancer to azure
        $templateoutput = New-AzSubscriptionDeployment -Name "deploy_test_vm" -TemplateFile (Join-Path -Path $PSScriptRoot -Childpath '..\..\ArmTemplates\deploy_lbvm.json') -rgName "Test-VM" -Location "westeurope" -adminPassword (ConvertTo-SecureString "SUPERSECRETPASSWORD" -AsPlainText)
    
        # Check for a duration of 10 minutes if the tag was applied, if after 10 minutes it wasn't the test fails.
        $seconds_tried = 0
        while($seconds_tried -lt 600){
            # Get the VM from azure
            $vm = Get-AzVm -Name "Test-VM" -ResourceGroupName "Test-VM"

            # Check if tags are applied
            if($vm.Tags.Count -gt 0){
                # Exit the loop
                break
            }

            # Wait for 10 seconds
            Start-Sleep -Seconds 10
            $seconds_tried += 10
        }

        # Test the tag
        $vm.Tags.LoadbalancedVM | Should -Be "yes"
    }
}