# LogCleaner.psd1

@{

# Module manifest  

ModuleVersion = '1.0'
GUID = 'abcd1234-abcd-1234-abcd-123456abcdef'
Author = 'John McBride'
CompanyName = 'TaskForce 6' 
Copyright = '(c) 2023 TaskForce 6. All rights reserved.'

# Module identity
RootModule = 'LogCleaner.psm1'
ModuleName = 'LogCleaner'

# Supported PSEditions
CompatiblePSEditions = @('Desktop', 'Core') 

# Modules to import as nested modules
NestedModules = @('Irregular', 'LogCleaner')

# Functions to export from this module
FunctionsToExport = @('Clean-Log')

# Cmdlets to export from this module
CmdletsToExport = @() 

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module 
AliasesToExport = @() 

}