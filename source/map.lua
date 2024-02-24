Map = {}

function Map.distance(x1, y1, x2, y2)
    return math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
end

function Map.isOnTile(x, y)
    if x < 0 or x > MAP_SIZE or y < 0 or y > MAP_SIZE then
        return false
    end
    return Map.tile[math.ceil(x)][math.ceil(y)]
end

function Map.isOnSea(x, y)
    return not Map.isOnTile(x, y)
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

function Map.drawTile(c, r)
    if Map.tile[c][r] then
        local offset = (c + r) % 2
        local frame = Animation.getPhase(1, 2, offset, offset/2)
        love.graphics.draw(Texture.sheet, Texture.grassTile[frame], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
        return
    end

    local offset = c % 5
    local frame = Animation.getPhase(0.5, 5, offset)
    love.graphics.draw(Texture.sheet, Texture.sea[frame], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
end

function Map.draw()
    for r = 1, MAP_SIZE do
        for c = 1, MAP_SIZE do
            Map.drawTile(c, r)
        end
    end
end
