function New-FilesOrFolders {
  param (
    [Parameter(Mandatory = $true)]
    [string]$text
  )

  $text = Clear-Spaces $text
  $extension = Split-Path $text -Extension
  $fileNames = $text -replace "[{}]", "" -replace "\..+", ""

  if (Is-Empty(Clear-Spaces $fileNames)) {
    Show-MessageWithColor "No file names found. Please specify the file names." -Color Red
    return $null
  }

  $fileNames = $fileNames -split ","


  if ($fileNames.Count -le 0) {
    Show-MessageWithColor "No file names found. Please specify the file names." -Color Red
    return $null
  }


  $filesAlreadyExist = @()
  $cantFilesCreated = 0
  $cantFoldersCreated = 0


  forEach ($fileName in $fileNames) {
    $fileName = Clear-Spaces $fileName

    if (Is-Empty $fileName) {
      continue
    }

    $isFile = $fileName -match "^.+[^\/]$"
    $isFolder = $fileName -match "^.+\/$"
    $folderAlreadyExists = Test-File $fileName
    $fileAlreadyExists = Test-File "$fileName$extension"

    if ($isFile -and $fileAlreadyExists) {
      $filesAlreadyExist += "File '$fileName$extension' already exists."
      continue
    }

    if ($isFolder -and ($folderAlreadyExists)) {
      $filesAlreadyExist += "Folder '$fileName' already exists."
      continue
    }

    if ($isFile) {
      New-Item -Path "$fileName$extension" -ItemType File -Force  | Out-Null
      $cantFilesCreated++
      continue
    }

    if ($isFolder) {
      New-Item -Path $fileName -ItemType Directory -Force | Out-Null
      $cantFoldersCreated++
      continue
    }
  }

  if ($filesAlreadyExist.Count -gt 0) {
    forEach ($fileAlreadyExists in $filesAlreadyExist) {
      Show-MessageWithColor $fileAlreadyExists -Color Red
    }
  }

  if ($cantFilesCreated -gt 0) {
    Show-MessageWithColor "$cantFilesCreated $(($cantFilesCreated -le 1) ? 'file' : 'files') created." -Color Green 
  }

  if ($cantFoldersCreated -gt 0) {
    Show-MessageWithColor "$cantFoldersCreated $(($cantFoldersCreated -le 1) ? 'folder' : 'folders') created." -Color Green
  }


}