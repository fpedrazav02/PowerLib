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
    if ($module -notin $exceptions)
    {
        Write-Host $module.FullName
        Import-Module -Name "$($module.FullName)" -Force
    }
}

 # Import-Module -Name

 Class ExchangeMailbox {

    #Class specifics
    [Int32]$ID                  # ID enumeration
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

    ExchangeMailbox ([Int32]$ID,[string]$Mail, [string]$ExchangeGuid, [bool]$IsMailboxEnabled, [bool]$IsDirSynced,[string]$PrimarySmtpAddress,[string]$Smtps,[string]$AccountType,[string]$MailboxType,[string]$CreationDate)
    {
        $this.ID = $ID
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


Export-ModuleMember -Function * -Cmdlet * -Alias *
    