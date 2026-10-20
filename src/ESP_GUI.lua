-- ESP_GUI.lua

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ESP
local function createESP(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")

    local esp = Instance.new("BillboardGui")
    esp.Name = "ESP"
    esp.Parent = head
    esp.Adornee = head
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 100, 0, 50)
    esp.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = esp
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = player.Name
    textLabel.TextScaled = true

    local function updateESP()
        if humanoid.Health > 0 then
            textLabel.TextColor3 = Color3.new(0, 1, 0) -- Green
        else
            textLabel.TextColor3 = Color3.new(1, 0, 0) -- Red
        end
    end

    humanoid.HealthChanged:Connect(updateESP)
    updateESP()
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        createESP(player)
    end)

    if player.Character then
        createESP(player)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESPSettings"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "ESP Settings"
title.TextScaled = true

local colorPickerLabel = Instance.new("TextLabel")
colorPickerLabel.Parent = frame
colorPickerLabel.Size = UDim2.new(0.5, 0, 0, 30)
colorPickerLabel.Position = UDim2.new(0, 10, 0, 40)
colorPickerLabel.BackgroundTransparency = 1
colorPickerLabel.TextColor3 = Color3.new(1, 1, 1)
colorPickerLabel.Text = "Color:"
colorPickerLabel.TextScaled = true

local colorPicker = Instance.new("TextBox")
colorPicker.Parent = frame
colorPicker.Size = UDim2.new(0.5, 0, 0, 30)
colorPicker.Position = UDim2.new(0.5, 0, 0, 40)
colorPicker.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
colorPicker.TextColor3 = Color3.new(1, 1, 1)
colorPicker.Text = "255, 255, 255"

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Parent = frame
sliderLabel.Size = UDim2.new(0.5, 0, 0, 30)
sliderLabel.Position = UDim2.new(0, 10, 0, 80)
sliderLabel.BackgroundTransparency = 1
sliderLabel.TextColor3 = Color3.new(1, 1, 1)
sliderLabel.Text = "Size:"
sliderLabel.TextScaled = true

local slider = Instance.new("TextBox")
slider.Parent = frame
slider.Size = UDim2.new(0.5, 0, 0, 30)
slider.Position = UDim2.new(0.5, 0, 0, 80)
slider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
slider.TextColor3 = Color3.new(1, 1, 1)
slider.Text = "1"

local applyButton = Instance.new("TextButton")
applyButton.Parent = frame
applyButton.Size = UDim2.new(0.5, 0, 0, 30)
applyButton.Position = UDim2.new(0.25, 0, 0, 120)
applyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
applyButton.TextColor3 = Color3.new(1, 1, 1)
applyButton.Text = "Apply"

local function applySettings()
    local r, g, b = colorPicker.Text:match("(%d+), (%d+), (%d+)")
    local size = tonumber(slider.Text)

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local esp = head:FindFirstChild("ESP")
                if esp then
                    esp.Size = UDim2.new(0, size * 100, 0, size * 50)
                    esp.TextLabel.TextColor3 = Color3.new(r / 255, g / 255, b / 255)
                end
            end
        end
    end
end

applyButton.MouseButton1Click:Connect(applySettings)