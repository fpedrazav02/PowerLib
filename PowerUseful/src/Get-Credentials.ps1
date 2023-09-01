<#
.Synopsis
    Get credentials needed with a easier prompt in CLI
.DESCRIPTION

.EXAMPLE
    
.EXAMPLE
    
.INPUTS

.NOTES #TODO

#>
function Get-Credentials {
    param (
        [Parameter(Mandatory=$true)]
        [String]
        $Service
    )
    Begin{
        Clear-Host
        New-PSPrompt -text "Introduce las credenciales de $Service" -colorBox DarkGreen -colorText Cyan
    }
    Process{
        $Credential = Get-Credential -Message "Introducir credenciales de $Service" -Title "$Service CREDENTIALS"
        New-Divider -ColorLine DarkGreen
        Clear-Host
    }
    End{
        return $Credential
    }
}