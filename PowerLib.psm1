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
$Modules = Get-ChildItem $PSScriptRoot -Directory
$exceptions = @('.vscode')

foreach ($module in $Modules)
{
    if ($module.Name -notin $exceptions)
    {
        Write-Host $module.FullName
        Import-Module -Name "$($module.FullName)" -Force
    }
}

Import-Module -name "$($PSScriptRoot)\O365Reports\classes\ExchangeReport.Class.ps1" -Force -Verbose -AsCustomObject

Export-ModuleMember -Function * -Cmdlet * -Alias *
    