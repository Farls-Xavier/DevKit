local Settings = {}

local Defaults = {
    Menu = {
        Keybind = "RightAlt"
    },

    Explorer = {
        Root_Services = {
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
    }
}

function Settings.Load()
    local _ = {}

    return _
end

function Settings.Set()

end

function Settings.Get()

end

return Settings