-- Map Grid
-- Shane Krolikowski
--

local Modern = require 'modern'
local Grid   = Modern:extend()

-- Create new grid
--
function Grid:new(rows, cols)
    self.cells = {}
    self.rows  = rows
    self.cols  = cols

    for r = 1, self.rows do
        for c = 1, self.cols do
            table.insert(self.cells, Cell(r, c))
        end
    end
end

-- Reset grid
--
function Grid:reset()
    for __, cell in pairs(self.cells) do
        cell:reset()
    end
end

-- Mark grid traits
--
function Grid:markTileTrait(trait, layer)
    for __, obj in pairs(layer.objects) do
        local objBounds = AABB(obj.x, obj.y, obj.x + obj.width, obj.y + obj.height)
        local cellsWithinBounds = self:getCellsInBounds(objBounds)

        for __, cell in pairs(cellsWithinBounds) do
            cell[trait] = true
        end
    end
end

-- Check if cell is in bounds
--
function Grid:inBounds(row, col)
    return row > 0 and
           row <= self.rows and
           col > 0 and
           col <= self.cols
end

-- Get cell index
--
function Grid:getIndex(row, col)
    if self:inBounds(row, col) then
        return ((col - 1) + (row - 1) * self.cols) + 1
    end

    return false
end

-- Get cell by row/column-values
--
function Grid:getCell(row, col)
    local index = self:getIndex(row, col)

    if index then
        return self.cells[index]
    end

    return false
end

-- Get cell by x/y-coordinates
--
function Grid:getCellByLocation(x, y)
    local row = _.__ceil((y - Config.map.yOffset) / Config.map.cell.size)
    local col = _.__ceil((x - Config.map.xOffset) / Config.map.cell.size)

    return self:getCell(row, col)
end

-- Get cells withing requested bounds
--
function Grid:getCellsInBounds(bounds)
    local cells = {}

    for __, cell in pairs(self.cells) do
        if cell:within(bounds) then
            table.insert(cells, cell)
        end
    end

    return cells
end

-- Update the grid.
--
function Grid:update(dt)
    for __, cell in pairs(self.cells) do
        cell:update(dt)
    end
end

-- ===================================
-- Draw the grid.
-- -------------
-- @return void
-- ===================================
function Grid:draw()
    love.graphics.push()
    love.graphics.translate(Config.map.xOffset, Config.map.yOffset)

    for __, cell in pairs(self.cells) do
        cell:draw()
    end

    love.graphics.pop()
end

return Grid