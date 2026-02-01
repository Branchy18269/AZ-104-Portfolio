<#
.SYNOPSIS
    AZ-104 Lab 04 Task 1: Create CoreServicesVnet
    Method: PowerShell (Replacing Portal Manual Entry)
#>
$RG = "az104-rg4"
$Loc = "EastUS"
$VNetName = "CoreServicesVnet"

# 1. Ensure Resource Group Exists
if (-not (Get-AzResourceGroup -Name $RG -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $RG -Location $Loc
}

# 2. Define Subnets
$Subnets = @(
    (New-AzVirtualNetworkSubnetConfig -Name "SharedServicesSubnet" -AddressPrefix "10.20.10.0/24"),
    (New-AzVirtualNetworkSubnetConfig -Name "DatabaseSubnet" -AddressPrefix "10.20.20.0/24")
)

# 3. Create or Verify VNet
$VNet = Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RG -ErrorAction SilentlyContinue
if ($null -eq $VNet) {
    Write-Host "Creating $VNetName..." -ForegroundColor Cyan
    New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RG -Location $Loc -AddressPrefix "10.20.0.0/16" -Subnet $Subnets
} else {
    Write-Host "$VNetName already exists. Skipping." -ForegroundColor Green
}