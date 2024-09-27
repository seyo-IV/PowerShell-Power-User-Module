<#
.SYNOPSIS
  Adaptation of the chown command of Linux.
.DESCRIPTION
  Change ownership easy.
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
        Write-Host "[ OLD OWNER ]" -ForegroundColor Green
        $Acl | Select-Object Owner | Format-List

        $Object = New-Object System.Security.Principal.Ntaccount($Name)

        $Acl.SetOwner($Object)

        $Acl | Set-Acl $Path
        Write-Host "[ NEW OWNER ]" -ForegroundColor Green
        $Acl | Select-Object Owner | Format-List
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
  df -h for noobs.
.DESCRIPTION
  Get disk/volume info.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  diskfree
#>

function diskfree {
    [CmdletBinding()]
    param()
        $Drives = Get-PSProvider FileSystem | Select-Object * -ExpandProperty Drives -ErrorAction "SilentlyContinue"
        $Drives = $Drives | Where-Object { $_.Name –ne "Temp" }
        foreach($Drive in $Drives){
          Get-Volume $Drive.Name
        }
}




<#
.SYNOPSIS
  Adaptation of the diskusage program from Linux.
.DESCRIPTION
  Show running processes and Memory.
.PARAMETER Select
  If single file or directory will be choosen. By default its "All"
.PARAMETER Path
  Path to file. By default its the current working direcotry.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Sergiy Ivanov
  Purpose/Change: Initial script development
  
.EXAMPLE
  diskusage
  diskusage select C:\temp
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

function netinfo {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [int]$Port,
    [Parameter(Mandatory = $false)]
    [string]$ProcessName
  )

  if ($Port -ne "") {
    # Get a list of active TCP connections, including Listening and Established states
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' -or $_.State -eq 'Established' }

    # If a port is specified, filter the connections
    if ($Port) {
      $connections = $connections | Where-Object { $_.LocalPort -eq $Port }
    }
  
    # For each connection, retrieve the process name using the process ID
    $connections | ForEach-Object {
      $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
      [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        ProcessName   = if ($proc) { $proc.ProcessName } else { 'Unknown' }
        ProcessId     = $_.OwningProcess
      }
    } | Format-Table -AutoSize
  }

  if ($ProcessName -ne "") {
    # Get a list of active TCP connections, including Listening and Established states
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' -or $_.State -eq 'Established' }

    # For each connection, retrieve the process name using the process ID
    $connections = $connections | ForEach-Object {
      $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
      [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        ProcessName   = if ($proc) { $proc.ProcessName } else { 'Unknown' }
        ProcessId     = $_.OwningProcess
      }
    }

    # Filter by process name if specified
    if ($ProcessName) {
      $connections = $connections | Where-Object { $_.ProcessName -like "*$ProcessName*" }
    }

    # Output the results in table format
    $connections | Format-Table -AutoSize
  }

  if (($Port -eq "") -and ($ProcessName -eq "")) {
    # Get a list of active TCP connections, including Listening and Established states
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' -or $_.State -eq 'Established' }

    # For each connection, retrieve the process name using the process ID
    $connections | ForEach-Object {
      $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
      [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        ProcessName   = if ($proc) { $proc.ProcessName } else { 'Unknown' }
        ProcessId     = $_.OwningProcess
      }
    } | Format-Table -AutoSize
  }
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




