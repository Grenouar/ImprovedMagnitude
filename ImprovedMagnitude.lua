-----------------------------------------------------------
------------------------- SERVICES -----------------------
-----------------------------------------------------------

local Players = game:GetService("Players")

-----------------------------------------------------------
--------------------- MODULE DEFINITION -------------------
-----------------------------------------------------------

local ImprovedMagnitude = {}
ImprovedMagnitude.__index = ImprovedMagnitude
ImprovedMagnitude.__type = "ImprovedMagnitude"

-----------------------------------------------------------
----------------------- STATIC DATA -----------------------
-----------------------------------------------------------

local ERR_INVALID_VALUE = 'INVALID VALUE: "%s" need to be a %s'

-----------------------------------------------------------
------------------------- EXPORTS -------------------------
-----------------------------------------------------------

function ImprovedMagnitude.new()
	return setmetatable({
		Type = "Nearest",
		
		HitPoint = Vector3.new(),
		MaxDistance = 0,
		IgnoreList = {},
		Directory = Players
	}, ImprovedMagnitude)
end

function ImprovedMagnitude:Get()
	assert(typeof(self.Type) == "string", ERR_INVALID_VALUE:format("Type", "string"))
	assert(typeof(self.HitPoint) == "Vector3", ERR_INVALID_VALUE:format("HitPoint", "Vector3"))
	assert(typeof(self.MaxDistance) == "number", ERR_INVALID_VALUE:format("MaxDistance", "number"))
	assert(typeof(self.IgnoreList) == "table", ERR_INVALID_VALUE:format("IgnoreList", "table"))
	assert(typeof(self.Directory) == "Instance", ERR_INVALID_VALUE:format("Directory", "Instance"))
	
	local Distances = {}
	
	local AllUsers = Players:GetPlayers()
	if not self.Directory:IsA("Players") then
		AllUsers = self.Directory:GetChildren()
	end
	
	for _,User in ipairs(AllUsers) do
		local Character = User
		if User:IsA("Player") then
			Character = User.Character
		end
		
		if Character and Character.Parent and Character:IsA("Model") then
			local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
			if not Humanoid then continue end
			
			if table.find(self.IgnoreList, Character) then
				continue
			end
			
			local Pos, Size = Character:GetBoundingBox()

			local MaxDistance = Size.Y
			if self.MaxDistance > 0 then
				MaxDistance = self.MaxDistance
			end

			local Distance = (self.HitPoint - Pos.Position).Magnitude
			if Distance <= MaxDistance then
				table.insert(Distances, {
					Character = Character,
					Distance = Distance
				})
			end
		end
	end
	
	local DescTypes = {"desc", "farthest", "furthest"}
	table.sort(Distances, function(a, b)
		local Order = a.Distance < b.Distance
		if table.find(DescTypes, string.lower(self.Type)) then
			Order = a.Distance > b.Distance
		end
		
		return Order
	end)
	
	local InRange = {}
	for _,Properties in ipairs(Distances) do
		local Character = Properties.Character
		if Character then
			table.insert(InRange, Character)
		end
	end
	
	local UniqueTypes = {"nearest", "closest", "farthest", "furthest"}
	if table.find(UniqueTypes, string.lower(self.Type)) then
		if not InRange or not InRange[1] then
			return
		end
		
		return InRange[1], Players:GetPlayerFromCharacter(InRange[1])
	end
	
	return InRange
end

return ImprovedMagnitude
