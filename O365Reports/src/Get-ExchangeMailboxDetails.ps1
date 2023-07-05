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
            CSV {
                [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
                [void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )
                $dialog = New-Object Windows.Forms.FolderBrowserDialog
                $result = $dialog.ShowDialog( )

                if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
                    CenterPrompt -text "No folder selected"
                    exit 1
                }

                $filepath = "$($dialog.SelectedPath)/ExchangeMailboxDetails$((Get-Date).ToString("yyMMdd")).csv"

                $MailBoxArr | Export-Csv -Path $filepath

                $message = "Report saved at: $filepath"
                [System.Windows.MessageBox]::Show($message, 'Information', 'OK', 'Information')
            }
            HTML {
                $MailBoxArr | ConvertTo-Html | Out-HtmlView
            }
            GRID {
                [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
                $Result = [System.Windows.MessageBox]::Show('¿Desea guardar los usuarios?', 'Confirm', 'YesNo', 'Question')

                Start-Sleep 1
                if ($Result -eq 'Yes') {

                    $filename = "ExchangeMailboxDetails$((Get-Date).ToString("yyMMdd"))"
                    $MailBoxArr | Export-Csv -Path "C:\Users\$($env:USERNAME)\Desktop\$filename.csv"

                    $message = "Report has been saved on the users desktop as $filename.csv"
                    [System.Windows.MessageBox]::Show($message, 'Information', 'OK', 'Information')

                } else {
                    $MailBoxArr | Out-GridView
                }
            }
            Default {
                $MailBoxArr | Out-Default
                CenterPrompt -text "Finished"
                return $MailBoxArr
            }
        }
         
    }
    
}