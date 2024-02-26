Minimap = {}

function Minimap.load()
    Minimap.canvas = love.graphics.newCanvas(128, 128)
    Minimap.canvas:renderTo(function()
        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
        for c = 1, MAP_SIZE do
            for r = 1, MAP_SIZE do
                if Map.tile[c][r] then
                    love.graphics.points(c-1, r-1)
                end
            end
        end
    end)
end

function Minimap.draw()
    love.graphics.setColor(1.0, 1.0, 1.0, 0.5)
    love.graphics.draw(Minimap.canvas, 0, 0, 0, 1, 1)
    love.graphics.setColor(1.0, 0.0, 0.0, 1.0)
    love.graphics.setPointSize(5)
    love.graphics.points(Player.position.x, Player.position.y)
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    love.graphics.setPointSize(1)
end
