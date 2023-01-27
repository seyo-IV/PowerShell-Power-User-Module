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
      $processor = Get-PerformanceCounterLocalName 238
      $percentProcessorTime = Get-PerformanceCounterLocalName 6
      $cpuTime = (Get-Counter "\$processor(_total)\$percentProcessorTime").CounterSamples.CookedValue
      $Memory = Get-PerformanceCounterLocalName 4
      $availMem = (Get-Counter '\$Memory\Available MBytes').CounterSamples.CookedValue
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
          $processor = Get-PerformanceCounterLocalName 238
          $percentProcessorTime = Get-PerformanceCounterLocalName 6
          $cpuTime = (Get-Counter "\$processor(_total)\$percentProcessorTime").CounterSamples.CookedValue
          $Memory = Get-PerformanceCounterLocalName 4
          $availMem = (Get-Counter '\$Memory\Available MBytes').CounterSamples.CookedValue
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
