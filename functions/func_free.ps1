<#
.SYNOPSIS
  Output swap and memory usage, size, etc..
.DESCRIPTION
  Get Swap/Memory stats.
.PARAMETER 
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  free
#>

function free {
    [CmdletBinding()]
    param()
        $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum
        [int]$totalMem  = $totalRam/1GB
        $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
        $freeMem  = $availMem/1000
        [int]$usedMem = $totalMem - $freeMem
        $swapMem  = Get-WmiObject Win32_PageFileusage | Select-Object *
        $cacheMem = (Get-Counter '\memory\cache bytes').CounterSamples.CookedValue
        $usedCache = $cacheMem/1GB
        $usedCache = [math]::round($usedCache, 2)
        $totalSwap = $swapMem.AllocatedBaseSize/1000
        $usedSwap = $swapMem.CurrentUsage
        $freeSwap = $totalSwap - $usedSwap

        $MemPage = New-Object PSCustomObject -Property @{ 
          "Total"=$totalMem;
          "Used"=$usedMem;
          "Free"=$freeMem;
          "Cache"=$usedCache;
          "Class"="RAM";
        }
        $SwapPage = New-Object PSCustomObject -Property @{ 
          "Total"=$totalSwap;
          "Used"=$usedSwap;
          "Free"=$freeSwap;
          "Class"="SWAP";
        }
        $MemPage | Select-Object Class, Total, Used, Free, Cache | Format-Table
        $SwapPage | Select-Object Class, Total, Used, Free | Format-Table
}
