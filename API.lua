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

    Status("Decoding Roblox API...")

    local api = Services.HttpService:JSONDecode(rawAPI)

    Status("Parsing Roblox classes...")

    local classes = {}

    for _, class in pairs(api.Classes) do

        local newClass = {}

        newClass.Name = class.Name
        newClass.Superclass = class.Superclass

        newClass.Properties = {}
        newClass.Functions = {}
        newClass.Events = {}
        newClass.Callbacks = {}
        newClass.Tags = {}

        -- Class tags
        if class.Tags then
            for _, tag in pairs(class.Tags) do
                newClass.Tags[tag] = true
            end
        end

        -- Class members
        for _, member in pairs(class.Members) do

            local newMember = {}

            newMember.Name = member.Name
            newMember.Class = class.Name
            newMember.Security = member.Security
            newMember.Tags = {}

            -- Member tags
            if member.Tags then
                for _, tag in pairs(member.Tags) do
                    newMember.Tags[tag] = true
                end
            end

            if member.MemberType == "Property" then

                newMember.ValueType = member.ValueType
                newMember.Category = member.Category or "Other"
                newMember.Serialization = member.Serialization

                table.insert(newClass.Properties, newMember)

            elseif member.MemberType == "Function" then

                newMember.Parameters = {}
                newMember.ReturnType = member.ReturnType
                    and member.ReturnType.Name

                if member.Parameters then
                    for _, parameter in pairs(member.Parameters) do
                        table.insert(newMember.Parameters, {
                            Name = parameter.Name,
                            Type = parameter.Type.Name
                        })
                    end
                end

                table.insert(newClass.Functions, newMember)

            elseif member.MemberType == "Event" then

                newMember.Parameters = {}

                if member.Parameters then
                    for _, parameter in pairs(member.Parameters) do
                        table.insert(newMember.Parameters, {
                            Name = parameter.Name,
                            Type = parameter.Type.Name
                        })
                    end
                end

                table.insert(newClass.Events, newMember)

            elseif member.MemberType == "Callback" then

                newMember.Parameters = {}
                newMember.ReturnType = member.ReturnType
                    and member.ReturnType.Name

                if member.Parameters then
                    for _, parameter in pairs(member.Parameters) do
                        table.insert(newMember.Parameters, {
                            Name = parameter.Name,
                            Type = parameter.Type.Name
                        })
                    end
                end

                table.insert(newClass.Callbacks, newMember)

            end
        end

        classes[class.Name] = newClass
    end

    Status("Building class inheritance...")

    -- Convert superclass names into actual class references.
    for _, class in pairs(classes) do
        if class.Superclass then
            class.Superclass = classes[class.Superclass]
        end
    end

    Status("Parsing Roblox enums...")

    local enums = {}

    for _, enum in pairs(api.Enums) do

        local newEnum = {}

        newEnum.Name = enum.Name
        newEnum.Items = {}
        newEnum.Tags = {}

        if enum.Tags then
            for _, tag in pairs(enum.Tags) do
                newEnum.Tags[tag] = true
            end
        end

        for _, item in pairs(enum.Items) do

            table.insert(newEnum.Items, {
                Name = item.Name,
                Value = item.Value
            })

        end

        enums[enum.Name] = newEnum
    end

    Status("Building member lookup...")

    local function GetMember(className, memberType)

        local class = classes[className]

        if not class then
            return
        end

        if not class[memberType] then
            return
        end

        local result = {}

        local currentClass = class

        while currentClass do

            for _, member in pairs(currentClass[memberType]) do
                table.insert(result, member)
            end

            currentClass = currentClass.Superclass
        end

        table.sort(result, function(a, b)
            return a.Name < b.Name
        end)

        return result
    end

    Status("Roblox API ready.")

    return {
        Version = robloxVersion,

        Raw = rawAPI,
        Data = api,

        Classes = classes,
        Enums = enums,

        GetMember = GetMember
    }
end

return API
