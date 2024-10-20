function New-File {
  param ([string]$path)

  $path = Clear-Spaces $path
  if (Is-Empty $path) {
    Show-MessageWithColor "Path is empty" -Color Red
    return $null
  }
  
  if (Test-Path $path) {
    Show-MessageWithColor "File already exists" -color Red
    return $null
  }
  
  New-Item -Path $path -ItemType File -Force | Out-Null

  if (-not (Test-File $path)) {
    Show-MessageWithColor "File not created" -color Red
    return $null
  }

  Show-MessageWithColor "File created" -Color Green
}