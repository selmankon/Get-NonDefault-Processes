$blacklistPaths = @(
    "system32",
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

$filteredProcesses | Format-List *
