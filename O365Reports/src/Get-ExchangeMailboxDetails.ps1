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
            $MailBoxArr = @()
        }
        catch {
            CenterPrompt -text "You must first connect to exchange online"
            exit 1
        }
    }
    Process{
            $count = 0
            foreach ($mbox in $Mailboxes)
            {
                $obj = [ExchangeMailbox]::new()
                $UserData = Get-MailBox -Identity $mbox | Select-Object WindowsLiveID,ExchangeGuid,IsMailboxEnabled,IsDirSynced,RecipientTypeDetails,RecipientType,PrimarySmtpAddress,EmailAddresses,WhenCreated
                    
                Start-Sleep 1
                $obj.ID = $count
                $obj.Mail = $UserData.WindowsLiveID
                $obj.ExchangeGuid = $UserData.ExchangeGuid
                $obj.IsMailboxEnabled = $UserData.IsMailboxEnabled
                $obj.IsDirSynced = $UserData.IsDirSynced
                $obj.AccountType = $UserData.RecipientType
                $obj.MailboxType = $UserData.RecipientTypeDetails
                $obj.Smtps = $UserData.EmailAddresses
                $obj.PrimarySmtpAddress = $UserData.PrimarySmtpAddress
                $obj.CreationDate = $UserData.WhenCreated

                $MailBoxArr += $obj
                $count = $count + 1
            }
        }
    End{
        switch ($Output) {
            HTML {
                $MailBoxArr | ConvertTo-Html | Out-HtmlView
            }
            GRID {
                $MailBoxArr | Out-GridView
            }
            Default {
                $MailBoxArr | Out-Default
                CenterPrompt -text "Finished"
                return $MailBoxArr
            }
        }
         
    }
    
}