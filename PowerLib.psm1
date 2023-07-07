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
        $text = "Found Module "
        Write-Host "`e[1m$text`e[0m"-NoNewline -ForegroundColor Green
        Write-Host "`e[1m$($module.Name)`e[0m "-NoNewline -ForegroundColor Cyan
        $text = "at: "
        Write-Host "`e[1m$text`e[0m"-NoNewline -ForegroundColor Green
        Write-Host $module.FullName
        Import-Module -Name "$($module.FullName)" -Force
    }
}

Export-ModuleMember -Function * -Cmdlet * -Alias *
    