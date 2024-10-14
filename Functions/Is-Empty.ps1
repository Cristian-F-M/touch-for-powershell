function Is-Empty {
  param ([string]$path)
  return [string]::IsNullOrEmpty($path)
}