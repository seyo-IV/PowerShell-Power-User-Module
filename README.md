# Introduction #
A smal collection of scripts i have used over time which can be nice to have in your toolbelt!

TOP ONLY WORKS ON SYSTEMS WITH ENGLISH!!

UPDATE: .. sadly my top and free functions does not work on PS Version 6+!

### Commands ###

## perm ##
![perm](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/perm.png)
Lists NTFS permissions.

## id ##
![id](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/id.png)
I tried to make a Linux "id" command but the PowerShell way :D. AD not tested, but should work, sadly i dont have AD at home :(.

## touch ##
![touch](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/touch.png)
For the lazy of us.

## top ##
![top](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/top.png)
Not even close to the original but stil nice.

## fgrep ##
![fgrep](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/fgrep.png)
"f" stand for file, since you only can use that on plain text files and not like the normal grep, where you could filter after executing "ps"(for example).

## find ##
![find](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/find.png)
It works just like the ```file -f``` command.

## sysinfo ##
![sysinfo](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/sysinfo.png)
Gather usefull infos of local or remote computer.

## chown ##
![chown](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/chown.png)
Change owner of file.

## chperm ##
![chperm](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/chperm.png)
Change NTFS permission on directory or file. (Sry no fancy output yet :C)

## free ##
![free](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/free.png)
Just like the ```free``` command on Linux, it shows memory and swap stats.

## diskfree ##
![diskfree](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/diskfree.png)
Shows disk/volume information. Just like the ```df -h``` command.

## diskusage ##
![diskusage](https://github.com/seyo-IV/PowerShell-Power-User-Module/blob/main/images/diskusage.png)
Like the ```du``` command on Linux.

### How to install! ###
IMPORTANT! You will need PS Version 7 or higher for the top script to run.

Open PowerShell.
Type ```$env:PSModulePath -split ';'```
Choose one of the locations and paste the "Power-User" direcotry there.

Then open a new PowerShell console and type ```Import-Module Power-User```

If you can't import the module for wahtever resaon, try ```Get-Module -ListAvailable``` and look for ```Power-User```.

If nothing works do this ```Import-Module \\Path\to\Power-User```
