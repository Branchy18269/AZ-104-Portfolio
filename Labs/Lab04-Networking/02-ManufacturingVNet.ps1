<#
.SYNOPSIS
    AZ-104 Lab 04 Task 2: Create ManufacturingVnet
    Method: PowerShell (Replacing JSON Template)
#>
$RG = "az104-rg4"
$Loc = "EastUS"
$VNetName = "ManufacturingVnet"

# 1. Define Subnets (4 Subnets as per requirements)
$Subnets = @(
    (New-AzVirtualNetworkSubnetConfig -Name "ManufacturingSystemSubnet" -AddressPrefix "10.30.10.0/24"),
    (New-AzVirtualNetworkSubnetConfig -Name "SensorSubnet1" -AddressPrefix "10.30.20.0/24"),
    (New-AzVirtualNetworkSubnetConfig -Name "SensorSubnet2" -AddressPrefix "10.30.21.0/24"),
    (New-AzVirtualNetworkSubnetConfig -Name "SensorSubnet3" -AddressPrefix "10.30.22.0/24")
)

# 2. Create or Verify VNet
$VNet = Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RG -ErrorAction SilentlyContinue
if ($null -eq $VNet) {
    Write-Host "Creating $VNetName..." -ForegroundColor Cyan
    New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RG -Location $Loc -AddressPrefix "10.30.0.0/16" -Subnet $Subnets
} else {
    Write-Host "$VNetName already exists. Skipping." -ForegroundColor Green
}