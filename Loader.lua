-- Loader.lua

local Loader = {}

local test_delay = 0.75

local url = "https://raw.githubusercontent.com/Farls-Xavier/DevKit/refs/heads/main"

local modules = {
    Library = "/Library.lua",
    Explorer = "/Explorer.lua",
    API = "/API.lua"
}

local Services = setmetatable({}, {
    __index = function(_, service)
        return game:GetService(service)
    end
}) 

local function createUi()

    local Loadersgui = Instance.new("ScreenGui")
    local Window = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Status = Instance.new("TextLabel")
    local Window_UICorner = Instance.new("UICorner")

    Loadersgui.Name = "DevKitLoader"
    Loadersgui.Parent = Services.CoreGui

    Window.Name = "Window"
    Window.Parent = Loadersgui
    Window.BackgroundColor3 = Color3.fromRGB(11, 13, 16)
    Window.BackgroundTransparency = 0.03
    Window.BorderSizePixel = 0
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.Position = UDim2.fromScale(0.5, 0.5)
    Window.Size = UDim2.fromOffset(450, 300)

    Title.Name = "Title"
    Title.Parent = Window
    Title.BackgroundTransparency = 1
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.277777791, 0, 0.266666681, 0)
    Title.Size = UDim2.fromOffset(200, 13)
    Title.Font = Enum.Font.SourceSansLight
    Title.Text = "DevKit"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18

    Status.Name = "Status"
    Status.Parent = Window
    Status.BackgroundTransparency = 1
    Status.BorderSizePixel = 0
    Status.Position = UDim2.new(0.277777791, 0, 0.333333343, 0)
    Status.Size = UDim2.fromOffset(200, 13)
    Status.Font = Enum.Font.SourceSans
    Status.Text = "Loading..."
    Status.TextColor3 = Color3.fromRGB(230, 233, 239)
    Status.TextSize = 12

    Window_UICorner.CornerRadius = UDim.new(0, 1)
    Window_UICorner.Parent = Window

    local ui = {}

    ui.screenGui = Loadersgui
    ui.window = Window
    ui.title = Title
    ui.status = Status

    function ui:SetStatus(s)
        ui.status.Text = s
        --task.wait(test_delay)
    end

    function ui:Destroy()
        ui.screenGui:Destroy()
    end

    return ui

end

local function createBlur()
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Name = "devKit"
    blurEffect.Enabled = false

    local childAdded = getconnections(Services.Lighting.ChildAdded)

    if #childAdded == 0 then
        blurEffect.Parent = Services.Lighting
    else
        for _, v in childAdded do
            v:Disable()
        end

        blurEffect.Parent = Services.Lighting

        for _, v in childAdded do
            v:Enable()
        end
    end

    return blurEffect
end

local function loadModule(path)

    local source = httpget(url .. path)
    return loadstring(source)()

end

function Loader.load()

    local ui = createUi()
    local blur = createBlur()

    if not isfolder("DevKit") then
        ui:SetStatus("Creating workspace.")
        makefolder("DevKit")
        makefolder("DevKit/API")
    end

    local Loaded = {
        BlurEffect = blur,
        Services = Services
    }

    ui:SetStatus("Loading Library...")
    Loaded.Library = loadModule(modules.Library)

    ui:SetStatus("Loading Explorer...")
    Loaded.Explorer = loadModule(modules.Explorer)

    ui:SetStatus("Loading Roblox API...")
    
    local loadedAPI = loadModule(modules.API)
    Loaded.API = loadedAPI.Load(function(status)
        ui:SetStatus(status)
    end)

    ui:SetStatus("Done loading")

    task.delay(.5, function()
        ui:Destroy()
    end)

    return Loaded

end

return Loader
