<#
.SYNOPSIS
  Adaptation of the touch command of Linux.
.DESCRIPTION
  Create any kind of files with one command.
.PARAMETER File
  Name of file.
.PARAMETER Path
  Path of file.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  chown randomlocal C:\temp
  chown Domain\jon.doe C:\temp
#>

function netinfo {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [int]$Port,
    [Parameter(Mandatory = $false)]
    [string]$ProcessName
  )

  if ($Port -ne "") {
    # Get a list of active TCP connections, including Listening and Established states
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' -or $_.State -eq 'Established' }

    # If a port is specified, filter the connections
    if ($Port) {
      $connections = $connections | Where-Object { $_.LocalPort -eq $Port }
    }
  
    # For each connection, retrieve the process name using the process ID
    $connections | ForEach-Object {
      $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
      [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        ProcessName   = if ($proc) { $proc.ProcessName } else { 'Unknown' }
        ProcessId     = $_.OwningProcess
      }
    } | Format-Table -AutoSize
  }

  if ($ProcessName -ne "") {
    # Get a list of active TCP connections, including Listening and Established states
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' -or $_.State -eq 'Established' }

    # For each connection, retrieve the process name using the process ID
    $connections = $connections | ForEach-Object {
      $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
      [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        ProcessName   = if ($proc) { $proc.ProcessName } else { 'Unknown' }
        ProcessId     = $_.OwningProcess
      }
    }

    # Filter by process name if specified
    if ($ProcessName) {
      $connections = $connections | Where-Object { $_.ProcessName -like "*$ProcessName*" }
    }

    # Output the results in table format
    $connections | Format-Table -AutoSize
  }

  if (($Port -eq "") -and ($ProcessName -eq "")) {
    # Get a list of active TCP connections, including Listening and Established states
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' -or $_.State -eq 'Established' }

    # For each connection, retrieve the process name using the process ID
    $connections | ForEach-Object {
      $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
      [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        ProcessName   = if ($proc) { $proc.ProcessName } else { 'Unknown' }
        ProcessId     = $_.OwningProcess
      }
    } | Format-Table -AutoSize
  }
}