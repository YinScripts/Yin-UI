# Yin UI ✨

Librería UI para Roblox por YinScripts.

## Cargador de prueba

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/YinScripts/Yin-UI/refs/heads/main/loader.lua"))()
```

**Versión experimental:** no ha sido probada en Roblox. El código fuente se está reorganizando; las funciones de `src/modules` se insertan al construir y mantienen su contexto compartido. La distribución se descarga en fragmentos y se compila como un único script: los fragmentos no son módulos independientes en tiempo de ejecución. No se ha demostrado una mejora de rendimiento.

Para reconstruir la distribución, ejecuta `python3 construir.py` y actualiza el número de fragmentos de `loader.lua` si cambia.

## Licencia
Consulta LICENSE. Uso permitido; no se permite publicar versiones modificadas sin autorización del titular.
