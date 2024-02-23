require "source/matrix"

Map = {}

function Map.distance(c1, r1, c2, r2)
    return math.sqrt((c1-c2)*(c1-c2)+(r1-r2)*(r1-r2))
end

function Map.load()
    Map.tile = Matrix(MAP_SIZE, MAP_SIZE, false)
    local elevation = Matrix(MAP_SIZE, MAP_SIZE, 0)

    for c = 1, MAP_SIZE do
        for r = 1, MAP_SIZE do
            elevation[c][r] = elevation[c][r] + 0.3*math.max(0, 48-Map.distance(c, r, 64, 64))
        end
    end

    for i = 1, 5 do
        local cc = math.random(32, MAP_SIZE-32)
        local rc = math.random(32, MAP_SIZE-32)
        for c = 1, MAP_SIZE do
            for r = 1, MAP_SIZE do
                elevation[c][r] = elevation[c][r] + 0.3*math.max(0, 24-Map.distance(c, r, cc, rc))
            end
        end
    end

    for c = 1, MAP_SIZE do
        for r = 1, MAP_SIZE do
            if elevation[c][r] > 5 then
                Map.tile[c][r] = true
            end
        end
    end
end

function Map.draw()
    love.graphics.setColor(POLYNESIAN_BLUE, 1.0)
    love.graphics.rectangle("fill", 0, 0, T*MAP_SIZE, T*MAP_SIZE)
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    for r = 1, MAP_SIZE do
        for c = 1, MAP_SIZE do
             if Map.tile[c][r] then
                love.graphics.draw(Texture.tile, (c-1)*T, (r-1)*T, 0, T/16, T/16)
            end
        end
    end
end
