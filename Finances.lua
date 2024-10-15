local Finances = {}
Finances.__index = Finances

function Finances.new(entity, info)
	local self = setmetatable({}, Finances)

	self._entity = entity
	self._info = info

	return self
end




return Finances
