# Touch

Un comando para **powershell** para crear archivos y carpetas de manera masiva.  


## Uso 

### Uso
```ps1
Touch [comando]
Touch [flag]
```

### Comandos disponibles

Comando | descripción | Ejemplo
--- | --- | ---
`?` | Muestra comandos disponibles | `touch ?`
`help` | Muestra comandos disponibles | `touch help`
`-help` | Muestra comandos disponibles | `touch -help`
`archivo.extensión` | Crea un archivo con la extensión especificada | `touch index.js`
`carpeta/` | Crea una carpeta | `touch app/`
`'{archivo, archivo}.extensión'` | Crea archivos con la extensión especificada | `touch '{index, app}.js'`
`{archivo, carpeta/}.extensión` | Crea archivos o carpetas con la extensión especificada | `touch '{index, app/}.js'`
`'carpeta/{archivo, carpeta/}.extensión'` | Crea archivos o carpetas en una carpeta con la extensión especificada | `touch 'app/{index, app}.js'`