<#
.SYNOPSIS
  Adds or removes permissions.
.DESCRIPTION
  Add/Remove NTFS ACLs.
.PARAMETER Staus
  Specifies the status. 
.PARAMETER Mode
  Specifies the mode.
.PARAMETER Name
  Specifies the user/group name. 
.PARAMETER Path
  Specifies the file name. 
.PARAMETER Access
  Specifies the Access.

.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  chperm add m Username C:\temp allow
  chperm remove f YOUR-DOMAIN\Group C:\temp\file deny
#>
function chperm {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Status,
        [Parameter(Mandatory=$True)]
        [string]$Mode,
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [Parameter(Mandatory=$True)]
        [string]$Path,
        [Parameter(Mandatory=$True)]
        [string]$Access
        )
        if($Status -eq "add"){
          if($Mode -eq "r"){
            $ModeSet = "Read"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "w"){
            $ModeSet = "Write"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "x"){
            $ModeSet = "ReadAndExecute"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "m"){
            $ModeSet = "Modify"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "f"){
            $ModeSet = "FullControl"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.SetAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
        }
        if($Status -eq "remove"){
          if($Mode -eq "r"){
            $ModeSet = "Read"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)

              $Acl | Set-Acl $Path
            }
          }
          if($Mode -eq "w"){
            $ModeSet = "Write"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)

              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
                            
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "x"){
            $ModeSet = "ReadAndExecute"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "m"){
            $ModeSet = "Modify"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
          if($Mode -eq "f"){
            $ModeSet = "FullControl"
            if($Access -eq "Allow"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path             
            }
            elseif($Access -eq "Deny"){
              $Acl = Get-Acl $Path

              $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
              
              $Acl.RemoveAccessRule($AccessRule)
              
              $Acl | Set-Acl $Path  
            }
          }
        }
}