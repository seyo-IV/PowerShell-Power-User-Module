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