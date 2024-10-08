Function Invoke-SyncAccounts {
    Param() Process {
        $organizations = Get-CyberAwareAccounts
        return Invoke-CreateAccounts $organizations
    }
}

