<#
.SYNOPSIS
  Adaptation of the wc command of Linux.
.DESCRIPTION
  Count words in a plain text file.
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
  wc C:\temp\file
#>

function wc {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Path
        )
        $WordCount = Get-Content $Path | Measure-Object -Word
        $File = Get-ChildItem $Path

        $Table =  New-Object PSCustomObject -Property @{
            "Path" = $File.FullName;
            "Name" = $File.Name;
            "LastWriteTime" = $File.LastWriteTime;
            "Mode" = $File.Mode;
            "Count" = $WordCount.Words;
        }
        $Table | Select-Object Path, Name, LastWriteTime, Mode, Count | Format-Table
}