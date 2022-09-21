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

function chown {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [Parameter(Mandatory=$True)]
        [string]$Path
        )
        $Acl = Get-Acl $Path

        $Object = New-Object System.Security.Principal.Ntaccount($Name)

        $Acl.SetOwner($Object)

        $Acl | Set-Acl $Path
}