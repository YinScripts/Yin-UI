-- Hydra Script: reune 40 fragmentos fijados a una version concreta.
local BASE = "https://raw.githubusercontent.com/YinScripts/Yin-UI/05fcd5d0152765d33750332e8c71cea9fe7da397/hydra/script_v1/partes/"
local TOTAL, WORKERS, MAX_TRIES = 40, 6, 2
local SPECIAL_SIZES = {[30]=5361, [31]=5895, [38]=5231, [40]=3374}
local parts, nextPart, completed, firstError = {}, 1, 0, nil
for _ = 1, WORKERS do
    task.spawn(function()
        while true do
            local i = nextPart
            nextPart = nextPart + 1
            if i > TOTAL then break end
            local url = BASE .. string.format("%03d.txt", i)
            local expected = SPECIAL_SIZES[i] or 5000
            local chunk
            for attempt = 1, MAX_TRIES do
                local ok, result = pcall(function() return game:HttpGet(url, true) end)
                if ok and type(result) == "string" and #result == expected then
                    chunk = result
                    break
                end
                if attempt < MAX_TRIES then task.wait(0.3) end
            end
            if chunk then
                parts[i] = chunk
            else
                firstError = firstError or ("Hydra: fallo al descargar la parte " .. i)
            end
            completed = completed + 1
        end
    end)
end
while completed < TOTAL do task.wait() end
if firstError then error(firstError) end
local compiled, err = loadstring(table.concat(parts), "Hydra Script")
if not compiled then error("Hydra: error al compilar el script: " .. tostring(err)) end
return compiled()

