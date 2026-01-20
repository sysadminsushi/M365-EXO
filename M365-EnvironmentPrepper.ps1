<#
.SYNOPSIS
    Prepares a clean PowerShell 7 environment for 365/Azure automation.

.DESCRIPTION
    Installs required Microsoft 365 modules in PowerShell 7.

.NOTES
    Author: sysadminsushi
    Version: 1.19.2026
    License: MIT License
#>

<#
Installing ExchangeOnlineManagement 3.3 for stability. It provides
modern EXO V3 cmdlets while avoiding the stricter MSAL dependency
shifts introduced in v3.4+, ensuring predictable authentication and
compatibility for legacy automation workflows.
#>
Install-Module ExchangeOnlineManagement -RequiredVersion 3.3.0 -Force -SkipPublisherCheck

<#
Microsoft.Graph is a meta-module that automatically includes all
submodules (Users, Groups, Identity, etc.). Installing this single
package ensures all necessary authentication and functional
components are available without needing to manage individual
Graph modules separately.
#>
Install-Module Microsoft.Graph -Scope AllUsers -AllowClobber

<#
Az.Accounts provides authentication for all Az modules.
Az.DesktopVirtualization provides AVD cmdlets such as:
    - Get-AzWvdUserSession
    - Get-AzWvdHostPool
    - Get-AzWvdSessionHost
These are required for AVD session reporting scripts.
#>
Install-Module Az.Accounts -Scope CurrentUser -Force -AllowClobber
Install-Module Az.Resources -Scope CurrentUser -Force -AllowClobber
Install-Module Az.DesktopVirtualization -Scope CurrentUser -Force -AllowClobber

# Display installed versions for quick verification
"EXO:   $((Get-Module ExchangeOnlineManagement -ListAvailable).Version)"
"Graph: $((Get-Module Microsoft.Graph -ListAvailable).Version)"
"Az.Accounts: $((Get-Module Az.Accounts -ListAvailable).Version)"
"Az.DesktopVirtualization: $((Get-Module Az.DesktopVirtualization -ListAvailable).Version)"

