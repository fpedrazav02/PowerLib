function New-Divider {
    param (
        [Parameter()]
        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$ColorLine = "Red"
    )

    $consoleWidth = $host.ui.rawui.windowsize.width
    $divider = "═" * $consoleWidth
    Write-Host $divider -ForegroundColor $ColorLine
}