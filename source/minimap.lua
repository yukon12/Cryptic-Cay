Minimap = {}

function Minimap.load()
    
end

function Minimap.draw()
    love.graphics.setColor(1.0, 1.0, 1.0, 0.75)
    for c = 1, MAP_SIZE do
        for r = 1, MAP_SIZE do
            if Map.tile[c][r] then
                love.graphics.points(c-1, r-1)
            end
        end
    end
    love.graphics.setColor(1.0, 0.0, 0.0, 1.0)
    love.graphics.setPointSize(5)
    love.graphics.points(Player.position.x, Player.position.y)
    love.graphics.setPointSize(1)
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end
