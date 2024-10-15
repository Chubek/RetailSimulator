local Customer = {}
Customer.__index = Customer

function Customer.new(info)
	local self = setmetatable({}, Customer)

	self._info = info

	return self
end


function Customer:getName()
	return self._info.name
end


return Customer
