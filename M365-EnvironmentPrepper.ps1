<#
.SYNOPSIS
    Prepares a clean PowerShell 7 environment for M365 automation.

.DESCRIPTION
    Installs required Microsoft 365 modules in PowerShell 7.

.NOTES
    Author: sysadminsushi
    Version: 1.1
    License: MIT License
#>

Write-Output "=== Preparing PowerShell 7 Environment for M365 Automation ==="

Install-Module ExchangeOnlineManagement -RequiredVersion 3.3.0 -Force
Install-Module Microsoft.Graph -Force

Write-Output "=== Environment Preparation Complete ==="