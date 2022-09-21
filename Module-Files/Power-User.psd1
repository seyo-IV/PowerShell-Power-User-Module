#
# Module manifest for module 'Power-User-Module'
#
# Generated by: seyo
#
# Generated on: 19/09/2022
#

@{

# Script module or binary module file associated with this manifest.
#RootModule = ''

# Version number of this module.
ModuleVersion = '0.1'


# ID used to uniquely identify this module
GUID = '68ec787d-d5b1-4b3c-b5cf-8a804c233e33'

# Author of this module
Author = 'Sergiy Ivanov'

# Company or vendor of this module
CompanyName = 'www.seyo-iv.space'

# Copyright statement for this module
Copyright = '(c) Sergiy Ivanov. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Some neat commands for power users.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
#DotNetFrameworkVersion = '4.0'

# Minimum version of the common language runtime (CLR) required by this module
#CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
#RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @('SSHSession.Format.ps1xml')

# Format files (.ps1xml) to be loaded when importing this module
#FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('Power-User.psm1')

# Functions to export from this module
FunctionsToExport = 'fgrep',
                    'id',
                    'perm',
                    'top',
                    'touch',
                    'chown',
                    'chperm',
                    'find',
                    'sysinfo',
                    'wc'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module.
# ModuleList = @()

# List of all files packaged with this module
FileList = @('Power-User.psm1')

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

