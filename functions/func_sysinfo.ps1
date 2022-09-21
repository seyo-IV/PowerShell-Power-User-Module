<#
.SYNOPSIS
  Get all kind of usefull computer infos.
.DESCRIPTION
  Get computer infos.
.PARAMETER Name
  Name of computer.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  sysinfo
  sysinfo COMPUTER01
#>

function sysinfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$False)]
        [string]$Name
        )
        if($Name -eq ""){
          ## Gather computer informations
          $ComputerInfo = Get-ComputerInfo | Select-Object  `
          CsCaption,
          CsPCSystemType,
          CsSystemType,
          OsName,
          OsArchitecture,
          OsLanguage,
          OSDisplayVersion,
          WindowsVersion,
          CsUserName,
          CsProcessors,
          CsNumberOfLogicalProcessors,
          OsTotalVisibleMemorySize,
          OsFreePhysicalMemory,
          OsTotalVirtualMemorySize,
          OsFreeVirtualMemory,
          OsInUseVirtualMemory,
          OsSizeStoredInPagingFiles,
          OsFreeSpaceInPagingFiles,
          CsNetworkAdapters

          $ComputerInfos  = New-Object PSCustomObject -Property @{
            "ComputerName"=$ComputerInfo.CsCaption;
            "PCSystemType"=$ComputerInfo.CsPCSystemType;
            "SystemType"=$ComputerInfo.CsSystemType;
            "OSName"=$ComputerInfo.OsName;
            "OsArchitecture"=$ComputerInfo.OsArchitecture;
            "OSLanguage"=$ComputerInfo.OsLanguage;
            "OSVersion"=$ComputerInfo.OSDisplayVersion;
            "WindowsVersion"=$ComputerInfo.WindowsVersion;
            "UserName"=$ComputerInfo.CsUserName;
            "Processor"=$ComputerInfo.CsProcessors;
            "Cores"=$ComputerInfo.CsNumberOfLogicalProcessors;
            "TotalVisibleMemorySize"=$ComputerInfo.OsTotalVisibleMemorySize;
            "FreePhysicalMemory "=$ComputerInfo.OsFreePhysicalMemory;
            "TotalVirtualMemorySize"=$ComputerInfo.OsTotalVirtualMemorySize;
            "FreeVirtualMemory"=$ComputerInfo.OsFreeVirtualMemory;
            "InUseVirtualMemory"=$ComputerInfo.OsInUseVirtualMemory;
            "SizeStoredInPagingFiles"=$ComputerInfo.OsSizeStoredInPagingFiles;
            "FreeSpaceInPagingFiles"=$ComputerInfo.OsFreeSpaceInPagingFiles;
            "NetworkAdapters"=$ComputerInfo.CsNetworkAdapters;
          }
          Clear-Host
          Write-Host -ForegroundColor Green "[ COMPUTER INFO ]"
          $ComputerInfos | Format-List ComputerName, PCSystemType, SystemType, OSName, OsArchitecture, OSLanguage, OSVersion, WindowsVersion, UserName, Processor, Cores, TotalVisibleMemorySize, FreePhysicalMemory, TotalVirtualMemorySize, FreeVirtualMemory, InUseVirtualMemory, SizeStoredInPagingFiles, FreeSpaceInPagingFiles, NetworkAdapters
          Write-Host -ForegroundColor Green "[ ADAPTER INFO ]"
          Foreach($Adapter in $ComputerInfo.CsNetworkAdapters){
            $Adapter | Select-Object ConnectionID, Description, ConnectionStatus, IPAddresses | Format-List
          }
        }
        if($Name -ne ""){

          $ComputerInfo = Invoke-Command -ComputerName $Name -ScriptBlock { 
          Get-ComputerInfo | Select-Object  `
          CsCaption,
          CsPCSystemType,
          CsSystemType,
          OsName,
          OsArchitecture,
          OsLanguage,
          OSDisplayVersion,
          WindowsVersion,
          CsUserName,
          CsProcessors,
          CsNumberOfLogicalProcessors,
          OsTotalVisibleMemorySize,
          OsFreePhysicalMemory,
          OsTotalVirtualMemorySize,
          OsFreeVirtualMemory,
          OsInUseVirtualMemory,
          OsSizeStoredInPagingFiles,
          OsFreeSpaceInPagingFiles,
          CsNetworkAdapters
        }
        $ComputerInfos  = New-Object PSCustomObject -Property @{
          "ComputerName"=$ComputerInfo.CsCaption;
          "PCSystemType"=$ComputerInfo.CsPCSystemType;
          "SystemType"=$ComputerInfo.CsSystemType;
          "OSName"=$ComputerInfo.OsName;
          "OsArchitecture"=$ComputerInfo.OsArchitecture;
          "OSLanguage"=$ComputerInfo.OsLanguage;
          "OSVersion"=$ComputerInfo.OSDisplayVersion;
          "WindowsVersion"=$ComputerInfo.WindowsVersion;
          "UserName"=$ComputerInfo.CsUserName;
          "Processor"=$ComputerInfo.CsProcessors;
          "Cores"=$ComputerInfo.CsNumberOfLogicalProcessors;
          "TotalVisibleMemorySize"=$ComputerInfo.OsTotalVisibleMemorySize;
          "FreePhysicalMemory "=$ComputerInfo.OsFreePhysicalMemory;
          "TotalVirtualMemorySize"=$ComputerInfo.OsTotalVirtualMemorySize;
          "FreeVirtualMemory"=$ComputerInfo.OsFreeVirtualMemory;
          "InUseVirtualMemory"=$ComputerInfo.OsInUseVirtualMemory;
          "SizeStoredInPagingFiles"=$ComputerInfo.OsSizeStoredInPagingFiles;
          "FreeSpaceInPagingFiles"=$ComputerInfo.OsFreeSpaceInPagingFiles;
          "NetworkAdapters"=$ComputerInfo.CsNetworkAdapters;
        }
        Clear-Host
        Write-Host -ForegroundColor Green "[ COMPUTER INFO ]"
        $ComputerInfos | Format-List ComputerName, PCSystemType, SystemType, OSName, OsArchitecture, OSLanguage, OSVersion, WindowsVersion, UserName, Processor, Cores, TotalVisibleMemorySize, FreePhysicalMemory, TotalVirtualMemorySize, FreeVirtualMemory, InUseVirtualMemory, SizeStoredInPagingFiles, FreeSpaceInPagingFiles, NetworkAdapters
        Write-Host -ForegroundColor Green "[ ADAPTER INFO ]"
        Foreach($Adapter in $ComputerInfo.CsNetworkAdapters){
          $Adapter | Select-Object ConnectionID, Description, ConnectionStatus, IPAddresses | Format-List
        }

        }
}      