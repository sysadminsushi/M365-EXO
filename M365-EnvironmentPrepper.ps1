<#
.SYNOPSIS
    Prepares a clean PowerShell 7 environment for M365 automation.

.DESCRIPTION
    Installs required Microsoft 365 modules in PowerShell 7.

.NOTES
    Author: sysadminsushi
    Version: 1.2
    License: MIT License
#>

Write-Output "=== Preparing PowerShell 7 Environment for M365 Automation ==="

<#
Installing ExchangeOnlineManagement 3.3 ensures compatibility with legacy
workflows that haven’t yet been updated for the newer 3.4+ authentication
changes. Version 3.3 delivers the modern EXO V3 cmdlets without introducing
the stricter dependency shifts and MSAL behavior seen in later releases,
making it the most stable choice for environments that need reliability,
predictable auth, and minimal surprises during automation.
#>
Install-Module ExchangeOnlineManagement -RequiredVersion 3.3.0 -Force

<#
This meta‑module brings in the authentication module and all submodules
(Users, Groups, Identity.SignIns, Users.Actions, etc.). You don’t need
to install each one separately.
#>
Install-Module Microsoft.Graph -Scope AllUsers -AllowClobber

Write-Output "=== Environment Preparation Complete ==="

