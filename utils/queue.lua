-- Queue Helper
-- Shane Krolikowski
--

local Modern = require 'modern'
local Queue  = Modern:extend()

function Queue:new(...)
    self.elements = {...}
end

function Queue:put(element)
    self.elements[#self.elements + 1] = element
end

function Queue:peek()
    return self.elements[1]
end

function Queue:peekLast()
    return self.elements[#self.elements]
end

function Queue:get()
    if self:isEmpty() then
        return false
    end

    return table.remove(self.elements, 1)
end

function Queue:size()
    return #self.elements
end

function Queue:isEmpty()
    return #self.elements == 0
end

return Queue