<#
.SYNOPSIS
  Output swap and memory usage, size, etc..
.DESCRIPTION
  Get Swap/Memory stats.
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

Function Get-PerformanceCounterLocalName
{
  param
  (
    [UInt32]
    $ID,
	$ComputerName = $env:COMPUTERNAME
  )

  $code = '[DllImport("pdh.dll", SetLastError=true, CharSet=CharSet.Unicode)] public static extern UInt32 PdhLookupPerfNameByIndex(string szMachineName, uint dwNameIndex, System.Text.StringBuilder szNameBuffer, ref uint pcchNameBufferSize);'

  $Buffer = New-Object System.Text.StringBuilder(1024)
  [UInt32]$BufferSize = $Buffer.Capacity

  $t = Add-Type -MemberDefinition $code -PassThru -Name PerfCounter -Namespace Utility
  $rv = $t::PdhLookupPerfNameByIndex($ComputerName, $id, $Buffer, [Ref]$BufferSize)

  if ($rv -eq 0)
  {
    $Buffer.ToString().Substring(0, $BufferSize-1)
  }
  else
  {
    Throw 'Get-PerformanceCounterLocalName : Unable to retrieve localized name. Check computer name and performance counter ID.'
  }
}

function free {
    [CmdletBinding()]
    param()
        $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum
        [int]$totalMem  = $totalRam/1GB
        $Memory = Get-PerformanceCounterLocalName 4
        $availMem = (Get-Counter "\$Memory\Available MBytes").CounterSamples.CookedValue
        $freeMem  = $availMem/1000
        [int]$usedMem = $totalMem - $freeMem
        $swapMem  = Get-WmiObject Win32_PageFileusage | Select-Object *
        $cacheMem = (Get-Counter "\$Memory\cache bytes").CounterSamples.CookedValue
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
