<#
.SYNOPSIS
  Adaptation of the touch command of Linux.
.DESCRIPTION
  create any kind of files with one command.
.PARAMETER Path
  Name of file.
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
  touch file C:\temp
#>

function touch {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [Parameter(Mandatory=$True)]
        [string]$Path
        )
        New-Item -ItemType File -Path $Path -Name $Name
}