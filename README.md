# Get-NonDefault-Processes
This PowerShell script detects and lists processes that run on Windows operating systems and are not considered "standard" processes. Non-standard processes typically refer to those not developed by Microsoft Corporation or residing outside standard system and program files folders. The script aids users in swiftly identifying unexpected or unidentified processes on their systems.

## Usage
Run the script without any parameters to get a list of non-standard processes with basic details:

```
./Get-NonDefault-Processes.ps1
```

To receive a detailed list of properties for each non-standard process, use the -Detail parameter:
```
./Get-NonDefault-Processes.ps1 -Detail
```

To eliminate duplicate processes from the output and display a unique list, use the -Unique parameter:
```
./Get-NonDefault-Processes.ps1 -Unique
```
- Direct Execution Alternative

You can also directly execute the core logic of the script (lines 5 to 41) in your PowerShell session and then use either `$filteredProcesses | Format-List *` for a detailed view or `$filteredProcesses | Select-Object Name, ExecutablePath, Description | Format-Table -AutoSize` for a summarized view. This method can sometimes circumvent execution policy restrictions (though it may seem unconventional and funny).
