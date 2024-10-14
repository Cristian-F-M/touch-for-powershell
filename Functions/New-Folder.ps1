function New-Folder {

  param (
      [Parameter(Mandatory = $true)]
      [string]$path
    )
  

  if (Is-Empty $path) {
    Show-MessageWithColor "Path is empty" -Color Red
    return $null
  }


  if (Test-Path $path) {
    Show-MessageWithColor "Folder already exists" -Color Red
    return $null
  }

  New-Item -Path $path -ItemType Directory -Force | Out-Null
  
  if (-not (Test-Path $path)) {
    return $null
  }

  Show-MessageWithColor "Folder created" -Color Green

}