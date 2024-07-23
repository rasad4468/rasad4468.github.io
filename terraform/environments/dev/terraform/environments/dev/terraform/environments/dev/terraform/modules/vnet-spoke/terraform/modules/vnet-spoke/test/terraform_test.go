package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/gruntwork-io/terratest/modules/azure"
    "github.com/stretchr/testify/assert"
)

func TestTerraformAzure(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
        // Path to the directory that contains your Terraform code
        TerraformDir: "../terraform/environments/dev",

        // Variables to pass to the Terraform code using -var options
        Vars: map[string]interface{}{
            "resource_group_name": "rg-bxcz-demo-hub-southcentralus",
            "location":            "southcentralus",
            "spoke_vnet_name":     "default-spoke",
        },

        // Disable colors in Terraform commands so its easier to parse stdout/stderr
        NoColor: true,
    }

    // Clean up resources with "terraform destroy" at the end of the test
    defer terraform.Destroy(t, terraformOptions)

    // Run "terraform init" and "terraform apply". Fail the test if there are any errors.
    terraform.InitAndApply(t, terraformOptions)

    // Get output values
    hubVnetID := terraform.Output(t, terraformOptions, "hub_virtual_network_id")
    spokeVnetID := terraform.Output(t, terraformOptions, "vnet_spoke_id")
    bastionHostID := terraform.Output(t, terraformOptions, "bastion_host_id")

    // Check that the Hub VNet exists
    assert.True(t, azure.VirtualNetworkExists(t, "southcentralus", hubVnetID))

    // Check that the Spoke VNet exists
    assert.True(t, azure.VirtualNetworkExists(t, "southcentralus", spokeVnetID))

    // Check that the Bastion Host exists
    assert.True(t, azure.BastionHostExists(t, "southcentralus", bastionHostID))
}
