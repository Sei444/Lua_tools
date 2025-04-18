-- Comparador de tablas esES vs enUS
local AL = {
    esES = {
		["Alzzin the Wildshaper"] = "Alzzin el Formaferal",
		["Ambassador Flamelash"] = "Embajador Latifuego",
    },

    enUS = {
		["Alzzin the Wildshaper"] = true,
		["Ambassador Flamelash"] = true,
	},
}

--Inicio de funcion de claves extrañas o no encontradas

-- Función para escapar caracteres especiales en patrones
local function escapePattern(text)
    return text:gsub("[%%%.%+%-%*%?%[%]%^%$%(%)]", "%%%0")
end

-- Función para escapar caracteres en CSV
local function escapeCSV(text)
    if text:find('[" ,\n]') then
        return '"' .. text:gsub('"', '""') .. '"'
    end
    return text
end

-- Función para encontrar claves en esES que no están en enUS
function findMissingKeys(esTable, enTable)
    local missingKeys = {}

    for key, _ in pairs(esTable) do
        if not enTable[key] then
            table.insert(missingKeys, key)
        end
    end

    table.sort(missingKeys)
    return missingKeys
end

-- Ejecutar la comparación
local keysToRemove = findMissingKeys(AL.esES, AL.enUS)

-- Exportar a formato CSV para Excel (con escape de caracteres especiales)
local csv = "Clave,Traducción\n"
for _, key in ipairs(keysToRemove) do
    csv = csv .. escapeCSV(key) .. "," .. escapeCSV(AL.esES[key]) .. "\n"
end

-- Guardar en archivo
local file = io.open("claves_a_eliminar.csv", "w")
file:write(csv)
file:close()

print("Archivo generado: claves_a_eliminar.csv")
print(string.format("Se encontraron %d claves en esES que no están en enUS", #keysToRemove))

local function commentKeysInFile(filePath, keys)
    local content = {}
    -- Leer el archivo original
    for line in io.lines(filePath) do
        table.insert(content, line)
    end
    
    -- Buscar y comentar las claves
    for i, line in ipairs(content) do
        for _, key in ipairs(keys) do
            local escapedKey = escapePattern(key)
            local pattern = '%["' .. escapedKey .. '"%]'
            
            if line:match(pattern) then
                print("Encontrada y comentando: " .. key)
                content[i] = "-- " .. line
                break
            end
        end
    end
    
    -- Guardar el archivo modificado
    local file = io.open(filePath, "w")
    file:write(table.concat(content, "\n"))
    file:close()
    print("\nClaves comentadas en el archivo original")
end

-- Preguntar al usuario si quiere comentar las claves
print("\n¿Deseas comentar automáticamente estas claves en el archivo prueba.lua? (s/n)")
local respuesta = io.read()

if respuesta:lower() == 's' then
    commentKeysInFile("prueba.lua", keysToRemove)
else
    print("Puedes comentarlas manualmente usando la lista generada")
end

--Final de funcion de claves extrañas o no encontradas