local Node = {}
Node.__index = Node

function Node.new(value)
    local self = setmetatable({}, Node)
    self.value = value
    self.next = nil
    self.prev = nil
    return self
end

local LinkedList = {}
LinkedList.__index = LinkedList

function LinkedList.new()
    local self = setmetatable({}, LinkedList)
    self.head = nil
    self.tail = nil
    self.size = 0
    return self
end

function LinkedList:insertFront(value)
    local node = Node.new(value)
    if self.tail == nil then        
        self.head = node
        self.tail = node
    else        
        self.tail.next = node
        node.prev = self.tail
        self.tail = node
    end
    self.size = self.size + 1
end

function LinkedList:insertBack(value)
    local node = Node.new(value)
    if self.head == nil then        
        self.head = node
        self.tail = node
    else        
        self.head.prev = node
        node.next = self.head
        self.head = node
    end
    self.size = self.size + 1
end

function LinkedList:remove(node)
    if node == self.head and node == self.tail then        
        self.head = nil
        self.tail = nil
    elseif node == self.head then        
        self.head = self.head.next
        self.head.prev = nil
    elseif node == self.tail then        
        self.tail = self.tail.prev
        self.tail.next = nil
    else        
        node.prev.next = node.next
        node.next.prev = node.prev
    end
    self.size = self.size - 1
end

function LinkedList:removeFront()
    if self.head == nil then
        return nil  
    end

    local value = self.head.value

    if self.head == self.tail then
        
        self.head = nil
        self.tail = nil
    else
        
        self.head = self.head.next
        self.head.prev = nil
    end

    self.size = self.size - 1
    return value
end

function LinkedList:removeBack()
    if self.tail == nil then
        return nil  
    end

    local value = self.tail.value

    if self.head == self.tail then
        self.head = nil
        self.tail = nil
    else
        self.tail = self.tail.prev
        self.tail.next = nil
    end

    self.size = self.size - 1
    return value
end

function LinkedList:peekFront()
    if self.head == nil then
        return nil  
    end
    return self.head.value
end

function LinkedList:peekBack()
    if self.tail == nil then
        return nil  
    end
    return self.tail.value
end

function LinkedList:find(value)
    local current = self.head
    while current do
        if current.value == value then
            return current
        end
        current = current.next
    end
    return nil
end

function LinkedList:map(func)
    local newList = LinkedList.new()
    local current = self.head

    while current do
        newList:append(func(current.value))
        current = current.next
    end

    return newList
end

function LinkedList:apply(func)
    local current = self.head

    while current do
        current.value = func(current.value)
        current = current.next
    end
end

function LinkedList:reduce(func, initial)
    local current = self.head
    local result = initial

    while current do
        result = func(result, current.value)
        current = current.next
    end

    return result
end

function LinkedList:filter(predicate)
    local newList = LinkedList.new()
    local current = self.head

    while current do
        if predicate(current.value) then
            newList:append(current.value)
        end
        current = current.next
    end

    return newList
end

function LinkedList:print()
    local current = self.head
    while current do
        io.write(current.value, " ")
        current = current.next
    end
    print()
end

return LinkedList
