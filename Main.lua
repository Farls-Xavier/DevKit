-- Main.lua

local reference = "https://raw.githubusercontent.com/Farls-Xavier/DevKit/refs/heads/main"

local function Load(path)
    local source = game:HttpGet(reference .. path)
    return loadstring(source)()
end

local Loaded = Load("/Loader.lua").load()

local API = Loaded.API

local Library = Loaded.Library
local Explorer = Loaded.Explorer
local Services = Loaded.Services
local BlurEffect = Loaded.BlurEffect

Explorer.new(API, Library)

-- Do a little test

BlurEffect.Enabled = true

task.wait(.1)

BlurEffect.Enabled = false