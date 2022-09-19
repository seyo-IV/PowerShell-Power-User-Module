<#
.SYNOPSIS
  Adaptation of the top program from Linux.
.DESCRIPTION
  Show running processes.
.PARAMETER Path
  EntryNumber for max Rows to show in screen.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  top 20
  top -EntryNumber 19
#>

function top {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$EntryNumber
      )
  while($true) {
      Get-Process | Sort-Object -Descending CPU | Select-Object -First $EntryNumber | Format-Table -AutoSize
      Start-Sleep -Seconds 1
      Clear-Host
  }
}
