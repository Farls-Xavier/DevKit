local Loader = {}

local base = "https://raw.githubusercontent.com/Farls-Xavier/DevKit/refs/heads/main"

local modules = {
    Library = "/Library.lua",
    Explorer = "/Explorer.lua",
}

function Loader.load()

    print("Loading", #modules, "modules.")

    local loaded = {}

    for library, path in pairs(modules) do
        local source = game:HttpGet(base .. path)
        loaded[library] = loadstring(source)()
    end

    print("Loaded", #modules, "modules.")

    return loaded

end

return Loader
