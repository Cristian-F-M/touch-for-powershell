$originalForegroundColor = [Console]::ForegroundColor

function Show-MessageWithColor {
    param(
        [string]$Message,
        [string]$color = $originalForegroundColor
    )

    [Console]::ForegroundColor = $color
    Write-Output $Message
    [Console]::ForegroundColor = $originalForegroundColor
}