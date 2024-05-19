local Reign = {};

-- Functions
function Reign:Make(Data)
    local instance = Instance.new(Data.Instance);

    if Data.Properties then
        for prop, value in Data.Properties do
            instance[prop] = value;
        end
    end

    if Data.Attributes then
        for attr, value in Data.Attributes do
            instance:SetAttribute(attr, value);
        end
    end

    if Data.Tags then
        for value in Data.Tags do
            instance:AddTag(value);
        end
    end

    if instance:IsA("TextButton") or instance:IsA("ImageButton") then
        if Data.OnClick then
            instance[Data.OnClick.Button]:Connect(Data.OnClick.Callback);
        end
    end

    return instance;
end

function Reign:Update(Data)
    local instance = Data.Instance;

    if Data.Properties then
        for prop, value in Data.Properties do
            instance[prop] = value;
        end
    end

    if Data.Attributes then
        for attr, value in Data.Attributes do
            instance:SetAttribute(attr, value);
        end
    end

    if Data.Tags then
        for tag, value in Data.Tags do
            instance:RemoveTag(tag);
            instance:AddTag(value);
        end
    end

    if instance:IsA("TextButton") or instance:IsA("ImageButton") then
        if Data.OnClick then
            instance[Data.OnClick.Button]:Connect(Data.OnClick.Callback);
        end
    end

    return instance;
end

function Reign:OnKeydown(Data)
    local key = Data.Key;
    local callback = Data.Callback;

    game:GetService("UserInputService").InputChanged:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end;
        if input.KeyCode == Enum.KeyCode[key] then
            if input.UserInputState == Enum.UserInputState.Begin then
                task.spawn(callback);
            else
                task.cancel(callback);
            end
        end
    end)
end

return Reign;
