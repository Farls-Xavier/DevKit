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

local function createLoaderUi()
    print("Creating loader ui.")
    local Loader = Instance.new("ScreenGui")
    local Window = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Status = Instance.new("TextLabel")
    local Window_UICorner = Instance.new("UICorner")

    Loader.Name = "DevKitLoader"
    Loader.Parent = game:GetService("CoreGui")

    Window.Name = "Window"
    Window.Parent = Loader
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

    return {
        Gui = Loader,
        Window = Window,
        Title = Title,
        Status = Status,
    }
end

local function createBlurSafely()
    print("Creating devKit blurEffect.")
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Name = "devKit"
    blurEffect.Enabled = false

    local childAdded = getconnections(game.Lighting.ChildAdded)

    for i,v in childAdded do
        v:Disable()
    end

    blurEffect.Parent = game.Lighting

    for i,v in childAdded do
        v:Enable()
    end
end  

function Loader.load()
    local count = tableCount(modules)
    local ui = createLoaderUi()

    createBlurSafely()

    print("Loading", count, "modules.")

    local loaded = {}

    for library, path in pairs(modules) do
        ui.Status.Text = "Loading " .. path

        local source = game:HttpGet(base .. path)
        loaded[library] = loadstring(source)()

        print("Loaded", path)
    end

    print("Finished loading", count, "modules.")

    ui.Status.Text = "Finished loading ".. count.. " modules."

    task.delay(0.5, function()
        ui.Gui:Destroy()
    end)

    return loaded

end

return Loader
