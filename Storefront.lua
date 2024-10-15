local Storefront = {}
Storefront.__index = {}

function Storefront.new(info)
	local self = setmetatable({}, Storefront)

	self._info = info

	return self
end


function Storefront:getName()
	return self._info.name
end


function Storefront:getOwner()
	return self._info.owner
end


return Storefront
