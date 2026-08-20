local API = {}

local Services = setmetatable({}, {
    __index = function(_, service)
        return game:GetService(service)
    end
})

function API.Load(Status)

    Status("Checking Roblox Version")

    local robloxVersion = httpget("https://clientsettings.roblox.com/v2/client-version/WindowsStudio64/channel/LIVE"):match("(version%-[%w]+)")

    if not robloxVersion then
        Status("Failed to check Roblox's version.")
        error("Failed to check Roblox's version.")
    end

    Status("Roblox version: " .. robloxVersion)
    Status("Getting Roblox API...")

    local rawAPI = httpget("http://setup.roblox.com/" .. robloxVersion .. "-API-Dump.json")
    local api = Services.HttpService:JSONDecode(rawAPI)

    return {
        Version = robloxVersion,
        Raw = rawAPI,
        Data = api
    }
    
end

return API
