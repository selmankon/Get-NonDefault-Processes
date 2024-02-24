# Get-NonDefault-Processes

This PowerShell script detects and lists processes that run on Windows operating systems that are not considered "standard" processes. Non-standard processes are usually processes that have not been developed by Microsoft Corporation or contain executable files that are not included in the system and program files folders. Script helps users quickly detect unexpected or unidentified processes on their systems.

## Usage
Nothing special. 😏
```
./Get-NonDefault-Processes.ps1
```
```
./Get-NonDefault-Processes.ps1 -Detail
```
You can also copy lines 5 to 41 and run it by typing `$filteredProcesses | Format-List *` or `$filteredProcesses | Select-Object Name, ExecutablePath, Description | Format-Table -AutoSize`. 
Sometimes it is a good method to avoid execution policy. (even though it looks funny.)
