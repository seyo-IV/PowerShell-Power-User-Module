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

<#
.SYNOPSIS
  A try of adaptation of the "id" command from Linux.
.DESCRIPTION
  Show User/Group infos.
.PARAMETER Path
  Name (Can be "me" or of a local or domain user).
  Scope (Can be Local or AD).
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  id me local
  id jon.doe ad
#>

function id {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [Parameter(Mandatory=$True)]
        [string]$Scope
        )
        $ErrorActionPreference = "SilentlyContinue"
        $Groups = @()
        If($Name -eq "me"){
            If($Scope -eq "Local"){
                $User = Get-LocalUser -Name $Env:USERNAME
                $GroupList = Get-LocalGroup
                foreach($Group in $GroupList){
                    $GroupMember = Get-LocalGroupMember -Name $Group
                    $GroupMember = Split-Path -Path $GroupMember.Name -Leaf
                    if($GroupMember -match $user){
                        [array]$Groups = $Groups + $Group
                    }
                }
                    $User | Select-Object Name, FullName, Enabled, SID | Format-Table -AutoSize
                    $Groups
            }
            elseif($Scope -eq "AD"){
                $User = Get-ADUser -SamAccountName $Env:USERNAME -Properties *
                $Groups = Get-ADPrincipalGroupMembership $User.SamAccountName
                    $User | Select-Object Name, FullName, Enabled, SID | Format-Table -AutoSize
                    $Groups | Select-Object Name, SamAccountName, Description
            }
        }
        elseif($Name -ne "me"){
            If($Scope -eq "Local"){
                    $User = Get-LocalUser -Name $Name
                    $GroupList = Get-LocalGroup
                    foreach($Group in $GroupList){
                        $GroupMember = Get-LocalGroupMember -Name $Group
                        if($GroupMember -match $user){
                            [array]$Groups = $Groups + $Group
                        }
                    }
                        $User | Select-Object Name, FullName, Enabled, SID | Format-Table -AutoSize
                        $Groups
            }
            elseif($Scope -eq "AD"){
                $User = Get-ADUser -SamAccountName $Name -Properties *
                $Groups = Get-ADPrincipalGroupMembership $User.SamAccountName
                    $User | Select-Object Name, FullName, Enabled, SID | Format-Table -AutoSize
                    $Groups | Select-Object Name, SamAccountName, Description
            }  
        }
}


<#
.SYNOPSIS
  Adaptation of the grep program from Linux.
.DESCRIPTION
  Search for pattern in plain text files only.
.PARAMETER Path
  Find, pattern to look for.
  Path, where to start searching.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  fgrep 123 C:\temp
  fgrep -Find 123 -Path \\Server\Share
#>
function fgrep {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Find,
        [Parameter(Mandatory=$True)]
        [string]$Path
        )
    $AllFiles = Get-ChildItem -Path $Path -Recurse -File # | Select-String -pattern $find | Group-Object Path | Select-Object Name
    foreach($File in $AllFiles){
        $Finder = 0
        $Finder = Get-ChildItem $File.FullName | Select-String -pattern $Find
        if($Finder){
            $Finder = $Finder -split ":"
            $FinderPath = $Finder[0]+":"+$Finder[1]
            $Line = $Finder[2]
            $Pattern = Get-Content $File.FullName | Select-Object -Index $([int]$Line - 1)

            $Found = New-Object PSCustomObject -Property @{
                "File" = $FinderPath;
                "Line" = $Line;
                "Text" = $Pattern;
            }
            $Found | Select-Object File, Line, Text | Format-Table
        }
    }
}