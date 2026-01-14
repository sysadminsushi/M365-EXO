<#
.SYNOPSIS
M365-EXO-RetentionPolicyBulkUpdate.ps1
Updates all mailboxes assigned to a specific retention policy.

.DESCRIPTION
Searches for all mailboxes currently using a defined retention policy and updates
them to a new target policy. Outputs each mailbox updated for visibility and
logging. Intended for bulk remediation or policy realignment tasks in EXO.

.AUTHOR
sysadminsushi

.VERSION
2.0
#>

# -----------------------------
# User Defined Script Variables
# -----------------------------
$CurrentPolicy = "Default MRM Policy"
$NewPolicy     = "New Policy"
$UserUPN = "admin@companies.com"

# -----------------------------
# Connect to Exchange Online
# -----------------------------
Connect-ExchangeOnline -UserPrincipalName $UserUPN

# -----------------------------
# Update Retention Policies
# -----------------------------
Get-Mailbox -ResultSize Unlimited |
    Where-Object { $_.RetentionPolicy -eq $CurrentPolicy } |
    ForEach-Object {
        Set-Mailbox -Identity $_.Identity -RetentionPolicy $NewPolicy
        Write-Output "Updated retention policy for: $($_.DisplayName)"
    }

# -----------------------------
# Disconnect from Exchange Online
# -----------------------------
Disconnect-ExchangeOnline -Confirm:$false
