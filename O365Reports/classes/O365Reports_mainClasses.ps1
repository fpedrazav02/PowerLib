Class ExchangeMailbox {

    #Class specifics    
    [string]$Mail               # Mailbox UPN
    [string]$ExchangeGuid       # Mailbox ID
    [bool]$IsMailboxEnabled     # Boolean is Mailbox is Enabled or disabled
    [bool]$IsDirSynced          # Cloud or On-premise based resource
    [string]$AccountType        # Original type of account
    [string]$MailboxType        # Actual Type of Mailbox
    [string]$PrimarySmtpAddress # Principal SMTP
    [string]$Smtps              # All Smtps alias for the desginated Mailbox
    [string]$CreationDate       # Date of creation

    #Class OverloadMethods
        #Default OverloadDefinition
    ExchangeMailbox () {} 

        #Only Mail default OverloadDefinition
    ExchangeMailbox ([string]$Mail)
    {
        $this.Mail = $Mail
    }

    ExchangeMailbox ([string]$Mail, [string]$ExchangeGuid, [bool]$IsMailboxEnabled, [bool]$IsDirSynced,[string]$PrimarySmtpAddress,[string]$Smtps,[string]$AccountType,[string]$MailboxType,[string]$CreationDate)
    {
        $this.Mail = $Mail
        $this.ExchangeGuid = $ExchangeGuid
        $this.IsMailboxEnabled = $IsMailboxEnabled
        $this.IsDirSynced = $IsDirSynced
        $this.AccountType = $AccountType
        $this.MailboxType = $MailboxType
        $this.PrimarySmtpAddress = $PrimarySmtpAddress
        $this.Smtps = $Smtps
        $this.CreationDate = $CreationDate
    }

    #Class Methods
}