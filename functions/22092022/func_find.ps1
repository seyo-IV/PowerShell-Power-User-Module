<#
.SYNOPSIS
  Adaptation of the find -f command of Linux.
.DESCRIPTION
  Search for any kind of files.
.PARAMETER Name
  Name of file.
.PARAMETER Path
  Path where to look for.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  find file C:\temp
#>

function find {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [Parameter(Mandatory=$True)]
        [string]$Path
        )
        Get-ChildItem $Path | Where-Object {$_.Name -like "*$Name*"}
}