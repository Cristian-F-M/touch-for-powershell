$Global:commandsHelp = @(
  [pscustomobject]@{ Comand = '?'; Description = 'Muestra comandos disponibles' }
  [pscustomobject]@{ Comand = 'archivo.ext'; Description = 'Crea un archivo en la ruta "."' }
  [pscustomobject]@{ Comand = '{archivo_1, archivo_2, carpeta/}.ext'; Description = 'Crea archivos con la extensión "ext" y carpetas en la ruta "."' }
  [pscustomobject]@{ Comand = 'carpeta/'; Description = 'Crea una carpeta en la ruta "."' }
  [pscustomobject]@{ Comand = 'carpeta/{archivo_1, archivo_2, carpeta_2/}.ext'; Description = 'Crea los archivos con la extensión "ext" y carpetas en la ruta "carpeta/"' } 
)


function Show-Help {
  Show-MessageWithColor 'Uso' 'white'
  Show-MessageWithColor ' touch [comando]' 'white'
  Show-MessageWithColor '' 'white'
  Show-MessageWithColor 'Comandos diponibles:' 'white'
  $commandsHelp | Format-Table -Property Comand, Description -HideTableHeaders
}
