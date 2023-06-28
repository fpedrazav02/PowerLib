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

function Get-ADUserList {

    [CmdletBinding()]

    [Alias()]
    [OutPutType()]
    
    param (
        [Parameter()]
        [TypeName]
        $ParameterName
    )
    Begin{

    }
    Process{

    }
    End{

    }
}