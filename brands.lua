local Brand = {}
brand.__index == Brand

local BRANDTIER_Cheap = 1
local BRANDTIER_Street = 2
local BRANDTIER_Luxury = 3
-- add more tiers

function Brand.new(info)
	local self = setmetatable({}, Brand)

	self._info = info

	return self
end

function Brand:getTier()
	return self._info.tier
end

function Brand:getName()
	return self._info.name
end


return Brand
