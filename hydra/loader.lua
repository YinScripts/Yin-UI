-- Hydra UI: carga las partes exactas de una version fija de la libreria.
local base = "https://raw.githubusercontent.com/YinScripts/Yin-UI/602113a16a4a2898e13f29b5a498e7bf9355ebf3/hydra/partes/"
local sizes = {30000, 30000, 30000, 30000, 30000, 24125}
local parts, completed, firstError = {}, 0, nil
for i = 1, #sizes do
    task.spawn(function()
        local url = base .. string.format("%03d.txt", i)
        local ok, chunk = pcall(function() return game:HttpGet(url, true) end)
        if not ok or type(chunk) ~= "string" or #chunk ~= sizes[i] then
            firstError = firstError or ("Hydra UI: no se pudo descargar la parte " .. i .. ": " .. tostring(chunk))
        else
            parts[i] = chunk
        end
        completed = completed + 1
    end)
end
while completed < #sizes do task.wait() end
if firstError then error(firstError) end
local source = table.concat(parts)
local compiled, err = loadstring(source, "Hydra UI")
if not compiled then error("Hydra UI: error al compilar: " .. tostring(err)) end
return compiled()
