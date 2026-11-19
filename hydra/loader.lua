-- Hydra UI: partes de una version fija, descargadas por hasta cuatro trabajadores.
local base = "https://raw.githubusercontent.com/YinScripts/Yin-UI/5bc97fc1fbae3ec190318017c2c63187572c7d41/hydra/partes_v2/"
local sizes = {15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,9125}
local parts, nextIndex, completed, firstError = {}, 1, 0, nil
for worker = 1, 4 do
    task.spawn(function()
        while true do
            local i = nextIndex
            nextIndex = nextIndex + 1
            if i > #sizes then break end
            local url = base .. string.format("%03d.txt", i)
            local ok, chunk = pcall(function() return game:HttpGet(url, true) end)
            if not ok or type(chunk) ~= "string" or #chunk ~= sizes[i] then
                firstError = firstError or ("Hydra UI: fallo al descargar la parte " .. i)
            else
                parts[i] = chunk
            end
            completed = completed + 1
        end
    end)
end
while completed < #sizes do task.wait() end
if firstError then error(firstError) end
local compiled, err = loadstring(table.concat(parts), "Hydra UI")
if not compiled then error("Hydra UI: error al compilar: " .. tostring(err)) end
return compiled()
