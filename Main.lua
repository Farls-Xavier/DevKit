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
local Settigns = Loaded.Settings
local BlurEffect = Loaded.BlurEffect :: BlurEffect

local explorer = Explorer.new(Loaded)

-- Just the ui part of main

local TweenService = Services.TweenService
local UserInputService = Services.UserInputService

local menuOpen = false

UserInputService.InputBegan:Connect(function(input, busy)
    if busy then return end

    if input.KeyCode == Enum.KeyCode[Loaded.Settings.Menu.Keybind] then

        if menuOpen then

            TweenService:Create(BlurEffect, TweenInfo.new(.1), {Size = 0}):Play()

        else

            TweenService:Create(BlurEffect, TweenInfo.new(.1), {Size = 12}):Play()

        end
        
        menuOpen = not menuOpen
    end
end)