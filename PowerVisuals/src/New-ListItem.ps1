function New-ListItem {
    param (
        [Parameter(Mandatory = $true)]
        [string]$text,

        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$colorMarkColor = "Cyan",
        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$colorText = "White"
    )

    $character = '├─'
    Write-Host "`e[3m$character`e[0m" -NoNewline -ForegroundColor $colorMarkColor
    Write-Host "$text" -ForegroundColor $colorText
}
