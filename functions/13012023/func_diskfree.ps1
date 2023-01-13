<#
.SYNOPSIS
  df -h for noobs.
.DESCRIPTION
  Get disk/volume info.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  diskfree
#>

function diskfree {
    [CmdletBinding()]
    param()
        $Drives = Get-PSProvider FileSystem | Select-Object * -ExpandProperty Drives -ErrorAction "SilentlyContinue"
        $Drives = $Drives | Where-Object { $_.Name –ne "Temp" }
        foreach($Drive in $Drives){
          Get-Volume $Drive.Name
        }
}