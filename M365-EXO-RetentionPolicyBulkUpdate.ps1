<#
.SYNOPSIS
    M365-EXO-RetentionPolicyBulkUpdate.ps1
    Updates all mailboxes assigned to a specific retention policy.

.DESCRIPTION
    Searches for all mailboxes currently using a defined retention policy and updates
    them to a new target policy. Each updated mailbox is written to output for
    visibility and logging. This script is intended for bulk remediation or policy
    realignment tasks in Exchange Online.

.NOTES
    Author: sysadminsushi
    Version: 1.19.2026
    License: MIT License (see LICENSE file in repository)
#>

# -----------------------------
# User-Defined Script Variables
# -----------------------------
$CurrentPolicy = "Default MRM Policy"
$NewPolicy     = "New Policy"

# -----------------------------
# Update Retention Policies
# -----------------------------
Get-Mailbox -ResultSize Unlimited |
    Where-Object { $_.RetentionPolicy -eq $CurrentPolicy } |
    ForEach-Object {
        Set-Mailbox -Identity $_.Identity -RetentionPolicy $NewPolicy
        Write-Output "Updated retention policy for: $($_.DisplayName)"
    }
