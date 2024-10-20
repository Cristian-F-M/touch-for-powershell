function New-FilesInFolders {
  param (
    [Parameter(Mandatory = $true)]
    [string]$path
  )


  $firstFolders = $path -replace "{(.+,?\/?)+}(\..+)?", ""
  $extension = Split-Path $path -Extension
  $fileNames = $path -replace "^(.*?)(?=\{[^}]*\})", "" -replace "\..+", "" -replace "[{}]", "" -split ","

  $foldersCreated = 0
  $filesCreated = 0

  forEach($f in ($firstFolders -split "/")) {
    if ($f -eq "." -or ($f -eq "")) {
      continue
    }
    $foldersCreated++
  }


  If (-not (Is-Empty $fileNames)) {
    New-Item -Path $firstFolders -ItemType Directory -Force | Out-Null
  }

  

  If ($fileNames.Count -le 0) {
    Show-MessageWithColor "No file names found. Please specify the file names." -Color Red
    return $null
  }

  forEach ($fileName in $fileNames) {
    $fileName = Clear-Spaces $fileName
    if (Is-Empty $fileName) {
      continue
    }

    if ($fileName -match "^.+[^\/]$") {
      New-Item -Path "$firstFolders$fileName$extension" -ItemType File -Force  | Out-Null
      $filesCreated++
      continue
    }

    if ($fileName -match "^.+\/$") {
      New-Item -Path $firstFolders$fileName -ItemType Directory -Force | Out-Null
      $foldersCreated++
      continue
    }
  }

  if ($filesCreated -gt 0) {
    Show-MessageWithColor "$filesCreated $(($filesCreated -le 1) ? 'file' : 'files') created." -Color Green 
  }

  if ($foldersCreated -gt 0) {
    Show-MessageWithColor "$foldersCreated $(($foldersCreated -le 1) ? 'folder' : 'folders') created." -Color Green
  }

}


