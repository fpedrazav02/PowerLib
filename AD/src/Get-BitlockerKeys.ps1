<#
.Synopsis
    Get bitlocker keys and dates from the AD.
.DESCRIPTION
    Helper function to get Bitlocker keys and dates on a friendly
.EXAMPLE
    # RELLENAR
.EXAMPLE
    # RELLENAR 
.INPUTS

.NOTES

#>
#TODO 

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
        $objComputer = Get-ADComputer PCUnlocker
        $Bitlocker_Object = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $objComputer.DistinguishedName -Properties 'msFVE-RecoveryPassword'
        $Bitlocker_Object

    }
    Process{

    }
    End{

    }
}