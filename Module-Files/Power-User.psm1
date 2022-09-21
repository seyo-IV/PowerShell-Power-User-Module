<#
.SYNOPSIS
  Adaptation of the touch command of Linux.
.DESCRIPTION
  Create any kind of files with one command.
.PARAMETER File
  Name of file.
.PARAMETER Path
  Path of file.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  chown randomlocal C:\temp
  chown Domain\jon.doe C:\temp
#>

function chown {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$Name,
      [Parameter(Mandatory=$True)]
      [string]$Path
      )
      $Acl = Get-Acl $Path

      $Object = New-Object System.Security.Principal.Ntaccount($Name)

      $Acl.SetOwner($Object)

      $Acl | Set-Acl $Path
}

<#
.SYNOPSIS
  Adaptation of the find -f command of Linux.
.DESCRIPTION
  Search for any kind of files.
.PARAMETER Name
  Name of file.
.PARAMETER Path
  Path where to look for.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  find file C:\temp
#>

function find {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$Name,
      [Parameter(Mandatory=$True)]
      [string]$Path
      )
      Get-ChildItem $Path | Where-Object {$_.Name -like "*$Name*"}
}

<#
.SYNOPSIS
  Adds or removes permissions.
.DESCRIPTION
  Add/Remove NTFS ACLs.
.PARAMETER Staus
  Specifies the status. 
.PARAMETER Mode
  Specifies the mode.
.PARAMETER Name
  Specifies the user/group name. 
.PARAMETER Path
  Specifies the file name. 
.PARAMETER Access
  Specifies the Access.

.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  chperm add m Username C:\temp allow
  chperm remove f YOUR-DOMAIN\Group C:\temp\file deny
#>
function chperm {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$Status,
      [Parameter(Mandatory=$True)]
      [string]$Mode,
      [Parameter(Mandatory=$True)]
      [string]$Name,
      [Parameter(Mandatory=$True)]
      [string]$Path,
      [Parameter(Mandatory=$True)]
      [string]$Access
      )
      if($Status -eq "add"){
        if($Mode -eq "r"){
          $ModeSet = "Read"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "w"){
          $ModeSet = "Write"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "x"){
          $ModeSet = "ReadAndExecute"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "m"){
          $ModeSet = "Modify"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "f"){
          $ModeSet = "FullControl"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.SetAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
      }
      if($Status -eq "remove"){
        if($Mode -eq "r"){
          $ModeSet = "Read"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)

            $Acl | Set-Acl $Path
          }
        }
        if($Mode -eq "w"){
          $ModeSet = "Write"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)

            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
                          
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "x"){
          $ModeSet = "ReadAndExecute"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "m"){
          $ModeSet = "Modify"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
        if($Mode -eq "f"){
          $ModeSet = "FullControl"
          if($Access -eq "Allow"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path             
          }
          elseif($Access -eq "Deny"){
            $Acl = Get-Acl $Path

            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Name,$ModeSet,$Access)
            
            $Acl.RemoveAccessRule($AccessRule)
            
            $Acl | Set-Acl $Path  
          }
        }
      }
}

<#
.SYNOPSIS
  Adaptation of the grep program from Linux.
.DESCRIPTION
  Search for pattern in plain text files only.
.PARAMETER Find
  Find, pattern to look for.
.PARAMETER Path
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


<#
.SYNOPSIS
  Adaptation of the touch command of Linux.
.DESCRIPTION
  Create any kind of files with one command.
.PARAMETER File
  Name of file.
.PARAMETER Path
  Path of file.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  touch file C:\temp
#>

function touch {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$Name,
      [Parameter(Mandatory=$True)]
      [string]$Path
      )
      New-Item -ItemType File -Path $Path -Name $Name
}

<#
.SYNOPSIS
  Adaptation of the wc command of Linux.
.DESCRIPTION
  Count words in a plain text file.
.PARAMETER Path
  Path of file.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  wc C:\temp\file
#>

function wc {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$Path
      )
      $WordCount = Get-Content $Path | Measure-Object -Word
      $File = Get-ChildItem $Path

      $Table =  New-Object PSCustomObject -Property @{
          "Path" = $File.FullName;
          "Name" = $File.Name;
          "LastWriteTime" = $File.LastWriteTime;
          "Mode" = $File.Mode;
          "Count" = $WordCount.Words;
      }
      $Table | Select-Object Path, Name, LastWriteTime, Mode, Count | Format-Table
}

<#
.SYNOPSIS
  This script generates a list of NTFS-Permissions.
.DESCRIPTION
  Show NTFS-Permissions
.PARAMETER Path
  Path to scan to.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  perm -Path \\server\share
  perm C:\temp
#>

function perm {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$True)]
      [string]$Path
      )
  
          $ErrorActionPreference = "SilentlyContinue"
          $Folders = $Path -Split "\\"
          $Plist = $Folders | ForEach-Object { $i = 0 } { $Folders[0..$i] -Join "\" -Replace ":$", ":\"; $i++ }
          $FList   = foreach($dir in $Plist){
          
          Resolve-Path -Path $dir
          Get-Item $dir | Select-Object FullName
          Get-Acl -Path $dir -Filter Access | Select-Object -ExpandProperty Access
          }
      
        $Flist | Format-Table FullName, IdentityReference, FileSystemRights
  
}

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