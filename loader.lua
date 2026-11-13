-- Yin UI: descarga concurrente con límite de trabajadores
-- Versión fija: evita mezclar fragmentos de distintas actualizaciones en caché.
local base = "https://raw.githubusercontent.com/YinScripts/Yin-UI/4ebefb1c7a0633ccbe7cecc3f85fa846eff75cc9/dist/partes/"
local total, workers = 41, 6
local partes, nextIndex, completed, firstError = {}, 1, 0, nil
for _ = 1, workers do
    task.spawn(function()
        while true do
            local i = nextIndex
            nextIndex = nextIndex + 1
            if i > total then break end
            local url = base .. string.format("%03d.txt", i)
            local ok, data = pcall(function() return game:HttpGet(url, true) end)
            if not ok or type(data) ~= "string" or #data == 0 then
                firstError = firstError or ("Yin UI: no se pudo descargar " .. url .. ": " .. tostring(data))
            else
                partes[i] = data
            end
            completed = completed + 1
        end
    end)
end
while completed < total do task.wait() end
if firstError then error(firstError) end
local fn, err = loadstring(table.concat(partes), "Yin UI")
if not fn then error("Yin UI: no se pudo compilar: " .. tostring(err)) end
return fn()
