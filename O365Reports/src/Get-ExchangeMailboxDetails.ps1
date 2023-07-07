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
            [void][ExchangeMailbox]::new()
        }
        catch {
            $path = ($PSScriptRoot -split "\\")
            $joined = $path[0..($path.Count-2)] -join "\"
            New-PSPrompt -text "Please import module classes with: ","Import-Module -name '$($joined) -Force"
            exit 1
        }
        try {
            $connections = Get-ConnectionInformation | Select-Object -Property Name | ForEach-Object {$_ -like "*ExchangeOnline*"}
            if ($true -in $connections)
            {
                New-PSPrompt -text "Connection Stablished"
            }
            else {
                throw
            }
            $MailBoxArr = @()
        }
        catch {
            New-PSPrompt -text "You must first connect to exchange online"
            exit 1
        }
    }
    Process{
            Import-Module -Name "..\classes\ExchangeReport.Class.ps1" -Force
            $count = 0
            foreach ($mbox in $Mailboxes)
            {
                try {
                    $obj = [ExchangeMailbox]::new()
                    $UserData = Get-MailBox -Identity $mbox -ErrorAction Stop | Select-Object WindowsLiveID,ExchangeGuid,IsMailboxEnabled,IsDirSynced,RecipientTypeDetails,RecipientType,PrimarySmtpAddress,EmailAddresses,WhenCreated
                        
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
                }
                catch {
                    $obj = [ExchangeMailbox]::new()
                    $obj.Mail = $mbox
                    $obj.MailboxType = "NO MAILBOX"
                }
                finally{
                    $MailBoxArr += $obj
                    $count = $count + 1
                }
            }
        }
    End{
        switch ($Output) {
            CSV {
                [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
                [void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )

                Write-Host "├─" -NoNewline -ForegroundColor Cyan
                Write-Host "Folder Dialog Opened"

                $dialog = New-Object Windows.Forms.FolderBrowserDialog
                $result = $dialog.ShowDialog( )

                if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
                    New-PSPrompt -text "No folder selected"
                    exit 1
                }

                $filepath = "$($dialog.SelectedPath)/ExchangeMailboxDetails$((Get-Date).ToString("yyMMdd")).csv"

                $MailBoxArr | Export-Csv -Path $filepath

                Write-Host "├─" -NoNewline -ForegroundColor Cyan
                Write-Host "File saved at " -NoNewline
                Write-Host "`e[1m$filepath`e[0m" -ForegroundColor Red
                $message = "Report saved at: $filepath"
                New-Divider
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
                New-PSPrompt -text "Finished"
                return $MailBoxArr
            }
        }
         
    }
    
}