# Guía para usar Yin UI desde otro script

Esta guía describe la interfaz disponible en la versión actual. Los ejemplos están basados en el código; todavía no se han probado de forma independiente dentro de Roblox.

## Cargar y crear una ventana

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/YinScripts/Yin-UI/refs/heads/main/loader.lua"))()
local YinUI = _G.YinYang

local ventana = YinUI:CreateWindow("Mi interfaz", "Senju")
local pagina = ventana:CreateTab("Principal", "Main")
```

El cargador ejecuta la librería y esta asigna el objeto a `_G.YinYang`. El entorno debe proporcionar `loadstring` y `game:HttpGet`. Puedes agregar un icono a la pestaña: `ventana:CreateTab("Principal", "Main", "rbxassetid://ID")`.

## Chat y Fan Art opcionales

Chat global y Fan Art no se crean ni se inician por defecto. Para incluirlos desde el comienzo, activa las opciones deseadas:

```lua
local ventana = YinUI:CreateWindow("Mi interfaz", "Senju", {
    Chat = true,
    FanArt = true,
})
```

Cada opción es independiente: omitirla o usar `false` deja esa pestaña desactivada. También puedes agregarlas más tarde:

```lua
local chat = ventana:CreateChatTab()
local fanArt = ventana:CreateFanArtTab()
```

Llamar de nuevo a cualquiera de estos métodos devuelve la pestaña existente. El contador del chat se muestra cuando el chat se inicia correctamente.

## Añadir contenido a Créditos

Créditos se crea siempre y conserva su contenido original. Obtén la misma pestaña para añadir tus propios controles debajo:

```lua
local creditos = ventana:GetCreditsTab()
creditos:CreateDivider()
creditos:CreateLabel("Mi equipo", "My team", 16)
creditos:CreateLabel("Creado por mi equipo", "Created by my team", 14)
```

`ventana:CreateCreditsTab()` también devuelve la pestaña existente, sin duplicarla ni borrar sus créditos originales.

## Activar y desactivar: toggle

```lua
local interruptor = pagina:CreateToggle("Mi opción", "My option", false, function(activo)
    print("Estado:", activo)
end)

print(interruptor.GetValue())
interruptor.SetValue(true)
```

`false` es el estado inicial. Al tocarlo, el callback recibe `true` o `false`. `SetValue` actualiza el estado visual, pero no ejecuta el callback: aplica también tu lógica desde el script si lo necesitas.

## Toggle con opción flotante

```lua
local flotante = pagina:CreateFloatingToggle("Mi opción", "My option", false, function(activo)
    print("Estado:", activo)
end)

flotante.SetValue(true)
print(flotante.GetValue())
```

Este control añade opciones para usar el toggle como elemento flotante. Como con el toggle normal, `SetValue` no ejecuta el callback.

## Botón de una sola acción

```lua
pagina:CreateButton("Saludar", "Say hello", function()
    print("¡Botón pulsado!")
end)
```

El callback se ejecuta cada vez que se pulsa. También puedes pasar un icono como cuarto argumento.

## Botón con opción flotante y tiempo de espera

```lua
local boton = pagina:CreateFloatingButton("Acción", "Action", 3, function()
    print("Acción ejecutada")
end)

boton.Fire()         -- Ejecuta la acción si no está en espera
boton.SetCooldown(5) -- Cambia la espera a 5 segundos
```

El número representa segundos de espera entre usos. Se puede omitir: `pagina:CreateFloatingButton("Acción", "Action", function() print("Hola") end)`.

## Deslizador

```lua
local volumen = pagina:CreateSlider("Volumen", 0, 100, 50, function(valor)
    print("Valor:", valor)
end)

print(volumen.Get())
volumen.Set(75)
volumen.Reset()
```

Los argumentos son nombre, mínimo, máximo, valor inicial y función. Usa un máximo mayor que el mínimo.

## Lista desplegable

```lua
local modo = pagina:CreateDropdown("Modo", "Mode", {"Normal", "Rápido", "Suave"}, "Normal", function(valor)
    print("Seleccionado:", valor)
end)

print(modo.GetValue())
modo.SetValue("Suave")
```

`SetValue` cambia el valor mostrado sin ejecutar el callback.

## Texto y separador

```lua
pagina:CreateLabel("Configuración", "Settings", 18)
pagina:CreateDivider()
```

También se puede usar `pagina:CreateLabel("Configuración", 18)`.

## Cuadrícula de imágenes

```lua
local galeria = pagina:CreateImageGrid("Estilos", "Styles", {
    {Image = "rbxassetid://ID_1", LabelES = "Uno", LabelEN = "One"},
    {Image = "rbxassetid://ID_2", LabelES = "Dos", LabelEN = "Two"},
}, function(elemento, indice, seleccionado)
    print(indice, elemento.LabelES, seleccionado)
end, true)

print(galeria.GetSelected())
galeria.SetSelected(1)
```

Sustituye los ID por assets válidos. El último argumento controla si la cuadrícula tiene selección.

## Ventana y apariencia

```lua
ventana:SetTheme("Senju")
ventana:Hide()
ventana:Show()
-- ventana:Destroy() -- Elimina la interfaz
```

`YinUI:GetLanguage()`, `YinUI:GetLanguageMode()`, `YinUI:SetLanguageMode(modo)` y `YinUI:OnLanguageChanged(callback)` gestionan el idioma. Las pestañas y controles que admiten dos textos reciben primero español y después inglés.

## Otras funciones presentes

- `pagina:CreateFloatingToggleSimple(texto, estadoInicial, callback)`: toggle flotante simple.
- `pagina:CreateCombinedToggle(textoES, textoEN)`: control combinado.
- `pagina:CreateScriptToggle(textoES, textoEN, url, clave)`: control para cargar un script externo.
- `pagina:CreateContentContainer(nombre)`, `SetContentContainer(contenedor)`, `GetContentContainer()` y `ResetContentContainer()`: organización de contenido. La compatibilidad con contenedores depende del tipo de control.
- `pagina:CreateWelcomeCard()` y `pagina:CreateServerInfoCard()`: tarjetas de inicio e información.
- `ventana:CreateStatsSection(pagina)`, `GetCreditsTab()`, `CreateCreditsTab()`, `CreateClassicTab()`, `CreateSpotifyTab()`, `CreateChatTab()` y `CreateFanArtTab()`: secciones incorporadas. Chat y Fan Art son opcionales.
- `ventana:SetLibraryVersion(isLarge)`, `SetCompactNavigation(enabled)`, `SetTabIconLayout(layout)` y `SetTextEffect(mode)`: opciones de presentación.
- `YinUI.Kit`: herramientas de bajo nivel para crear ventanas, objetos y componentes visuales personalizados.

Estas funciones adicionales tienen opciones y dependencias propias; consulta el código de la versión actual antes de integrarlas. Esta guía no pretende documentar cada opción del Kit ni de las secciones internas.

