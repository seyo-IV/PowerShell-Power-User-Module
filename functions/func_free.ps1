<#
.SYNOPSIS
  Output swap and memory usage, size, etc.
.DESCRIPTION
  Get Swap/Memory stats for Windows systems using CIM (Common Information Model).
.INPUTS
  None.
.OUTPUTS
  Memory and swap statistics.
.NOTES
  Version:        1.3
  Author:         Sergiy Ivanov
  Purpose/Change: Improved memory and swap calculation logic using CIM.

.EXAMPLE
  free
#>

function free {
  [CmdletBinding()]
  param()

  # Get physical memory using CIM
  $physicalMemory = Get-CimInstance Win32_ComputerSystem
  $totalMem = [math]::round($physicalMemory.TotalPhysicalMemory / 1GB, 2)

  # Get available memory using CIM
  $availMem = Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
  $freeMem = [math]::round(($availMem / 1024) / 1024, 2)  # Convert from KB to GB
  [int]$usedMem = $totalMem - $freeMem
  

  # Get page file (swap) information using CIM
  $swapMem = Get-CimInstance Win32_PageFileUsage | Select-Object *
  $totalSwap = [math]::round($swapMem.AllocatedBaseSize / 1024, 2)  # Convert to GB
  $usedSwap = [math]::round($swapMem.CurrentUsage / 1024, 2)        # Convert to GB
  $freeSwap = $totalSwap - $usedSwap

  # Prepare output objects for Memory (RAM) and Swap (Pagefile)
  $MemPage = New-Object PSCustomObject -Property @{
      "Total" = $totalMem
      "Used"  = [math]::max(0, $usedMem) # Ensure no negative values
      "Free"  = [math]::max(0, $freeMem) # Ensure no negative values
      "Class" = "RAM"
  }

  $SwapPage = New-Object PSCustomObject -Property @{
      "Total" = $totalSwap
      "Used"  = [math]::max(0, $usedSwap) # Ensure no negative values
      "Free"  = [math]::max(0, $freeSwap) # Ensure no negative values
      "Class" = "SWAP"
  }

  # Output results as tables
  $MemPage | Select-Object Class, Total, Used, Free | Format-Table
  $SwapPage | Select-Object Class, Total, Used, Free | Format-Table
}
