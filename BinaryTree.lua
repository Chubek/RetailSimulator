local LinkedList = require("LinkedList")

local Node = {}
Node.__index = Node

function Node.new(value)
    return setmetatable(
        {
            value = value,
            left = nil,
            right = nil
        },
        Node
    )
end

local BinaryTree = {}
BinaryTree.__index = BinaryTree

function BinaryTree.new()
    return setmetatable(
        {
            root = nil
        },
        BinaryTree
    )
end

function BinaryTree:insert(value)
    local newNode = Node.new(value)
    if not self.root then
        self.root = newNode
    else
        local current = self.root
        while true do
            if value < current.value then
                if not current.left then
                    current.left = newNode
                    break
                else
                    current = current.left
                end
            else
                if not current.right then
                    current.right = newNode
                    break
                else
                    current = current.right
                end
            end
        end
    end
end

function BinaryTree:search(value)
    local current = self.root
    while current do
        if value == current.value then
            return true
        elseif value < current.value then
            current = current.left
        else
            current = current.right
        end
    end
    return false
end

function BinaryTree:remove(value)
    local function minValueNode(node)
        local current = node
        while current.left do
            current = current.left
        end
        return current
    end

    local function removeNode(node, value)
        if not node then
            return node
        end

        if value < node.value then
            node.left = removeNode(node.left, value)
        elseif value > node.value then
            node.right = removeNode(node.right, value)
        else
            if not node.left then
                return node.right
            elseif not node.right then
                return node.left
            end
            local temp = minValueNode(node.right)
            node.value = temp.value
            node.right = removeNode(node.right, temp.value)
        end
        return node
    end

    self.root = removeNode(self.root, value)
end

function BinaryTree:_inOrder(node, list)
    if not node then
        return
    end
    self:_inOrder(node.left, list)
    list:append(node.value)
    self:_inOrder(node.right, list)
end

function BinaryTree:inOrder()
    local list = LinkedList.new()
    self:_inOrder(self.root, list)
    return list
end

function BinaryTree:iter(func)
    local list = self:inOrder()
    local current = list.head
    while current do
        func(current.value)
        current = current.next
    end
end

function BinaryTree:map(func)
    local newTree = BinaryTree.new()
    self:iter(
        function(value)
            newTree:insert(func(value))
        end
    )
    return newTree
end

function BinaryTree:apply(func)
    local list = self:inOrder()
    local current = list.head
    while current do
        self:remove(current.value)
        self:insert(func(current.value))
        current = current.next
    end
end

function BinaryTree:reduce(func, initial)
    local accumulator = initial
    self:iter(
        function(value)
            accumulator = func(accumulator, value)
        end
    )
    return accumulator
end

function BinaryTree:filter(predicate)
    local newTree = BinaryTree.new()
    self:iter(
        function(value)
            if predicate(value) then
                newTree:insert(value)
            end
        end
    )
    return newTree
end

return BinaryTree
