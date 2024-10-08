Function Invoke-SyncServices {
    Param(
    ) Process {
        $RequiredServices = Get-CyberAwareServices
        return Invoke-CreateServices $RequiredServices "https://meetgradient.com" "phil.flamingo@meetgradient.com"
    }
}