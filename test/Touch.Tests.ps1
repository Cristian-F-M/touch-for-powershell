BeforeAll {
  . "$PSScriptRoot/../Touch.ps1"
  . "$PSScriptRoot/../Functions/Show-Help.ps1"
  $helpMessage = Show-Help | Out-String
}


AfterAll {
  if (Test-Path "index.js") {
    Remove-Item "index.js" -Force
  }

  If (Test-Path "app-index/") {
    Remove-Item "app-index/" -Force -Recurse
  }
  
  If (Test-Path "app/") {
    Remove-Item "app/" -Force -Recurse
  }

  If (Test-Path "index.js") {
    Remove-Item "index.js" -Force
  }

  If (Test-Path "app----2/") {
    Remove-Item "app----2/" -Force -Recurse
  }

  If (Test-Path "index----2.js") {
    Remove-Item "index----2.js" -Force
  }

  If (Test-Path ".\textResultSingle.txt") {
    Remove-Item ".\textResultSingle.txt" -Force
  }

  if (Test-Path "index--1.js") {
    Remove-Item "index--1.js" -Force
  }

  if (Test-Path "index--2.js") {
    Remove-Item "index--2.js" -Force
  }

  if (Test-Path "app--1/") {
    Remove-Item "app--1/" -Force -Recurse
  }

  if (Test-Path "app--2/") {
    Remove-Item "app--2/" -Force -Recurse
  }

  if (Test-Path "textResultMultiple.txt") {
    Remove-Item "textResultMultiple.txt" -Force
  }

  if (Test-Path "textResultInfiles.txt") {
    Remove-Item "textResultInfiles.txt" -Force
  }

  if (Test-Path "./main/") {
    Remove-Item "./main/" -Force -Recurse
  }

  if (Test-Path "folder new/") {
    Remove-Item "folder new/" -Force -Recurse
  }

  if (Test-Path "file new.js") {
    Remove-Item "file new.js" -Force
  }

  if (Test-Path "file 2.js") {
    Remove-Item "file 2.js" -Force
  }

  if (Test-Path "folder 2/") {
    Remove-Item "folder 2/" -Force -Recurse
  }

  if (Test-Path "./ma in/") {
    Remove-Item "./ma in/" -Force -Recurse
  }

}

Describe "Touch" {
  It "Should throw an error for a empty text" {
    Touch " " | Should -Be "No path specified."
  }

  It "Should show a help message with text '?'" {
    $message = Touch ? | Out-String
    $message | Should -Be $helpMessage
  }


  It "Should show a help message with text 'help'" {
    $message = Touch help | Out-String
    $message | Should -Be $helpMessage
  }

  It "Should show a help message with the flag '-help'" { 
    $message = Touch -help | Out-String
    $message | Should -Be $helpMessage
  }

  It "Shoul throw an error for a file with no extension" {
    Touch "index" | Should -Be "Command not found."
  }

  It "Should create a file with the chosen extension" {
    $message = Touch "index.js" | Out-String

    Test-Path "index.js" | Should -Be $true
    $message.Trim() | Should -Be "File created"
  }

  It "Should whrow an error for a file exists" {
    $message = Touch "Touch.psm1" | Out-String
    $message.Trim() | Should -Be "File already exists"
  }

  It "Should create a folder" {
    $folder = "app-index/"
    $message = Touch "$folder" | Out-String

    $message.Trim() | Should -Be "Folder created"
    Test-Path "$folder" | Should -Be $true
  }

  It "Should throw an error for a folder exists" {

    $message = Touch "test/" | Out-String
    $message.Trim() | Should -Be "Folder already exists"
  }


  It "Should throw an error for a files with no extension" {
    Touch "{index, app/}" | Should -Be "No extension found. Please specify the extension of the file."
  }

  It "Should throw an error for a files with no file names" {
    $message = Touch "{}.js" | Out-String
    
    $message.Trim() | Should -Be "No file names found. Please specify the file names."
  }

  It "Should create multiple files and folders with message single file created" {
    Touch "{index----2, app----2/}.js" | Out-File -FilePath ".\textResultSingle.txt"
    
    '.\textResultSingle.txt' | Should -FileContentMatchMultiline '1 file created.\n?\r?\s*1 folder created.'
    
    Test-Path "index----2.js" | Should -Be $true
    Test-Path "app----2/" | Should -Be $true
  }


  It "Should create multiple files and folders with message multiple files created" {
    Touch "{index--1, index--2, app--2/, app--1/}.js" | Out-File -FilePath ".\textResultMultiple.txt" 
    
    '.\textResultMultiple.txt' | Should -FileContentMatchMultiline '2 files created.\n?\r?\s*2 folders created.'
    
    Test-Path "index--1.js" | Should -Be $true
    Test-Path "index--2.js" | Should -Be $true
    Test-Path "app--1/" | Should -Be $true
    Test-Path "app--2/" | Should -Be $true
  }


  It "Should show a message for command not found" {
    Touch "/src/{index, app/}" | Should -Be "Command not found."
    Touch ".src/{index, app/}" | Should -Be "Command not found."
    Touch "src//{index, app/}" | Should -Be "Command not found."
    Touch "./src{index, app/}" | Should -Be "Command not found."
    Touch "/src/app/.{index, app/}" | Should -Be "Command not found."
  }

  It "Should create multiple files in folder" {
    Touch "./main/src/{index, app/}.js" | Out-File -Path "./textResultInfiles.txt"
    "./textResultInfiles.txt" | Should -FileContentMatchMultiline "1 file created.\n?\r?\s*3 folders created."

    Test-Path -LiteralPath "./main/src/index.js" | Should -Be $true
    Test-Path -LiteralPath "./main/src/app/" | Should -Be $true
    Test-Path -LiteralPath "./main/src/" | Should -Be $true
    Test-Path -LiteralPath "./main/" | Should -Be $true
  }

  It "Should create a folder with spaces in the name" {
    Touch "folder new/" | Should -Be "Folder created"

    Test-Path "folder new/" | Should -Be $true
  }

  It "Should create a folder with spaces in the name" {
    Touch "file new.js" | Should -Be "File created"
    Test-Path "file new.js" | Should -Be $true
  }

  It "Should create a files or folder with spaces in the name" {
    Touch "{file 2, folder 2/}.js" | Out-File -FilePath ".\textResultSingle.txt" 
    ".\textResultSingle.txt" | Should -FileContentMatchMultiline "1 file created.\r?\n?\s*1 folder created.\r?\n?"
    Test-Path "file 2.js" | Should -Be $true
    Test-Path "folder 2/" | Should -Be $true
  }

  It "Should create a files in folder with spaces in the name" {
    Touch "./ma in/s rc/{index, a pp/}.js" | Out-File -Path "./textResultInfiles.txt"
    "./textResultInfiles.txt" | Should -FileContentMatchMultiline "1 file created.\n?\r?\s*3 folders created."

    Test-Path -LiteralPath "./ma in/s rc/index.js" | Should -Be $true
    Test-Path -LiteralPath "./ma in/s rc/a pp/" | Should -Be $true
    Test-Path -LiteralPath "./ma in/s rc/" | Should -Be $true
    Test-Path -LiteralPath "./ma in/" | Should -Be $true
  }
  
}