<#
.Synopsis
    Get the most important fields out of Exchange Mailboxes and Output it in a friendly manner.
.DESCRIPTION
    Wrapper of Get-MailBoxes.
.EXAMPLE
    # RELLENAR
.EXAMPLE
    # RELLENAR 
.INPUTS

.NOTES
    You must instanciate a Session with Connect-ExchangeOnline and have the appropiate perms prior to executing this CMD.
        1) Connect-ExchangeOnline
    * Depends on the main classes of the module *
#>
function Get-ExchangeMailboxDetails {

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