<#
.Synopsis
    Generate a CSV with new user information
    
.DESCRIPTION
    Generate a CSV with new user information. The purpose of this command is to generate a useful list
    with basic user information; First name, last name, SamAccountName, Password.

    You can then use -Safe flage in order to generate a password pushed via URL, 
    settings on URL may be passed down as well.
    
.EXAMPLE
    
.EXAMPLE
    
.INPUTS

.NOTES

#>

# TODO

function New-ADUsersLists
{
    [CmdletBinding()]

    [Alias()]
    [OutPutType()]
    
    param (

    )
    begin{

        class User {
            [string]$FirstName
            [string]$LastName
            [string]$SamAccountName
            [string]$Ou
            [string]$Mail
            [string]$Password
            [System.Object]$Groups
            
            User (){}
            User ([string]$FirstName,[string]$LastName)
            {
                $this.FirstName = $FirstName
                $this.LastName = $LastName
            }
        }


    }
    process{


    }
    end{


    }

}
