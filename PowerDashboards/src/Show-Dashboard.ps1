<#
.Synopsis
    Generate diferent Outputs for fast AD User lists and fields. Export in diferent formats.
.DESCRIPTION
    Wrapper of Get-ADUser which lets you get a more usefull output as well as easier bulk operations and outputs.
.EXAMPLE
    # RELLENAR
.EXAMPLE
    # RELLENAR 
.INPUTS

.NOTES
    You will need the following dependencies:
        1) Test
        2)

    Import-Module -Name ".\PowerLibrary\moduleA"
#>

function Show-Dashboard {

    param (
        [string]$title,
        [string]$dividerColor = "Red",
        [string]$separator = "`e[1;31m|`e[0m",
        [System.Object]$JobData
    )
    Begin{
        
            $hostWidth = $Host.UI.RawUI.BufferSize.Width
            $line = ("`e[1;31m-`e[0m" * $hostWidth)
            
            $titleBox = "$title".ToUpper()
            Clear-Host  
    }
    Process{
            #Título
            Write-Host "`e[1m$titleBox`e[0m"
            #Divider
            Write-Host $line -ForegroundColor $dividerColor

            #Línea 1
            $userLineUsername = "`e[1;34m[*]Usuario actual:`e[0m $($JobData.User)"
            Write-Host $userLineUsername

            #Línea 2
            $userLineProgress = "`e[1;34m[*]Progreso:`e[0m $($JobData.Progress)"
            Write-Host $userLineProgress

            #Línea 3
            $userLineExecutionTime = "`e[1;34m[*]Tiempo de ejecución:`e[0m $(Get-Date)"
            Write-Host $userLineExecutionTime

            #Línea 5
            $userLineProccessedItems =  "`e[1;32m$($JobData.ProcessedItems)`e[0m de $($JobData.TotalItems)"
            Write-Host $userLineProccessedItems

            #Línea 4
            $userLineProcessStatus = "$($JobData.ProcessStatus)"
            Write-Host $userLineProcessStatus

            Write-Host $line -ForegroundColor $dividerColor

            #Table
    }
    End{

    }
}