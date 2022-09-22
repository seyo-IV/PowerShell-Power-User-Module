<#
.SYNOPSIS
  This script generates a list of NTFS-Permissions.
.DESCRIPTION
  Show NTFS-Permissions
.PARAMETER Path
  Path to scan to.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  perm -Path \\server\share
  perm C:\temp
#>

function perm {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Path
        )
    
            $ErrorActionPreference = "SilentlyContinue"
            $Folders = $Path -Split "\\"
            $Plist = $Folders | ForEach-Object { $i = 0 } { $Folders[0..$i] -Join "\" -Replace ":$", ":\"; $i++ }
            $FList   = foreach($dir in $Plist){
            
            Resolve-Path -Path $dir
            Get-Item $dir | Select-Object FullName
            Get-Acl -Path $dir -Filter Access | Select-Object -ExpandProperty Access
            }
        
          $Flist | Format-Table FullName, IdentityReference, FileSystemRights
    
}