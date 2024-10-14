function Clear-Spaces {
  param ([string]$path)
  $text = $path -replace '\s+', ''
  return $text
}