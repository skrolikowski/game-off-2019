-- Gamestates
--

-- Register button events
--
-- function registerButtonEvents(gamestate)
-- 	for __, button in pairs(gamestate.buttons) do
-- 		for r = button.cell.row, button.cell.row + button.rows do
-- 			for c = button.cell.col, button.cell.row + button.cols do
-- 				_Grid:getCell(r, c).onClick = button.onClick
-- 				_Grid:getCell(r, c).onHover = button.onHover
-- 			end
-- 		end
-- 	end
-- end


-- Gamestates
Menu    = require 'src.gamestates.menu'
Game    = require 'src.gamestates.game'
Pause   = require 'src.gamestates.pause'
Credits = require 'src.gamestates.credits'