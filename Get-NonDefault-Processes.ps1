<#
.SYNOPSIS
  A script to get all non-default processes on a Windows machine.

.NOTES
  Version:        1.0
  Author:         selmankon
  Creation Date:  2024-02-24
#>

param (
    [switch]$Detail,
    [switch]$Unique
)

$blacklistPaths = @(
    "c:\program files (x86)\microsoft",
    "c:\program files\microsoft",
    "c:\program files\windowsapps",
    "c:\windows\"
)

$usersPath = Get-ChildItem -Path C:\Users -Directory
foreach ($user in $usersPath) {
    $blacklistPaths += "C:\Users\$($user.Name)\AppData\Local\Microsoft"
}

$processes = Get-WmiObject Win32_Process

$filteredProcesses = @()

foreach ($process in $processes) {
    $executablePath = $process.ExecutablePath

    if ($executablePath) {
        $isBlacklisted = $false
        foreach ($path in $blacklistPaths) {
            if ($executablePath.ToLower().Contains($path.ToLower())) {
                $isBlacklisted = $true
                break
            }
        }

        if (-not $isBlacklisted) {
            $fileDetails = Get-ItemProperty -Path $executablePath -ErrorAction SilentlyContinue

            if ($fileDetails -and ($fileDetails.Company -notmatch '(?i)Microsoft Corporation')) {
                $filteredProcesses += $process
            }
        }
    }
}

if ($Unique) {
    $filteredProcesses = $filteredProcesses | Group-Object -Property Name | ForEach-Object { $_.Group | Select-Object -First 1 }
}

if ($Detail) {
    $filteredProcesses | Format-List *
} else {
    $filteredProcesses | Select-Object Name, ExecutablePath, Description | Format-Table -AutoSize
}
