local KEY = "Free_35c02"
local savedPos = nil
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Curata vechi GUI
if CoreGui:FindFirstChild("SpicyHub") then
	CoreGui.SplicyHub:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "SpicyHub"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- Loading Screen
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1,0,1,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = gui

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1,0,0.1,0)
loadingText.Position = UDim2.new(0,0,0.45,0)
loadingText.Text = "Wait"
loadingText.Font = Enum.Font.SourceSansBold
loadingText.TextSize = 36
loadingText.TextColor3 = Color3.new(1,1,1)
loadingText.BackgroundTransparency = 1
loadingText.Parent = loadingFrame

local progressBarBack = Instance.new("Frame")
progressBarBack.Size = UDim2.new(0.6,0,0.04,0)
progressBarBack.Position = UDim2.new(0.2,0,0.6,0)
progressBarBack.BackgroundColor3 = Color3.fromRGB(50,50,50)
progressBarBack.BorderSizePixel = 0
progressBarBack.AnchorPoint = Vector2.new(0,0.5)
progressBarBack.Parent = loadingFrame

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0,0,1,0)
progressBar.BackgroundColor3 = Color3.fromRGB(255,0,0)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBarBack

local progressText = Instance.new("TextLabel")
progressText.Size = UDim2.new(1,0,0.05,0)
progressText.Position = UDim2.new(0,0,0.65,0)
progressText.Text = "0%"
progressText.Font = Enum.Font.SourceSansBold
progressText.TextSize = 20
progressText.TextColor3 = Color3.new(1,1,1)
progressText.BackgroundTransparency = 1
progressText.Parent = loadingFrame

local progressStages = {0,15,46,70,98,100}
for _, val in ipairs(progressStages) do
	progressBar:TweenSize(UDim2.new(val/100,0,1,0), "Out", "Quad", 0.7, true)
	progressText.Text = val .. "%"
	wait(0.8)
end
loadingFrame:Destroy()

-- Toggle Button (≡), invizibil la start
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0,40,0,40)
toggleBtn.Position = UDim2.new(0,10,0.4,0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Text = "≡"
toggleBtn.Parent = gui
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Visible = false

-- Key Input Frame
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,300,0,150)
keyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = gui
keyFrame.Visible = true

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1,0,0.3,0)
keyLabel.Text = "Enter Key:"
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.SourceSansBold
keyLabel.TextSize = 22
keyLabel.BackgroundTransparency = 1
keyLabel.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0.3,0)
keyBox.Position = UDim2.new(0.1,0,0.4,0)
keyBox.PlaceholderText = "" -- Nu arata cheia
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 20
keyBox.Text = ""
keyBox.TextColor3 = Color3.new(0,0,0)
keyBox.BackgroundColor3 = Color3.new(1,1,1)
keyBox.Parent = keyFrame

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.5,0,0.2,0)
keyBtn.Position = UDim2.new(0.25,0,0.75,0)
keyBtn.Text = "Submit"
keyBtn.Font = Enum.Font.SourceSansBold
keyBtn.TextSize = 18
keyBtn.BackgroundColor3 = Color3.fromRGB(60,150,60)
keyBtn.TextColor3 = Color3.new(1,1,1)
keyBtn.Parent = keyFrame

-- Main Menu Frame
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0,300,0,370)
menu.Position = UDim2.new(0.1,0,0.2,0)
menu.BackgroundColor3 = Color3.fromRGB(35,35,35)
menu.Visible = false
menu.Active = true
menu.Draggable = true
menu.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.1,0)
title.Text = "Spicy Hub - by albertozrl0"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Parent = menu

-- Close Button X
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(150,30,30)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = menu

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	savedPos = nil
end)

-- ESP Button
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.9,0,0.12,0)
espBtn.Position = UDim2.new(0.05,0,0.13,0)
espBtn.Text = "ESP: OFF"
espBtn.Font = Enum.Font.SourceSans
espBtn.TextSize = 20
espBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
espBtn.TextColor3 = Color3.new(1,1,1)
espBtn.Parent = menu

local espEnabled = false

local function addHighlightToCharacter(char)
	if char and not char:FindFirstChild("ESPHighlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "ESPHighlight"
		highlight.FillColor = Color3.new(1,0,0)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 1
		highlight.Parent = char
	end
end

local function removeHighlightFromCharacter(char)
	if char and char:FindFirstChild("ESPHighlight") then
		char.ESPHighlight:Destroy()
	end
end

espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espBtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= Players.LocalPlayer then
			if espEnabled then
				if player.Character then
					addHighlightToCharacter(player.Character)
				end
				player.CharacterAdded:Connect(function(c)
					if espEnabled then
						addHighlightToCharacter(c)
					end
				end)
			else
				if player.Character then
					removeHighlightFromCharacter(player.Character)
				end
			end
		end
	end
end)

-- Save Position Button
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9,0,0.15,0)
saveBtn.Position = UDim2.new(0.05,0,0.3,0)
saveBtn.Text = "Save Position"
saveBtn.Font = Enum.Font.SourceSans
saveBtn.TextSize = 20
saveBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
saveBtn.TextColor3 = Color3.new(1,1,1)
saveBtn.Parent = menu

saveBtn.MouseButton1Click:Connect(function()
	local char = Players.LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		savedPos = char.HumanoidRootPart.Position
		saveBtn.Text = "Saved!"
		wait(1)
		saveBtn.Text = "Save Position"
	end
end)

-- Teleport Button
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9,0,0.15,0)
tpBtn.Position = UDim2.new(0.05,0,0.5,0)
tpBtn.Text = "Teleport to Saved"
tpBtn.Font = Enum.Font.SourceSans
tpBtn.TextSize = 20
tpBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.Parent = menu

tpBtn.MouseButton1Click:Connect(function()
	local char = Players.LocalPlayer.Character
	if savedPos and char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = CFrame.new(savedPos)
	end
end)

-- Speed Input Box
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.6,0,0.12,0)
speedBox.Position = UDim2.new(0.05,0,0.7,0)
speedBox.PlaceholderText = "Speed 0 - 100"
speedBox.Font = Enum.Font.SourceSans
speedBox.TextSize = 18
speedBox.Text = ""
speedBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
speedBox.TextColor3 = Color3.fromRGB(0,0,0)
speedBox.Parent = menu

local applySpeedBtn = Instance.new("TextButton")
applySpeedBtn.Size = UDim2.new(0.3,0,0.12,0)
applySpeedBtn.Position = UDim2.new(0.65,0,0.7,0)
applySpeedBtn.Text = "Apply"
applySpeedBtn.Font = Enum.Font.SourceSansBold
applySpeedBtn.TextSize = 18
applySpeedBtn.BackgroundColor3 = Color3.fromRGB(60,120,200)
applySpeedBtn.TextColor3 = Color3.fromRGB(255,255,255)
applySpeedBtn.Parent = menu

applySpeedBtn.MouseButton1Click:Connect(function()
	local value = tonumber(speedBox.Text)
	local char = Players.LocalPlayer.Character
	if value and value >= 0 and value <= 100 and char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = value
	else
		speedBox.Text = "Invalid"
	end
end)

-- Toggle menu visibility with toggleBtn
toggleBtn.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)

-- Key submit button logic
keyBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == KEY then
		keyFrame.Visible = false
		toggleBtn.Visible = true
		menu.Visible = false
	else
		keyLabel.Text = "Wrong key!"
	end
end)
