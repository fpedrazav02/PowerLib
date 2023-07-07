function New-ItemList {
    param (
        [Parameter(Mandatory = $true)]
        [string]$text,

        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$colorText = "Green",

        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$backgroundColor = "Black"
    )

    # Get the width of the console window
    $consoleWidth = $Host.UI.RawUI.BufferSize.Width

    # Calculate the number of spaces needed to center the text
    $padding = ($consoleWidth - $text.Length) / 2

    # Generate the padding string
    $paddingString = " " * $padding

    # Create the formatted text
    $formattedText = $paddingString + $text

    # Print the formatted text with custom colors
    Write-Host $formattedText -ForegroundColor $colorText -BackgroundColor $backgroundColor
}
