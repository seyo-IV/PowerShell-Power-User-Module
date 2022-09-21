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

      while($true) {
    
        while($ProcessCount -le $EntryNumber){
        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
        $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
        $Usage = $date + ' > CPU: ' + $cpuTime.ToString("#,0.000") + '%, Avail. Mem.: ' + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,0.0") + '%)'
        
         # Get Computer Object
     $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
     $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)
     
    
            
     
     $processMemoryUsage = Get-WmiObject WIN32_PROCESS | Sort-Object -Property ws -Descending | Select-Object -First $EntryNumber processname, @{Name="Mem Usage(MB)";Expression={[math]::round($_.ws / 1mb)}}
    
    
          $ProcessList = Get-Process | Sort-Object -Descending CPU | Select-Object -First $EntryNumber
          Start-Sleep -Seconds 1
          if($ProcessList.count -eq $EntryNumber){
          Clear-Host
          $Usage; $ProcessList; $processMemoryUsage;  Write-Host "Memory usage in Percentage:" $Memory
          Start-Sleep -Seconds 2
          $ProcessList = $null
          $Usage = $null
          $processMemoryUsage = $Null
          }
          }
    
      }
}
