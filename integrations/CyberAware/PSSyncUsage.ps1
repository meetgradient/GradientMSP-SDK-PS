
Function Invoke-SyncUsage {
    Process {
        try {
            Write-Host 'Starting call'
            $ServiceIds = Invoke-GetServiceIds # Service IDs created in GradientMSP to associate to the correct Vendor Service
            $VendorAccounts = Get-CyberAwareAccounts
            $usageData = Get-CyberAwareClientUsage
            foreach ($Client in $VendorAccounts.GetEnumerator()) {
                $clientUsage = $usageData[$Client.Value.id]
                $learnerCount = [int]$clientUsage.learners
                if ($learnerCount -gt 0) {
                    Write-Host "$($clientUsage.name) : $($clientUsage.id) has $($learnerCount) seats on the $($clientUsage.type) plan, creating billing request..." -ForegroundColor Green
                    try {
                        $body = Initialize-PSCreateBillingRequest -ClientOId $null -AccountId $clientUsage.id -UnitCount $learnerCount
                        $body = $body | Select-Object -Property * -ExcludeProperty clientOId

                        # Write-Host "Billing body: $($body | ConvertTo-Json)"
                        # Talk to Gradient API to post request
                        $response = New-PSBilling $ServiceIds[$clientUsage.type] $body
                    } catch {
                        Write-Host "$_"
                    }
                } else {
                    Write-Host "$($clientUsage.name) does not have any active learners."
                }
            }
        } catch {
            Write-Host "We hit the catch block: $($_)" -ForegroundColor Red
        }
    }
}
