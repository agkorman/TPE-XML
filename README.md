# TPE grupo 7

## Descripción

Este proyecto permite generar una pagina html con informacion sobre el congreso de los Estados Unidos. 

## Listado de archivos
````sh
TPE
├── README.md
├── extract_congress_data.xq
├── generate_html.xsl
├── tpe.sh
└── utils
    ├── congress_data.xsd
    ├── error_handler.xq
    └── generate_error_html.xsl
````
## Seteo de variable de entorno

Primero se debe tener seteada la variable de entorno &CONGRESS_API que se obtiene de la [API del Congreso](https://gpo.congress.gov/)

## Ejecución

Para ejecutar el programa se debe escribir en la consola el siguiente comando

````sh
./tpe.sh <congress_number>
````

Donde <congress_number> puede ser un numero entre 1 y 118 inclusive

## Integrantes

| Nombre            |Legajo | Mail                    |
|-------------------|-------|-------------------------|
| Hernandez Rodrigo | 65522 | rohernandez@itba.edu.ar |
| Korman Agustin    | 65116 | agkorman@itba.edu.ar    |
| Tormakh Eduardo   | 65155 | etormakh@itba.edu.ar    |