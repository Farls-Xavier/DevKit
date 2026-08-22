-- Explorer.lua

local Explorer = {}

function Explorer.new(API, Library)
    local self = {}

    self.API = API
    self.Library = Library

    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "DevKitExplorer"
    self.Gui.Parent = game:GetService("CoreGui")

    self.Window = Instance.new("Frame")
    self.Window.Name = "Explorer"
    self.Window.Parent = self.Gui
    self.Window.BackgroundColor3 = Color3.fromRGB(11, 13, 16)
    self.Window.BorderSizePixel = 0
    self.Window.Position = UDim2.fromOffset(100, 100)
    self.Window.Size = UDim2.fromOffset(350, 500)

    function self:CreateNode(instance, depth, y)
        local node = Instance.new("Frame")
        node.Name = instance.Name
        node.Parent = self.Window
        node.BackgroundTransparency = 1
        node.Position = UDim2.fromOffset(0, y)
        node.Size = UDim2.new(1, 0, 0, 20)

        local icon = Instance.new("ImageLabel")
        icon.Name = "Icon"
        icon.Parent = node

        self.Library:SetIcon(icon, instance.ClassName)

        local name = Instance.new("TextLabel")
        name.Name = "Name"
        name.Parent = node
        name.BackgroundTransparency = 1
        name.Position = UDim2.fromOffset(26 + depth * 18, 0)
        name.Size = UDim2.new(1, -30, 1, 0)
        name.Text = instance.Name
        name.TextColor3 = Color3.fromRGB(230, 233, 239)
        name.TextSize = 13
        name.TextXAlignment = Enum.TextXAlignment.Left

        return node
    end

    self:CreateNode(workspace, 0, 0)
    self:CreateNode(workspace.CurrentCamera, 1, 20)

    return self
end

return Explorer