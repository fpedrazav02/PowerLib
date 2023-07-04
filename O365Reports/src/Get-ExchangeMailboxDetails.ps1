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
    [OutPutType([System.Array])]
    
    param (
        #Param Mailboxes
        [Parameter(Mandatory=$true,ParameterSetName="Exchange MailBoxes")]
        [ValidateNotNullOrEmpty()]
        [ValidateNotnull()]
        [System.Array]
        $Mailboxes,

        #Param Output
        # Parameter help description
        [Parameter()]
        [ValidateSet("CSV","GRID","HTML")]
        [string]
        $Output
    )
    Begin{
        try {
            $connections = Get-ConnectionInformation | Select-Object -Property Name | ForEach-Object {$_ -like "*ExchangeOnline*"}
            if ($true -in $connections)
            {
                CenterPrompt -text "Connection Stablished"
            }
            else {
                throw
            }
        }
        catch {
            CenterPrompt -text "You must first connect to exchange online"
        }
    }
    Process{
        switch ($Output) {
            condition {  }
            Default {
                foreach ($mbox in $Mailboxes)
                {
                    $UserData = Get-MailBox -Identity $mbox | select WindowsLiveID,ExchangeGuid,IsMailboxEnabled,IsDirSynced,RecipientTypeDetails,RecipientType,PrimarySmtpAddress,EmailAddresses,WhenCreated
                }
            }
        }
    }
    End{

    }
    
}