local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")


local function teleportToPlayer(username)
    local targetPlayer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name:lower() == username:lower() then
            targetPlayer = player
            break
        end
    end
    
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            print("Teleported to " .. targetPlayer.Name)
        else
            warn("LocalPlayer's character not found!")
        end
    else
        warn("Player " .. username .. " not found or has no character!")
    end
end

local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.5, -100, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Position = UDim2.new(1, -30, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
minimizeButton.Text = "-"
minimizeButton.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 180, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 30)
textBox.PlaceholderText = "Enter username"
textBox.Text = ""
textBox.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 30)
button.Position = UDim2.new(0, 10, 0, 70)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Text = "Teleport"
button.Parent = frame

local isMinimized = false

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        frame.Size = UDim2.new(0, 200, 0, 30)
        textBox.Visible = false
        button.Visible = false
        minimizeButton.Text = "+"
    else
        frame.Size = UDim2.new(0, 200, 0, 120)
        textBox.Visible = true
        button.Visible = true
        minimizeButton.Text = "-"
    end
end)

button.MouseButton1Click:Connect(function()
    local username = textBox.Text
    if username ~= "" then
        teleportToPlayer(username)
    else
        warn("Please enter a username!")
    end
end)