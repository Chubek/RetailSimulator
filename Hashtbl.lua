local LinkedList = require('LinkedList')

local Hashtbl = {}
Hashtbl.__index = Hashtbl

local function hash(key, size)
    local hash_value = 0
    for i = 1, #key do
        hash_value = (hash_value + string.byte(key, i)) % size
    end
    return hash_value + 1  end

function Hashtbl.new(size)
    local self = setmetatable({}, Hashtbl)
    self.size = size or 16      
    self.buckets = {}

    for i = 1, self.size do
        self.buckets[i] = LinkedList.new()
    end

    return self
end

function Hashtbl:insert(key, value)
    local index = hash(key, self.size)
    local bucket = self.buckets[index]

    local current = bucket.head
    while current do
        if current.value.key == key then
            current.value.value = value
            return
        end
        current = current.next
    end

    bucket:append({ key = key, value = value })
end

function Hashtbl:get(key)
    local index = hash(key, self.size)
    local bucket = self.buckets[index]

    local current = bucket.head
    while current do
        if current.value.key == key then
            return current.value.value
        end
        current = current.next
    end

    return nil
end

function Hashtbl:map(func)
    local newTable = Hashtbl.new(self.size)
    for i = 1, self.size do
        local bucket = self.buckets[i]
        local current = bucket.head
        while current do
            local newValue = func(current.value.key, current.value.value)
            newTable:insert(current.value.key, newValue)
            current = current.next
        end
    end
    return newTable
end

function Hashtbl:iter(func)
    for i = 1, self.size do
        local bucket = self.buckets[i]
        local current = bucket.head
        while current do
            func(current.value.key, current.value.value)
            current = current.next
        end
    end
end

function Hashtbl:apply(func)
    for i = 1, self.size do
        local bucket = self.buckets[i]
        local current = bucket.head
        while current do
            current.value.value = func(current.value.key, current.value.value)
            current = current.next
        end
    end
end

function Hashtbl:reduce(func, initial)
    local accumulator = initial
    for i = 1, self.size do
        local bucket = self.buckets[i]
        local current = bucket.head
        while current do
            accumulator = func(accumulator, current.value.key, current.value.value)
            current = current.next
        end
    end
    return accumulator
end

function Hashtbl:filter(predicate)
    local newTable = Hashtbl.new(self.size)
    for i = 1, self.size do
        local bucket = self.buckets[i]
        local current = bucket.head
        while current do
            if predicate(current.value.key, current.value.value) then
                newTable:insert(current.value.key, current.value.value)
            end
            current = current.next
        end
    end
    return newTable
end


return Hashtbl
