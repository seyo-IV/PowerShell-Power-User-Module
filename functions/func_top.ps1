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

function top {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$EntryNumber
      )
      
      $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum
      $elevated = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        while($true) {

  if($elevated){  
    while($ProcessCount -le $EntryNumber){
      $Time = Get-Uptime
    $UpTime = "$($Time.Hours)h|$($Time.Minutes)m|$($Time.Seconds)s"
    $cpuTime = (Get-WmiObject -Query "SELECT LoadPercentage FROM Win32_Processor WHERE DeviceID='CPU0'").LoadPercentage
    $availMem = (Get-WmiObject -Query "SELECT FreePhysicalMemory FROM Win32_OperatingSystem").FreePhysicalMemory / 1024
    $Mem = $availMem.ToString("N0")
    $Mem = $Mem -split ","
    $Mem = $Mem[0]
    $AllMem = $totalRam/1GB
    $Usage = "Uptime: " + $UpTime + ' > CPU: ' + $cpuTime.ToString("#,0.000") + '% | Avail. Mem.: ' + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,0.0") + '%)'                

      $processMemoryUsage = Get-WmiObject WIN32_PROCESS | Sort-Object -Property ws -Descending | Select-Object -First $EntryNumber processname, @{Name="Mem Usage(MB)";Expression={[math]::round($_.ws / 1mb)}}
      $CPUBar = $cpuTime
      $CPUBar = [math]::Round($CPUBar)
      $MemBar = $AllMem - $Mem

      $ProcessList = Get-Process -IncludeUserName | Sort-Object -Descending CPU | Select-Object -First $EntryNumber

      if($ProcessList.count -eq $EntryNumber){
      Clear-Host

      $CPUi = 0
      $CPUx = 0
      foreach($CPUi in $CPUBar){
          foreach($CPUx in $CPUi){
          $NoLoad = " "*(100-$CPUx)
          $Load = "|"*$CPUx
          }
      Write-Host "CPU Load: $CPUBar%" -ForegroundColor Green
      Write-Host -ForegroundColor Yellow "[ $Load $NoLoad ]" -NoNewline
      }
      "`n"
      $Memi = 0
      $Memx = 0
      foreach($Memi in $MemBar){
          foreach($Memx in $Memi){
          $NoLoad = " "*(100-$Memx)
          $Load = "|"*$Memx
          }
      Write-Host "Mem Load: $Membar%" -ForegroundColor Green
      Write-Host -ForegroundColor Yellow "[ $Load $NoLoad ]" -NoNewline
      }
      "`n"          
      $Usage; $ProcessList; $processMemoryUsage | Format-Table


      $ProcessList = $null
      $Usage = $null
      $processMemoryUsage = $Null
        }
      }
        }
        else{
          while($ProcessCount -le $EntryNumber){
            $Time = Get-Uptime
            $UpTime = "$($Time.Hours)h|$($Time.Minutes)m|$($Time.Seconds)s"
            $cpuTime = (Get-WmiObject -Query "SELECT LoadPercentage FROM Win32_Processor WHERE DeviceID='CPU0'").LoadPercentage
            $availMem = (Get-WmiObject -Query "SELECT FreePhysicalMemory FROM Win32_OperatingSystem").FreePhysicalMemory / 1024
            $Mem = $availMem.ToString("N0")
            $Mem = $Mem -split ","
            $Mem = $Mem[0]
            $AllMem = $totalRam/1GB
            $Usage = "Uptime: " + $UpTime + ' > CPU: ' + $cpuTime.ToString("#,0.000") + '% | Avail. Mem.: ' + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,0.0") + '%)'                
        
              $processMemoryUsage = Get-WmiObject WIN32_PROCESS | Sort-Object -Property ws -Descending | Select-Object -First $EntryNumber processname, @{Name="Mem Usage(MB)";Expression={[math]::round($_.ws / 1mb)}}
              $CPUBar = $cpuTime
              $CPUBar = [math]::Round($CPUBar)
              $MemBar = $AllMem - $Mem
        
              $ProcessList = Get-Process | Sort-Object -Descending CPU | Select-Object -First $EntryNumber
        
              if($ProcessList.count -eq $EntryNumber){
              Clear-Host
        
              $CPUi = 0
              $CPUx = 0
              foreach($CPUi in $CPUBar){
                  foreach($CPUx in $CPUi){
                  $NoLoad = " "*(100-$CPUx)
                  $Load = "|"*$CPUx
                  }
              Write-Host "CPU Load: $CPUBar%" -ForegroundColor Green
              Write-Host -ForegroundColor Yellow "[ $Load $NoLoad ]" -NoNewline
              }
              "`n"
              $Memi = 0
              $Memx = 0
              foreach($Memi in $MemBar){
                  foreach($Memx in $Memi){
                  $NoLoad = " "*(100-$Memx)
                  $Load = "|"*$Memx
                  }
              Write-Host "Mem Load: $Membar%" -ForegroundColor Green
              Write-Host -ForegroundColor Yellow "[ $Load $NoLoad ]" -NoNewline
              }
              "`n"          
              $Usage; $ProcessList; $processMemoryUsage | Format-Table
        
        
              $ProcessList = $null
              $Usage = $null
              $processMemoryUsage = $Null
              }
            }
        }
      }
}
