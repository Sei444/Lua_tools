# Lua_tools

Herramienta para poder descubrir y comentar las claves lua que esten mal indexadas o que no esten en la traduccion inicial

## Como Correr?
 - Descargar Lua desde la pagina oficial https://luabinaries.sourceforge.net
 - Verificar si Lua esta instalado en PATH. Win+R => cmd => where lua
 - Verificar la version de Lua Win+R => cmd => lua -v
 - lua /prueba.lua

## Resultados
  - Preguntara si quieres comentar las claves encontradas son s/n
  - Creara un archivo svg para poder ver que claves lua se comentaron, tener un detalle y es que posiblemente los nombres con - / * + etc, como ser Path-pather puede que no muestre en svg pero si en el codigo comentado
