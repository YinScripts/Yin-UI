-- Yin UI: descargador de la versión inicial
local base = "https://raw.githubusercontent.com/YinScripts/Yin-UI/refs/heads/main/dist/partes/"
local partes = {}
for i = 1, 40 do
    local url = base .. string.format("%03d.txt", i)
    local ok, data = pcall(function() return game:HttpGet(url, true) end)
    if not ok or type(data) ~= "string" or #data == 0 then error("Yin UI: no se pudo descargar " .. url .. ": " .. tostring(data)) end
    partes[i] = data
end
local fn, err = loadstring(table.concat(partes), "Yin UI")
if not fn then error("Yin UI: no se pudo compilar: " .. tostring(err)) end
return fn()
