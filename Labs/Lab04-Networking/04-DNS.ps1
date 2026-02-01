<#
.SYNOPSIS
    AZ-104 Lab 04 Task 4: DNS Configuration
    Method: PowerShell (Replacing Manual DNS Entry)
#>
$RG = "az104-rg4"
$PublicDomain = "bigshlong.com"
$PrivateDomain = "private.bigshlong.com"

# 1. Public DNS
if (-not (Get-AzDnsZone -Name $PublicDomain -ResourceGroupName $RG -ErrorAction SilentlyContinue)) {
    Write-Host "Creating Public Zone: $PublicDomain" -ForegroundColor Cyan
    New-AzDnsZone -Name $PublicDomain -ResourceGroupName $RG
}
# Create 'www' Record
$Record = Get-AzDnsRecordSet -Name "www" -RecordType A -ZoneName $PublicDomain -ResourceGroupName $RG -ErrorAction SilentlyContinue
if (-not $Record) {
    New-AzDnsRecordSet -Name "www" -RecordType A -ZoneName $PublicDomain -ResourceGroupName $RG -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -IPv4Address "10.1.1.4")
}

# 2. Private DNS
if (-not (Get-AzPrivateDnsZone -Name $PrivateDomain -ResourceGroupName $RG -ErrorAction SilentlyContinue)) {
    Write-Host "Creating Private Zone: $PrivateDomain" -ForegroundColor Cyan
    New-AzPrivateDnsZone -Name $PrivateDomain -ResourceGroupName $RG
}

# 3. Link to Manufacturing VNet
$Link = Get-AzPrivateDnsZoneVirtualNetworkLink -Name "manufacturing-link" -ZoneName $PrivateDomain -ResourceGroupName $RG -ErrorAction SilentlyContinue
if (-not $Link) {
    Write-Host "Linking Private Zone to ManufacturingVnet..." -ForegroundColor Yellow
    $VNet = Get-AzVirtualNetwork -Name "ManufacturingVnet" -ResourceGroupName $RG
    New-AzPrivateDnsZoneVirtualNetworkLink -Name "manufacturing-link" -ZoneName $PrivateDomain -ResourceGroupName $RG -VirtualNetworkId $VNet.Id -EnableRegistration
} else {
    Write-Host "VNet Link exists." -ForegroundColor Green
}