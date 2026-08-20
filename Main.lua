local reference = "https://raw.githubusercontent.com/Farls-Xavier/DevKit/refs/heads/main"

local function Load(path)
    local source = game:HttpGet(reference .. path)
    return loadstring(source)()
end

local Loaded = Load("/Loader.lua").load()

-- Retrieve all the loaded stuff I needed ok!!!

local Library = Loaded.Library
local Explorer = Loaded.Explorer
local Services = Loaded.Services
local BlurEffect = Loaded.BlurEffect
