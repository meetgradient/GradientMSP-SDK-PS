#
# API Documentation
# Howdy! Looks like you've found our open API documentation! Take a gander, and while you're at it feel free to take some endpoints for a spin.
# Version: 1.0
# Generated by OpenAPI Generator: https://openapi-generator.tech
#

<#
.SYNOPSIS

No summary available.

.DESCRIPTION

No description available.

.PARAMETER ClientOId
DEPRECATED - Use accountId instead: Client Id provided by Gradient.
.PARAMETER AccountId
Unique Id provided by Vendor. Will be required for future versions.
.PARAMETER UnitCount
No description available.
.OUTPUTS

CreateBillingRequest<PSCustomObject>
#>

function Initialize-PSCreateBillingRequest {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipelineByPropertyName = $true)]
        [String]
        ${ClientOId},
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)]
        [String]
        ${AccountId},
        [Parameter(Position = 2, ValueFromPipelineByPropertyName = $true)]
        [Decimal]
        ${UnitCount},
        # This was added and will be deleted when regenerated.
        [String]
        ${UnitType}
    )

    Process {
        'Creating PSCustomObject: PSGradient => PSCreateBillingRequest' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug
        if ($null -eq $UnitCount) {
            throw "invalid value for 'UnitCount', 'UnitCount' cannot be null."
        }

        # This was added and will be deleted when SDK is regenerated
        if ($null -ne $attributes -and $attributes.ContainsKey('STORAGE_UNIT_TYPE') -and $UnitType -eq "bytes") {
            $UnitCount = Convert-BytesToUnit $attributes['STORAGE_UNIT_TYPE'] $UnitCount
        }
        # End of code to be copied over when SDK is regenerated.

        $PSO = [PSCustomObject]@{
            "clientOId" = ${ClientOId}
            "accountId" = ${AccountId}
            "unitCount" = ${UnitCount}
        }


        return $PSO
    }
}

<#
.SYNOPSIS

Convert from JSON to CreateBillingRequest<PSCustomObject>

.DESCRIPTION

Convert from JSON to CreateBillingRequest<PSCustomObject>

.PARAMETER Json

Json object

.OUTPUTS

CreateBillingRequest<PSCustomObject>
#>
function ConvertFrom-PSJsonToCreateBillingRequest {
    Param(
        [AllowEmptyString()]
        [string]$Json
    )

    Process {
        'Converting JSON to PSCustomObject: PSGradient => PSCreateBillingRequest' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $JsonParameters = ConvertFrom-Json -InputObject $Json

        # check if Json contains properties not defined in PSCreateBillingRequest
        $AllProperties = ("clientOId", "accountId", "unitCount")
        foreach ($name in $JsonParameters.PsObject.Properties.Name) {
            if (!($AllProperties.Contains($name))) {
                throw "Error! JSON key '$name' not found in the properties: $($AllProperties)"
            }
        }

        If ([string]::IsNullOrEmpty($Json) -or $Json -eq "{}") {
            # empty json
            throw "Error! Empty JSON cannot be serialized due to the required property 'unitCount' missing."
        }

        if (!([bool]($JsonParameters.PSobject.Properties.name -match "unitCount"))) {
            throw "Error! JSON cannot be serialized due to the required property 'unitCount' missing."
        }
        else {
            $UnitCount = $JsonParameters.PSobject.Properties["unitCount"].value
        }

        if (!([bool]($JsonParameters.PSobject.Properties.name -match "clientOId"))) {
            #optional property not found
            $ClientOId = $null
        }
        else {
            $ClientOId = $JsonParameters.PSobject.Properties["clientOId"].value
        }

        if (!([bool]($JsonParameters.PSobject.Properties.name -match "accountId"))) {
            #optional property not found
            $AccountId = $null
        }
        else {
            $AccountId = $JsonParameters.PSobject.Properties["accountId"].value
        }

        $PSO = [PSCustomObject]@{
            "clientOId" = ${ClientOId}
            "accountId" = ${AccountId}
            "unitCount" = ${UnitCount}
        }

        return $PSO
    }

}

