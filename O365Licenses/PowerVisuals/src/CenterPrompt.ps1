function CenterPrompt {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$text
    )
    $colorBox = "Red"

    $hostWidth = $host.UI.RawUI.BufferSize.Width
    $promptLength = $host.UI.RawUI.CursorPosition.X
    $spacesToCenter = [Math]::Max(0, ($hostWidth - $promptLength) / 2)
    
    $border = ('═' * ($hostWidth - 4))
    $topBorder = '╔' + $border + '╗'
    $bottomBorder = '╚' + $border + '╝'
    $emptyLine = '║' + (' ' * ($hostWidth - 4)) + '║'
    
    Write-Host $topBorder -ForegroundColor $colorBox
    Write-Host $emptyLine -ForegroundColor $colorBox
    foreach ($line in $text)
    {
        $textLength = $line.Length
        $remainingSpace = $hostWidth - 4 - $textLength
        $leftPadding = [Math]::Max(0, $remainingSpace / 2)
        $rightPadding = $remainingSpace - $leftPadding
        $textLine = '║' + (' ' * $leftPadding) + $line + (' ' * $rightPadding) + '║'
        
        $lineStart = '║' + (' ' * $leftPadding)
        $lineEnd = (' ' * $rightPadding) + '║'
        Write-Host $lineStart -NoNewline -ForegroundColor $colorBox
        Write-Host $line -NoNewline -ForegroundColor Green
        Write-Host $lineEnd -ForegroundColor $colorBox
    }
    Write-Host $emptyLine -ForegroundColor $colorBox
    Write-Host $bottomBorder -ForegroundColor $colorBox
}
