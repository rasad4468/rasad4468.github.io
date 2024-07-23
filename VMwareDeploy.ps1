# Connect to vCenter
$vCenterServer = "your_vcenter_server"
$vcUser = "your_vc_username"
$vcPassword = "your_vc_password"
Connect-VIServer -Server $vCenterServer -User $vcUser -Password $vcPassword

# Create a new Datacenter
$datacenterName = "MyDatacenter"
New-Datacenter -Name $datacenterName

# Add an ESXi host to the datacenter
$esxiHost = "your_esxi_host"
$esxiUser = "your_esxi_username"
$esxiPassword = "your_esxi_password"
Add-VMHost -Name $esxiHost -Location $datacenterName -User $esxiUser -Password $esxiPassword


#Replace the placeholders with your actual server names, usernames, and passwords.
