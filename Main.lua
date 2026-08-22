-- Main.lua

local reference = "https://raw.githubusercontent.com/Farls-Xavier/DevKit/refs/heads/main"

local function Load(path)
    local source = game:HttpGet(reference .. path)
    return loadstring(source)()
end

local Loaded = Load("/Loader.lua").load()

local API = Loaded.API
local Explorer = Loaded.Explorer.new(Loaded)