function Test-File {
  param ([string]$path)
  return Test-Path -Path $path
}