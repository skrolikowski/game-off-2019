-- Vec2
-- Shane Krolikowski
--

local Modern = require 'modern'
local Vec2   = Modern:extend()

-- Create new Vector 2D
--
function Vec2:new(x, y)
    self.x = x or 0
    self.y = y or 0
end

-- Unpack
--
function Vec2:unpack()
    return self.x, self.y
end

-- Copy
--
function Vec2:copy()
    return Vec2(self.x, self.y)
end

-- Distance to another Vec2
--
function Vec2:distance(other)
    return _.__sqrt((self.x - other.x) ^ 2 + (self.y - other.y) ^ 2)
end

-- Scale by factor
--
function Vec2:scale(factor)
    self.x = self.x * factor
    self.y = self.y * factor

    return self
end

-- Length of vector
--
function Vec2:magnitude()
    return _.__sqrt(self.x ^ 2 + self.y ^ 2)
end

-- Length squared
--
function Vec2:magnitudeSq()
    return self.x ^ 2 + self.y ^ 2
end

-- Normalize
--
function Vec2:normalize()
    local mag = self:magnitude()

    if mag > 0 then
        return self:scale(1 / mag)
    end

    return self
end

-- Clamp length
--
function Vec2:clamp(min, max)
    local mag = self:magnitude()

    self:setMagnitude(
        _.__max(min, _.__min(mag, max))
    )

    return self
end

-- Limit length
--
function Vec2:limit(max)
    if self:magnitude() > max then
        return self:normalize():scale(max)
    end

    return self
end

-- Current heading
--
function Vec2:heading()
    return math_atan2(self.y, self.x)
end

-- Set length
--
function Vec2:setMagnitude(mag)
    local rotation = self:heading()

    self.x = math_cos(rotation) * mag
    self.y = math_sin(rotation) * mag
end

-- Rotate
--
function Vec2:rotate(rotation)
    local cos  = math_cos(rotation)
    local sin  = math_sin(rotation)
    local x, y = self:unpack()

    self.x = cos * x - sin * y
    self.y = sin * x + cos * y

    return self
end

-- Addition operator
--
function Vec2:__add(other)
    return Vec2(
        self.x + other.x,
        self.y + other.y
    )
end

-- Subtraction operator
--
function Vec2:__sub(other)
    return Vec2(
        self.x - other.x,
        self.y - other.y
    )
end

-- Multiplication operator
--
function Vec2:__mul(v)
    if type(v) == 'number' then
        return self:copy():scale(v)
    end

    return Vec2(
        self.x * other.x,
        self.y * other.y
    )
end

-- Equals operator
--
function Vec2:__eq(v)
    return self:equal(v)
end

-- Unary minus operator
--
function Vec2:__unm(v)
    return self:copy():scale(-1)
end

-- __tostring operator
--
function Vec2:__tostring()
    return 'Vec2(' .. self.x .. ', ' .. self.y .. ')'
end

return Vec2