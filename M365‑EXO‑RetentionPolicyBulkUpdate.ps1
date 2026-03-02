<#
.SYNOPSIS
    M365‑EXO‑RetentionPolicyBulkUpdate.ps1
    Updates all mailboxes assigned to a specific retention policy.

.DESCRIPTION
    Searches for all mailboxes currently using a defined retention policy and updates
    them to a new target policy. Each updated mailbox is written to output for
    visibility and logging. This script is intended for bulk remediation or policy
    realignment tasks in Exchange Online.

.NOTES
    Author: sysadminsushi
    Version: 3.1.2026
#>

# User-defined variables
$CurrentRetentionPolicyName = "Default MRM Policy"
$NewRetentionPolicyName     = "New Policy"

# Retrieves all mailboxes currently using the old policy
function Get-MailboxesUsingCurrentPolicy {
    Get-Mailbox -ResultSize Unlimited |
        Where-Object { $_.RetentionPolicy -eq $CurrentRetentionPolicyName }
}

# Applies the new retention policy to a single mailbox
function Update-MailboxRetentionPolicy {
    param(
        [Parameter(Mandatory = $true)]
        $MailboxObject
    )

    Set-Mailbox -Identity $MailboxObject.Identity -RetentionPolicy $NewRetentionPolicyName
    Write-Output "Updated retention policy for: $($MailboxObject.DisplayName)"
}

# Coordinates the full update workflow
function Invoke-RetentionPolicyBulkUpdate {
    $MailboxesToUpdate = Get-MailboxesUsingCurrentPolicy

    foreach ($Mailbox in $MailboxesToUpdate) {
        Update-MailboxRetentionPolicy -MailboxObject $Mailbox
    }
}

# Script runner
Invoke-RetentionPolicyBulkUpdate