local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local SetClipboard = setclipboard or syn and syn.write_clipboard or clipboard and clipboard.set

-- Detect if the user is on a mobile device
local isMobile = UserInputService.TouchEnabled

-- Liste der gültigen Schlüssel
local ValidKeys = {
    "LACAZETTE",
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
    Frame.Size = UDim2.new(0.8, 0, 0.6, 0)  -- 80% Breite, 60% Höhe für Responsivität
    Frame.Position = UDim2.new(0.1, 0, 0.2, 0)  -- Zentriert
    Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.05, 0)
    UICorner.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0.15, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Key System"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.Font = Enum.Font.SourceSansBold
    Title.TextScaled = true
    Title.Parent = Frame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.9, 0, 0.15, 0)
    TextBox.Position = UDim2.new(0.05, 0, 0.25, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.PlaceholderText = "Enter Key Here"
    TextBox.TextSize = 20
    TextBox.Font = Enum.Font.SourceSans
    TextBox.TextScaled = true
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
            wait(1)
            ScreenGui:Destroy()
            -- OrionLib UI laden
            local success, OrionLib = pcall(function()
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
            end)
            if not success then
                warn("Failed to load OrionLib: " .. tostring(OrionLib))
                return
            end
            local Window = OrionLib:MakeWindow({
                Name = "LACAZETTE",
                HidePremium = false,
                SaveConfig = true,
                ConfigFolder = "LACAZETTEConfig",
                IntroEnabled = true,
                IntroText = "LACAZETTE UI",
                IntroIcon = "rbxassetid://127694712584422"
            })

            -- Mobile-Skalierung und Größenanpassung
            if isMobile then
                local uiScale = Instance.new("UIScale")
                uiScale.Scale = 0.7  -- Standard-Skalierung für Mobile
                uiScale.Parent = Window

                -- Pinch-to-Zoom für Größenanpassung
                local startScale = 0.7
                local startPositions = {}
                UserInputService.TouchPanStarted:Connect(function(touchPositions, processedByUI)
                    if not processedByUI then
                        startPositions = touchPositions
                        startScale = uiScale.Scale
                    end
                end)
                UserInputService.TouchPanChanged:Connect(function(touchPositions, delta)
                    if #touchPositions == 2 then
                        local distance = (touchPositions[1].Position - touchPositions[2].Position).Magnitude
                        local startDistance = (startPositions[1].Position - startPositions[2].Position).Magnitude
                        local newScale = math.clamp(startScale * (distance / startDistance), 0.5, 1.2)
                        uiScale.Scale = newScale
                    end
                end)
            end

            -- Tab für #1
            local Tab1 = Window:MakeTab({
                Name = "#1",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })

            local Section1 = Tab1:AddSection({
                Name = "Unit and Speed Controls"
            })

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

            Section1:AddDropdown({
                Name = "Select Unit",
                Default = selectedUnit,
                Options = units,
                Callback = function(value)
                    selectedUnit = value
                end
            })

            Section1:AddButton({
                Name = "Spawn Unit",
                Callback = function()
                    local args = {
                        [1] = selectedUnit,
                        [2] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position),
                        [3] = "8471169909_0"
                    }
                    local success, result = pcall(function()
                        return game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                            .knit.Services.TowerService.RF.PlaceTower:InvokeServer(unpack(args))
                    end)
                    if not success then
                        warn("Spawn Unit failed: " .. tostring(result))
                    end
                end
            })

            Section1:AddDropdown({
                Name = "Select Speed",
                Default = selectedSpeed,
                Options = speeds,
                Callback = function(value)
                    selectedSpeed = value
                end
            })

            Section1:AddButton({
                Name = "Apply Speed",
                Callback = function()
                    local args = {
                        [1] = tonumber(selectedSpeed)
                    }
                    local success, result = pcall(function()
                        return game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                            .knit.Services.SpeedBoostService.RF.ChangeSpeed:InvokeServer(unpack(args))
                    end)
                    if not success then
                        warn("Apply Speed failed: " .. tostring(result))
                    end
                end
            })

            Section1:AddButton({
                Name = "Apply 0.5 Speed",
                Callback = function()
                    local args = {
                        [1] = 0.5
                    }
                    local success, result = pcall(function()
                        return game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                            .knit.Services.SpeedBoostService.RF.ChangeSpeed:InvokeServer(unpack(args))
                    end)
                    if not success then
                        warn("Apply 0.5 Speed failed: " .. tostring(result))
                    end
                end
            })

            Section1:AddButton({
                Name = "Redeem Codes",
                Callback = function()
                    local successCount = 0
                    for _, code in ipairs({"Release", "BloodMoon", "SUMMER"}) do
                        local args = {
                            [1] = code
                        }
                        local success, result = pcall(function()
                            return game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                                .knit.Services.CodeService.RF.SubmitCode:InvokeServer(unpack(args))
                        end)
                        if success and result then
                            successCount = successCount + 1
                        end
                    end
                    OrionLib:MakeNotification({
                        Name = "Codes Redeemed",
                        Content = "Successfully redeemed " .. successCount .. "/3 codes!",
                        Time = 5
                    })
                end
            })

            -- Tab für #2
            local Tab2 = Window:MakeTab({
                Name = "#2",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })

            local Section2 = Tab2:AddSection({
                Name = "Special Actions"
            })

            Section2:AddButton({
                Name = "Spawn Multiple Red Bees",
                Callback = function()
                    local currentCarrots = 300
                    local bonusPerBee = 1000
                    for i = 1, 5 do
                        local args = {
                            [1] = "Red Bee",
                            [2] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))),
                            [3] = "8471169909_0",
                            [4] = bonusPerBee
                        }
                        local success, result = pcall(function()
                            return game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1")
                                .knit.Services.TowerService.RF.PlaceTower:InvokeServer(unpack(args))
                        end)
                        if success and result then
                            currentCarrots = currentCarrots + bonusPerBee
                        else
                            warn("Spawn Red Bee failed at iteration " .. i .. ": " .. tostring(result))
                        end
                        wait(0.1)
                    end
                    OrionLib:MakeNotification({
                        Name = "Red Bees Spawned",
                        Content = "5 Red Bees spawned! Carrots: " .. currentCarrots,
                        Time = 5
                    })
                end
            })

            OrionLib:Init()  -- Initialisierung der OrionLib
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
