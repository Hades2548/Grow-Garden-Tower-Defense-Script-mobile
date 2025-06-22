local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local SetClipboard = setclipboard or syn and syn.write_clipboard or clipboard and clipboard.set

-- Liste der gültigen Schlüssel (kann angepasst oder durch eine API/Datenbank ersetzt werden)
local ValidKeys = {
    "LACAZETTE-ZE867MCZYi",
    "Premium",
    "IloveN1!"
}

-- Funktion zur Erstellung der Key-System UI
local function createKeySystemUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KeySystemUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.8, 0, 0.6, 0)  -- Relative Größe für Responsivität
    Frame.Position = UDim2.new(0.1, 0, 0.2, 0)  -- Zentrierte Positionierung
    Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.05, 0)  -- Relative Rundung
    UICorner.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0.15, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Key System"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24  -- Größere Textgröße für bessere Lesbarkeit
    Title.Font = Enum.Font.SourceSansBold
    Title.TextScaled = true  -- Skaliert den Text automatisch
    Title.Parent = Frame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.9, 0, 0.15, 0)
    TextBox.Position = UDim2.new(0.05, 0, 0.25, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.PlaceholderText = "Enter Key Here"
    TextBox.TextSize = 20
    TextBox.Font = Enum.Font.SourceSans
    TextBox.TextScaled = true  -- Skaliert den Text
    TextBox.Parent = Frame

    local UICornerTextBox = Instance.new("UICorner")
    UICornerTextBox.CornerRadius = UDim.new(0.05, 0)
    UICornerTextBox.Parent = TextBox

    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Size = UDim2.new(0.4, 0, 0.15, 0)
    SubmitButton.Position = UDim2.new(0.3, 0, 0.45, 0)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.Text = "Submit"
    SubmitButton.TextSize = 20
    SubmitButton.Font = Enum.Font.SourceSansBold
    SubmitButton.TextScaled = true
    SubmitButton.Parent = Frame

    local UICornerButton = Instance.new("UICorner")
    UICornerButton.CornerRadius = UDim.new(0.05, 0)
    UICornerButton.Parent = SubmitButton

    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Size = UDim2.new(0.6, 0, 0.15, 0)
    DiscordButton.Position = UDim2.new(0.2, 0, 0.65, 0)
    DiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordButton.Text = "Copy Discord Link"
    DiscordButton.TextSize = 18
    DiscordButton.Font = Enum.Font.SourceSans
    DiscordButton.TextScaled = true
    DiscordButton.Parent = Frame

    local UICornerDiscordButton = Instance.new("UICorner")
    UICornerDiscordButton.CornerRadius = UDim.new(0.05, 0)
    UICornerDiscordButton.Parent = DiscordButton

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0.1, 0)
    StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    StatusLabel.TextSize = 16
    StatusLabel.Font = Enum.Font.SourceSans
    StatusLabel.TextScaled = true
    StatusLabel.Parent = Frame

    -- Funktion zur Schlüsselüberprüfung
    local function checkKey(key)
        for _, validKey in ipairs(ValidKeys) do
            if key == validKey then
                return true
            end
        end
        return false
    end

    -- Submit-Button-Event
    SubmitButton.MouseButton1Click:Connect(function()
        local enteredKey = TextBox.Text
        if checkKey(enteredKey) then
            StatusLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
            StatusLabel.Text = "Key Valid! Loading UI..."
            ScreenGui:Destroy()
            -- Ursprüngliches Skript laden
            local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/main/Discord%20UI%20Lib/Discord%20Lib%20Source.lua"))()
            local win = DiscordLib:Window("LACAZETTE")
            local serv = win:Server("Main", "")

            local units = {
                "Bee", "Black Bunny", "Blood Bunny", "Blood Cat", "Blood Deer", "Blood Headhog",
                "Blood Kiwi", "Blood Owl", "Blue Bee", "Blue Chicken", "Brown Dog", "Bunny", 
                "Cat", "Chicken", "Chicken Jockey", "Deer", "Dog", "Female Deer", "Honey Bear", 
                "Orange Cat", "Owl", "Pig", "Queen Bee", "Raccoon", "Red Bee", "Red Queen Bee", 
                "Small Bee", "Small Dog"
            }

            local speeds = {"1", "2", "3", "4"}
            local selectedUnit = units[1]
            local selectedSpeed = speeds[1]

            local main = serv:Channel("#1")
            local channel2 = serv:Channel("#2")

            main:Dropdown("Select Unit", units, function(value)
                selectedUnit = value
            end)

            main:Button("Spawn Unit", function()
                local args = {
                    [1] = selectedUnit,
                    [2] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position),
                    [3] = "8471169909_0"
                }
                game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                    .knit.Services.TowerService.RF.PlaceTower:InvokeServer(unpack(args))
            end)

            main:Dropdown("Select Speed", speeds, function(value)
                selectedSpeed = value
            end)

            main:Button("Apply Speed", function()
                local args = {
                    [1] = tonumber(selectedSpeed)
                }
                game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                    .knit.Services.SpeedBoostService.RF.ChangeSpeed:InvokeServer(unpack(args))
            end)

            main:Button("Apply 0.5 Speed", function()
                local args = {
                    [1] = 0.5
                }
                game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                    .knit.Services.SpeedBoostService.RF.ChangeSpeed:InvokeServer(unpack(args))
            end)

            main:Button("Redeem Codes", function()
                for _, code in ipairs({"Release", "BloodMoon", "SUMMER"}) do
                    local args = {
                        [1] = code
                    }
                    game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                        .knit.Services.CodeService.RF.SubmitCode:InvokeServer(unpack(args))
                end
                DiscordLib:Notification("Codes Redeemed", "Attempted to redeem all codes!", "Okay")
            end)

            channel2:Button("Spawn Multiple Red Bees", function()
                local currentCarrots = 300 -- Initial value from your image, adjust if this can be read dynamically
                local bonusPerBee = 1000
                for i = 1, 5 do
                    local args Latent Variable Models {
                        [1] = "Red Bee",
                        [2] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))),
                        [3] = "8471169909_0",
                        [4] = bonusPerBee -- Sets the bonus value to 1000 per bee
                    }
                    local success, result = pcall(function()
                        return game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                            .knit.Services.TowerService.RF.PlaceTower:InvokeServer(unpack(args))
                    end)
                    if success and result then
                        currentCarrots = currentCarrots + bonusPerBee -- Add bonus to local count
                    end
                    wait(0.1) -- Short pause to avoid server overload
                end
                DiscordLib:Notification("Red Bees Spawned", "5 Red Bees were spawned! Carrots increased to: " .. currentCarrots, "Okay")
            end)
        else
            StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            StatusLabel.Text = "Invalid Key! Try again."
        end
    end)

    -- Discord-Button-Event
    DiscordButton.MouseButton1Click:Connect(function()
        if SetClipboard then
            SetClipboard("https://discord.gg/QYM5SHz7r9")
            StatusLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
            StatusLabel.Text = "Discord Link Copied!"
        else
            StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            StatusLabel.Text = "Clipboard not supported!"
        end
    end)
end

-- Key-System starten
createKeySystemUI()