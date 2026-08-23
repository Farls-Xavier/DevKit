-- Explorer.lua

local Explorer = {}

function Explorer.new(Loaded)
    local self = {}

    self.API = Loaded.API
    self.Library = Loaded.Library
    self.Services = Loaded.Services

    self.Nodes = {}

    self.Roots = { -- add more if i need ill make a config for this too
        "Workspace",
        "Players",
        "CoreGui",
        "Lighting",
        "NetworkClient",
        "ReplicatedFirst",
        "ReplicatedStorage",
        "StarterGui",
        "StarterPack",
        "StarterPlayer",
        "Teams",
        "SoundService",
        "Chat",
        "TextChatService",
    }

    local TweenService = self.Services.TweenService

    -- Developed carpal tunnel doing this i swear
    do 
        self.ScreenGui = Instance.new("ScreenGui")
        self.Window = Instance.new("Frame")
        self.ExplorerScrolling = Instance.new("ScrollingFrame")
        self.ExplorerScrolling_UIListLayout = Instance.new("UIListLayout")
        self.Template_Node = Instance.new("Frame")
        self.NodeActionIcon = Instance.new("ImageButton")
        self.ObjectName = Instance.new("TextLabel")
        self.ObjectName_UIPadding = Instance.new("UIPadding")
        self.ObjectImage = Instance.new("ImageLabel")
        self.Topbar = Instance.new("Frame")
        self.Topbar_Searchbar = Instance.new("TextBox")
        self.Searchbar_UICorner = Instance.new("UICorner")
        self.Searchbar_SearchIcon = Instance.new("ImageLabel")
        self.Searchbar_UIPadding = Instance.new("UIPadding")
        self.Topbar_TextLabel = Instance.new("TextLabel")
        self.Topbar_Close = Instance.new("TextButton")
        self.Topbar_UICorner = Instance.new("UICorner")
        self.Window_UICorner = Instance.new("UICorner")

        self.ScreenGui.Name = "DevKit_Explorer"
        self.ScreenGui.Parent = game:GetService("CoreGui")

        self.Window.Name = "Window"
        self.Window.Parent = self.ScreenGui
        self.Window.BackgroundColor3 = Color3.fromRGB(11, 13, 16)
        self.Window.BackgroundTransparency = 0.050
        self.Window.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.Window.BorderSizePixel = 0
        self.Window.Position = UDim2.new(0.717126369, 0, 0.167481661, 0)
        self.Window.Size = UDim2.new(0, 322, 0, 480)

        self.ExplorerScrolling.Name = "ExplorerScrolling"
        self.ExplorerScrolling.Parent = self.Window
        self.ExplorerScrolling.Active = true
        self.ExplorerScrolling.AutomaticCanvasSize = Enum.AutomaticSize.XY
        self.ExplorerScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        self.ExplorerScrolling.BackgroundTransparency = 1.000
        self.ExplorerScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.ExplorerScrolling.BorderSizePixel = 0
        self.ExplorerScrolling.Size = UDim2.new(0, 322, 0, 480)
        self.ExplorerScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
        self.ExplorerScrolling.ScrollBarThickness = 4

        self.ExplorerScrolling_UIListLayout.Name = "ExplorerScrolling_UIListLayout"
        self.ExplorerScrolling_UIListLayout.Parent = self.ExplorerScrolling
        self.ExplorerScrolling_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        self.Template_Node.Name = "Template_Node"
        self.Template_Node.Parent = self.ExplorerScrolling
        self.Template_Node.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
        self.Template_Node.BackgroundTransparency = 1.000
        self.Template_Node.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.Template_Node.BorderSizePixel = 0
        self.Template_Node.Size = UDim2.new(0, 200, 0, 16)
        self.Template_Node.Visible = false

        self.NodeActionIcon.Name = "NodeActionIcon"
        self.NodeActionIcon.Parent = self.Template_Node
        self.NodeActionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        self.NodeActionIcon.BackgroundTransparency = 1.000
        self.NodeActionIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.NodeActionIcon.BorderSizePixel = 0
        self.NodeActionIcon.Size = UDim2.new(0, 16, 0, 16)
        self.NodeActionIcon.Image = "rbxassetid://6511490623"
        self.NodeActionIcon.ImageRectOffset = Vector2.new(144, 16)
        self.NodeActionIcon.ImageRectSize = Vector2.new(16, 16)
        self.NodeActionIcon.ScaleType = Enum.ScaleType.Crop

        self.ObjectName.Name = "ObjectName"
        self.ObjectName.Parent = self.Template_Node
        self.ObjectName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        self.ObjectName.BackgroundTransparency = 1.000
        self.ObjectName.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.ObjectName.BorderSizePixel = 0
        self.ObjectName.Position = UDim2.new(0.189999998, 0, 0, 0)
        self.ObjectName.Size = UDim2.new(0.810000002, 0, 1, 0)
        self.ObjectName.Font = Enum.Font.SourceSans
        self.ObjectName.Text = "Workspace"
        self.ObjectName.TextColor3 = Color3.fromRGB(139, 147, 161)
        self.ObjectName.TextSize = 14.000
        self.ObjectName.TextXAlignment = Enum.TextXAlignment.Left

        self.ObjectName_UIPadding.Name = "ObjectName_UIPadding"
        self.ObjectName_UIPadding.Parent = self.ObjectName
        self.ObjectName_UIPadding.PaddingLeft = UDim.new(0, 4)

        self.ObjectImage.Name = "ObjectImage"
        self.ObjectImage.Parent = self.Template_Node
        self.ObjectImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        self.ObjectImage.BackgroundTransparency = 1.000
        self.ObjectImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.ObjectImage.BorderSizePixel = 0
        self.ObjectImage.Position = UDim2.new(0.100000001, 0, 0, 0)
        self.ObjectImage.Size = UDim2.new(0, 16, 0, 16)
        self.ObjectImage.Image = "rbxassetid://135148380892747"
        self.ObjectImage.ImageRectOffset = Vector2.new(416, 512)
        self.ObjectImage.ImageRectSize = Vector2.new(32, 32)
        self.ObjectImage.ScaleType = Enum.ScaleType.Crop

        self.Topbar.Name = "Topbar"
        self.Topbar.Parent = self.Window
        self.Topbar.BackgroundColor3 = Color3.fromRGB(36, 42, 51)
        self.Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.Topbar.BorderSizePixel = 0
        self.Topbar.Position = UDim2.new(0, 0, -0.0829999968, 0)
        self.Topbar.Size = UDim2.new(0, 322, 0, 40)

        self.Topbar_Searchbar.Name = "Topbar_Searchbar"
        self.Topbar_Searchbar.Parent = self.Topbar
        self.Topbar_Searchbar.BackgroundColor3 = Color3.fromRGB(25, 29, 35)
        self.Topbar_Searchbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.Topbar_Searchbar.BorderSizePixel = 0
        self.Topbar_Searchbar.Position = UDim2.new(0.0156657957, 0, 0.449999988, 0)
        self.Topbar_Searchbar.Size = UDim2.new(0, 311, 0, 18)
        self.Topbar_Searchbar.ClearTextOnFocus = false
        self.Topbar_Searchbar.Font = Enum.Font.SourceSansSemibold
        self.Topbar_Searchbar.PlaceholderColor3 = Color3.fromRGB(95, 103, 116)
        self.Topbar_Searchbar.PlaceholderText = "Search"
        self.Topbar_Searchbar.Text = ""
        self.Topbar_Searchbar.TextColor3 = Color3.fromRGB(230, 233, 239)
        self.Topbar_Searchbar.TextSize = 14.000
        self.Topbar_Searchbar.TextXAlignment = Enum.TextXAlignment.Left

        self.Searchbar_UICorner.CornerRadius = UDim.new(0, 2)
        self.Searchbar_UICorner.Name = "Searchbar_UICorner"
        self.Searchbar_UICorner.Parent = self.Topbar_Searchbar

        self.Searchbar_SearchIcon.Name = "Searchbar_SearchIcon"
        self.Searchbar_SearchIcon.Parent = self.Topbar_Searchbar
        self.Searchbar_SearchIcon.BackgroundTransparency = 1.000
        self.Searchbar_SearchIcon.Position = UDim2.new(0.951552689, 0, 0.055555556, 0)
        self.Searchbar_SearchIcon.Size = UDim2.new(0, 15, 0, 15)
        self.Searchbar_SearchIcon.Image = "rbxassetid://13850024796"
        self.Searchbar_SearchIcon.ImageColor3 = Color3.fromRGB(95, 103, 116)

        self.Searchbar_UIPadding.Name = "Searchbar_UIPadding"
        self.Searchbar_UIPadding.Parent = self.Topbar_Searchbar
        self.Searchbar_UIPadding.PaddingLeft = UDim.new(0, 2)

        self.Topbar_TextLabel.Name = "Topbar_TextLabel"
        self.Topbar_TextLabel.Parent = self.Topbar
        self.Topbar_TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        self.Topbar_TextLabel.BackgroundTransparency = 1.000
        self.Topbar_TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.Topbar_TextLabel.BorderSizePixel = 0
        self.Topbar_TextLabel.Position = UDim2.new(0.0156655628, 0, -0.0285709389, 0)
        self.Topbar_TextLabel.Size = UDim2.new(0, 77, 0, 17)
        self.Topbar_TextLabel.Font = Enum.Font.SourceSansSemibold
        self.Topbar_TextLabel.Text = "Explorer"
        self.Topbar_TextLabel.TextColor3 = Color3.fromRGB(230, 233, 239)
        self.Topbar_TextLabel.TextSize = 14.000
        self.Topbar_TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        self.Topbar_Close.Name = "Topbar_Close"
        self.Topbar_Close.Parent = self.Topbar
        self.Topbar_Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        self.Topbar_Close.BackgroundTransparency = 1.000
        self.Topbar_Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
        self.Topbar_Close.BorderSizePixel = 0
        self.Topbar_Close.Position = UDim2.new(0.956960738, 0, -0.029999923, 0)
        self.Topbar_Close.Size = UDim2.new(0, 13, 0, 17)
        self.Topbar_Close.Visible = false
        self.Topbar_Close.Font = Enum.Font.SourceSansLight
        self.Topbar_Close.Text = "X"
        self.Topbar_Close.TextColor3 = Color3.fromRGB(230, 233, 239)
        self.Topbar_Close.TextSize = 14.000

        self.Topbar_UICorner.CornerRadius = UDim.new(0, 1)
        self.Topbar_UICorner.Name = "Topbar_UICorner"
        self.Topbar_UICorner.Parent = self.Topbar

        self.Window_UICorner.CornerRadius = UDim.new(0, 1)
        self.Window_UICorner.Name = "Window_UICorner"
        self.Window_UICorner.Parent = self.Window
    end

    function self:CreateNode(object, depth)
        depth = depth or 0
        
        local node = {}

        node.Object = object
        node.Node = self.Template_Node:Clone()
        
        node.Depth = depth
        node.Expanded = false
        node.Children = {}

        node.Node.Name = object:GetFullName()
        node.Node.Visible = true
        node.Node.Parent = self.ExplorerScrolling

        node.Node.ObjectName.Text = object.Name

        local icon = self.Library:GetIcon(object.ClassName)

        node.Node.ObjectImage.Image = icon.Image
        node.Node.ObjectImage.ImageRectOffset = icon.ImageRectOffset
        node.Node.ObjectImage.ImageRectSize = icon.ImageRectSize

        local children = object:GetChildren()

        if #children > 0 then
            node.NodeActionIcon.Visible = true
        else
            node.NodeActionIcon.Visible = false
        end

        if depth > 0 then
            local NodePadding = Instance.new("UIPadding")
            NodePadding.Parent = node.Node

            NodePadding.PaddingLeft = UDim.new(0, node.Depth * 16)
        end

        node.Node.NodeActionIcon.MouseButton1Click:Connect(function()
            if node.Expanded then
                self.Library:SetIcon(node.NodeActionIcon, "Expand", "MiscIconMap")
            else
                self.Library:SetIcon(node.NodeActionIcon, "Collapse", "MiscIconMap")
            end
            
            node.Expanded = not node.Expanded
        end)

        node.Node.MouseEnter:Connect(function()
            TweenService:Create(node.Node, TweenInfo.new(.1), {BackgroundTransparency = .15}):Play()
            TweenService:Create(node.Node.ObjectName, TweenInfo.new(.1), {TextColor3 = Color3.fromRGB(230, 233, 239)}):Play()
        end)

        node.Node.MouseLeave:Connect(function()
            TweenService:Create(node.Node, TweenInfo.new(.1), {BackgroundTransparency = 1}):Play()
            TweenService:Create(node.Node.ObjectName, TweenInfo.new(.1), {TextColor3 = Color3.fromRGB(139, 147, 161)}):Play()
        end)

        self.Nodes[object] = node

        return node
    end

    for _, rootName in pairs(self.Roots) do
        local object = game:FindFirstChild(rootName)

        if object then
            self:CreateNode(object)
        end
    end

    local Nil_Instances = Instance.new("Folder")
    Nil_Instances.Name = "Nil Instances"

    self:CreateNode(Nil_Instances)

    return self
end

return Explorer