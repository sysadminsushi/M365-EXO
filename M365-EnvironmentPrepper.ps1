<#
.SYNOPSIS
    Prepares a clean PowerShell 7 environment for 365, Azure, and Teams automation.

.DESCRIPTION
    Installs Microsoft 365, Graph, Az, and Teams modules in a predictable,
    automation‑friendly manner suitable for Exchange Online, Graph, AVD, and Teams workflows.

.NOTES
    Author: sysadminsushi
    Version: 3.1.2026
#>

# installs Exchange Online Management 3.3 for stable authentication and predictable automation behavior
function Install-ExchangeOnlineManagementModule {
    Install-Module ExchangeOnlineManagement -RequiredVersion 3.3.0 -Force -SkipPublisherCheck
}

# installs Microsoft Graph meta‑module to ensure all Graph components are available
function Install-MicrosoftGraphModule {
    Install-Module Microsoft.Graph -Scope AllUsers -AllowClobber
}

# installs Az modules required for authentication and Azure Virtual Desktop automation
function Install-AzModulesForAutomation {
    Install-Module Az.Accounts -Scope CurrentUser -Force -AllowClobber
    Install-Module Az.Resources -Scope CurrentUser -Force -AllowClobber
    Install-Module Az.DesktopVirtualization -Scope CurrentUser -Force -AllowClobber
}

# installs Microsoft Teams module for Teams policy, voice, and org-wide administration
function Install-MicrosoftTeamsModule {
    Install-Module MicrosoftTeams -Scope AllUsers -Force -AllowClobber
}

# displays installed module versions for verification
function Show-InstalledModuleVersions {
    "EXO: $((Get-Module ExchangeOnlineManagement -ListAvailable | Select-Object -First 1).Version)"
    "Graph: $((Get-Module Microsoft.Graph -ListAvailable | Select-Object -First 1).Version)"
    "Teams: $((Get-Module MicrosoftTeams -ListAvailable | Select-Object -First 1).Version)"
    "Az.Accounts: $((Get-Module Az.Accounts -ListAvailable | Select-Object -First 1).Version)"
    "Az.Resources: $((Get-Module Az.Resources -ListAvailable | Select-Object -First 1).Version)"
    "Az.DesktopVirtualization: $((Get-Module Az.DesktopVirtualization -ListAvailable | Select-Object -First 1).Version)"
}

# orchestrates the full module installation workflow
function Invoke-PrepM365AdminEnvironment {
    Install-ExchangeOnlineManagementModule
    Install-MicrosoftGraphModule
    Install-AzModulesForAutomation
    Install-MicrosoftTeamsModule
    Show-InstalledModuleVersions
}

# Script runner
Invoke-PrepM365AdminEnvironment