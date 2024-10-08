function Test-CyberAwareAPI {
    $url = "$($Env:BASE_URL)/$($Env:API_KEY)/get-me"
    $headers = @{
        'accept' = 'application/json';
    }
    Write-Host $url

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method 'GET'
        Write-Host "API communication successful. User: $($response.name)" -ForegroundColor Green
    }
    catch {
        throw "API test failed: $_"
    }
}

function Get-CyberAwareAccounts {
    $url = "$ENV:BASE_URL/$ENV:API_KEY/get-clients"
    $headers = @{
        'accept' = 'application/json';
    }

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method 'GET'
        if (-not $response.clients -or $response.clients.Count -eq 0) {
            throw "No clients found in response."
        }

        $ClientSummary = @{}
        foreach ($client in $response.clients) {
            $ClientDetails = @{
                id = $client.id
                name = $client.client_name
            }
            Write-Host "Account synced: $($client.client_name) - $($client.id)" -ForegroundColor Green
            $ClientSummary[$ClientDetails.id] = $ClientDetails
        }
        return $ClientSummary
    }
    catch {
        throw "Failed to retrieve clients: $_"
    }
}

#  Static list of CyberAware services. This list includes `free`, `lite`, and `pro` service tiers.
function Get-CyberAwareServices {
    Process {
        $Services = @(
            @{
                Name = 'Free'
                Description = 'Basic resources including posters, templates, and a Cyber Risk Dashboard.'
                Category = 'security'
                Subcategory = 'privacy and security awareness training'
            },
            @{
                Name = 'Lite'
                Description = 'Includes Cyber Health Checks, Dashboards, Posters, and Training.'
                Category = 'security'
                Subcategory = 'privacy and security awareness training'
            },
            @{
                Name = 'Pro'
                Description = 'Comprehensive services with simulations, templates, and automated training.'
                Category = 'security'
                Subcategory = 'privacy and security awareness training'
            }
        )
        foreach ($service in $Services){
            Write-Host "Service created: $($service.Name) - $($service.Description)" -ForegroundColor Green
        }

        return $Services
    }
}

function Get-CyberAwareClientUsage {
    $url = "$ENV:BASE_URL/$ENV:API_KEY/get-usage"
    $headers = @{
        'accept' = 'application/json';
    }

    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method 'GET'

#       # Check if 'client_usage' exists and is a valid array
        if (-not $response.client_usage -or $response.client_usage.Count -eq 0) {
            throw "No client data found in response."
        }

        # Ensure 'client_usage' is treated as an array
        $clientUsageArray = [System.Collections.ArrayList]@($response.client_usage)

        $UsageSummary = @{}

        foreach ($client in $clientUsageArray) {
            $clientObject = [PSCustomObject]$client
            $ClientUsage = @{
                id        = $clientObject.id
                name      = $clientObject.client_name
                type      = $clientObject.type
                learners  = $clientObject.learners
                maximum   = $clientObject.max_learners
            }
            $UsageSummary[$ClientUsage.id] = $ClientUsage
        }

        return $UsageSummary
    }
    catch {
        throw "Failed to retrieve clients: $($_.Exception.Message)"
    }
}
