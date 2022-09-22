<#
.SYNOPSIS
  Adaptation of the top program from Linux.
.DESCRIPTION
  Show running processes and Memory.
.PARAMETER EntryNumber
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

function diskusage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Select="All",
        [Parameter(Mandatory=$false)]
        [string]$Path=$PWD
        )

    if($Select -eq "All"){
        $Objects = @()
        
        $Items = Get-ChildItem $Path
        ForEach($Item in $Items){

          $CheckItem = Get-Item $Item.FullName
          if($CheckItem.Attributes -eq "Directory"){
            $Size = 0
            $sum = 0
            [IO.Directory]::Enumeratefiles($Item.FullName, '*', [IO.SearchOption]::AllDirectories).ForEach{$sum += [System.IO.FileInfo]::new($_).Length}
            $Size = "{0:N2}" -f ($sum / 1KB)
            
          }
          else{
            $SelectedItem = Get-ChildItem -Path $Item.FullName
            $Size = $SelectedItem | Measure-Object Length -Sum
            $Size = $Size.Sum/1KB
          }

            $Size = [math]::round($Size,5)

            $Name = $Item.Name
            $FilePath = $Item.FullName
            

            $Object = New-Object PSCustomObject -Property @{
                "Name" = $Name
                "Path" = $FilePath
                "Size" = $Size
            }
            $Objects += $Object
            
        }
        $Objects
      
    }
    if($Select -eq "select"){
      $Objects = @()
      $CheckItem = Get-Item $Path
      if($CheckItem.Attributes -eq "Directory")
      {
        
        $Size = 0
        $sum = 0
        [IO.Directory]::Enumeratefiles($CheckItem.FullName, '*', [IO.SearchOption]::AllDirectories).ForEach{$sum += [System.IO.FileInfo]::new($_).Length}
        $Size = "{0:N2}" -f ($sum / 1KB)


        $Size = [math]::round($Size,5)

        $Name = $CheckItem.Name
        $FilePath = $CheckItem.FullName
        

        $Object = New-Object PSCustomObject -Property @{
            "Name" = $Name
            "Path" = $FilePath
            "Size" = $Size
        }
        $Objects += $Object
      }
      else{

      $Items = Get-ChildItem $Path
      ForEach($Item in $Items){
    
        
          $SelectedItem = Get-ChildItem -Path $Item.FullName
          $Size = $SelectedItem | Measure-Object Length -Sum
          $Size = $Size.Sum/1KB
        

          $Size = [math]::round($Size,5)

          $Name = $Item.Name
          $FilePath = $Item.FullName
          

          $Object = New-Object PSCustomObject -Property @{
              "Name" = $Name
              "Path" = $FilePath
              "Size" = $Size
          }
          $Objects += $Object
        } 
      }
      $Objects
     
    }
}
