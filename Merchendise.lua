local Merchendise = {}
Merchendise.__index = {}

function Merchendise.new(info)
	local self = setmetatable({}, Merchendise)

	self._info = info

	return self
end


function Merchendise:getName()
	return self._info.name
end

function Merchendise:getPrice()
	return self._info.price
end


return Merchendise
