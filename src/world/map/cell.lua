-- Map Cell
-- Shane Krolikowski
--

local Modern = require 'modern'
local Cell   = Modern:extend()

-- Create new cell
--
function Cell:new(row, col)
    self.row = row
    self.col = col
    self.active = true
end

-- Get cell index
--
function Cell:index()
    return ((self.col - 1) + (self.row - 1) * Config.map.cols) + 1
end

-- Get cell dimensions
--
function Cell:dimensions()
    return Config.map.cell.size,
           Config.map.cell.size
end

-- Get cell top/right coordinates
--
function Cell:position()
    local x = (self.col - 1) * Config.map.cell.size + Config.map.xOffset
    local y = (self.row - 1) * Config.map.cell.size + Config.map.yOffset

    return x, y
end

-- Get cell center coordinates
--
function Cell:center()
    local x, y = self:position()
    local w, h = self:dimensions()

    x = x + w / 2
    y = y + h / 2

    return x, y
end

-- Get cell's position and dimension
--
function Cell:container()
    local x, y = self:position()
    local w, h = self:dimensions()

    return x, y, w, h
end

function Cell:getNeighbors()
    local neighbors = {
        self:relative(-1,  0),  -- up
        self:relative( 1,  0),  -- down
        self:relative( 0, -1),  -- left
        self:relative( 0,  1),  -- right
    }

    return _:filter(neighbors, function(v, k)
        return _:isTruthy(v) and v.active
    end)
end

-- Get cell in relation to this cell
--
function Cell:relative(dr, dc)
    return Game.grid:getCell(
        self.row + (dr or 0),
        self.col + (dc or 0)
    )
end

-- Equals operator
--
function Cell:__eq(other)
    return self.row == other.row and
           self.col == other.col
end

-- Update the cell
--
function Cell:update(dt)
    --
end

-- Draw the cell.
--
function Cell:draw()
    local x, y = self:position()

    love.graphics.setColor(Config.color.black)
    love.graphics.printf(self.distance or 0, x, y + Config.map.cell.size / 3, Config.map.cell.size, 'center')
end

return Cell