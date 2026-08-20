local Loader = {}

local base = "https://raw.githubusercontent.com/Farls-Xavier/DevKit/refs/heads/main"

local modules = {
    Library = "/Library.lua",
    Explorer = "/Explorer.lua",
}

local function tableCount(tbl)
    local count = 0

    for _ in pairs(tbl) do
        count += 1
    end

    return count
end

function Loader.load()
    local count = table.getn(modules)

    print("Loading", count, "modules.")

    local loaded = {}

    for library, path in pairs(modules) do
        local source = game:HttpGet(base .. path)
        loaded[library] = loadstring(source)()
        print("Loaded", path)
    end

    print("Finished loading", count, "modules.")

    return loaded

end

return Loader
