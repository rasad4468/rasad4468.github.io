# Install Hyper-V Role
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart

# Define a new virtual switch
$switchName = "ExternalSwitch"
$netAdapterName = "Ethernet0"

# Create the virtual switch
New-VMSwitch -Name $switchName -NetAdapterName $netAdapterName -AllowManagementOS $true
