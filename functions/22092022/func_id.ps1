<#
.SYNOPSIS
  A try of adaptation of the "id" command from Linux.
.DESCRIPTION
  Show User/Group infos.
.PARAMETER Name
  Name (Can be "me" or of a local or domain user).
.PARAMETER Scope
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
