<#
.Synopsis
 PowerShell like library. Just a normal PSM1 file to import multiple Modules.
.DESCRIPTION
 Receives a path to an XML file. Then converts and loads de XML to an XML object ready for use.
.EXAMPLE
 Import all modules:
    Import-Module -Name '.\PowerLibrary' -Verbose -Force
    
.EXAMPLE
Import specific module:
    Import-Module -Name ".\PowerLibrary\moduleA"
#>

Import-Module -Name "$PSScriptRoot\moduleA"  -Force
Import-Module -Name "$PSScriptRoot\moduleB"  -Force

Export-ModuleMember -Function * -Cmdlet *
    