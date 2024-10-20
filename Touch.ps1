. "$PSScriptRoot\Functions\Show-MessageWithColor.ps1"
. "$PSScriptRoot\Functions\New-Folder.ps1"
. "$PSScriptRoot\Functions\New-File.ps1"
. "$PSScriptRoot\Functions\Clear-Spaces.ps1"
. "$PSScriptRoot\Functions\Show-Help.ps1"
. "$PSScriptRoot\Functions\New-FilesOrFolders.ps1"
. "$PSScriptRoot\Functions\New-FilesInFolder.ps1"
. "$PSScriptRoot\Functions\Is-Empty.ps1"
. "$PSScriptRoot\Functions\Test-File.ps1"

function Touch {
  param (
    [Parameter(Mandatory = $false)]
    [string]$path,
    [Parameter(Mandatory = $false)]
    [switch]$help
  )

  
  $path = Clear-Spaces $path
 
  
  if ($path -eq "?" -or ($path -eq "help") -or ($path -eq "-h") -or ($help)) {
    Show-Help
    return 
  }

  if (Is-Empty $path) {
    Show-MessageWithColor "No path specified." -Color Red
    return 
  }

  $fileNames = $path -replace "[{}]", "" -replace "\.\w+", "" -split ","


  switch ($path) {
    # ! New-FilesInFolder
    {$PSItem -match "^(\.\/)?[^.\/](.+[^\/\/]\/)+{(.+,?\/?)+}(\..+)?$"} {
      New-FilesInFolders $path
      break
    }
    # ! New-FilesOrFolders

    {$PSItem -match "^{.*}\.?.*"} {
      $extension = Split-Path $path -Extension
      if (Is-Empty $extension) {
        Show-MessageWithColor "No extension found. Please specify the extension of the file." -Color Red
        break
      }
      New-FilesOrFolders $path
      break
    }

  # ! New-Folder
    {$PSItem -match "^.+\/$"} {
      New-Folder $path
      break
    }

  # ! New-File
    {$PSItem -match "^.[^{}]+\..[^\/]+$"} {
      New-File $path
      break
    }

    # ! Default
    default {
      Show-MessageWithColor "Command not found." -Color Red
    }
  }



}