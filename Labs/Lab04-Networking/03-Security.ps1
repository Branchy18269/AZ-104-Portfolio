<#
.SYNOPSIS
    AZ-104 Lab 04 Task 3: Configure ASG and NSG
    Method: PowerShell (Replacing Manual Creation)
#>
$RG = "az104-rg4"
$Loc = "EastUS"

# 1. Create Application Security Group (ASG)
$ASGName = "asg-web"
if (-not (Get-AzApplicationSecurityGroup -Name $ASGName -ResourceGroupName $RG -ErrorAction SilentlyContinue)) {
    Write-Host "Creating ASG..." -ForegroundColor Cyan
    $ASG = New-AzApplicationSecurityGroup -Name $ASGName -ResourceGroupName $RG -Location $Loc
} else {
    $ASG = Get-AzApplicationSecurityGroup -Name $ASGName -ResourceGroupName $RG
    Write-Host "ASG exists." -ForegroundColor Green
}

# 2. Create NSG with Rules
$NSGName = "myNSGSecure"
if (-not (Get-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $RG -ErrorAction SilentlyContinue)) {
    Write-Host "Creating NSG and Rules..." -ForegroundColor Cyan
    
    $Rule1 = New-AzNetworkSecurityRuleConfig -Name "AllowASG" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceApplicationSecurityGroup $ASG.Id -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80,443
    $Rule2 = New-AzNetworkSecurityRuleConfig -Name "DenyInternetOutbound" -Access Deny -Protocol * -Direction Outbound -Priority 4096 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix Internet -DestinationPortRange *
    
    $NSG = New-AzNetworkSecurityGroup -ResourceGroupName $RG -Location $Loc -Name $NSGName -SecurityRules $Rule1, $Rule2
} else {
    $NSG = Get-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $RG
    Write-Host "NSG exists." -ForegroundColor Green
}

# 3. Associate NSG to Core VNet Subnet
$VNet = Get-AzVirtualNetwork -Name "CoreServicesVnet" -ResourceGroupName $RG
$Subnet = $VNet.Subnets | Where-Object {$_.Name -eq "SharedServicesSubnet"}

if ($Subnet.NetworkSecurityGroup.Id -ne $NSG.Id) {
    Write-Host "Linking NSG to Subnet..." -ForegroundColor Yellow
    $Subnet.NetworkSecurityGroup = $NSG
    Set-AzVirtualNetwork -VirtualNetwork $VNet
} else {
    Write-Host "NSG is already linked to Subnet." -ForegroundColor Green
}