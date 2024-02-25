Map = {}

function Map.distance(x1, y1, x2, y2)
    return math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
end

function Map.isOnTile(x, y)
    if x < 0 or x > MAP_SIZE or y < 0 or y > MAP_SIZE then
        return false
    end

    local result = Map.tile[math.ceil(x)][math.ceil(y)]
    if x == math.ceil(x) then
        result = result or Map.tile[math.ceil(x)+1][math.ceil(y)]
    end
    if y == math.ceil(y) then
        result = result or Map.tile[math.ceil(x)][math.ceil(y)+1]
    end
    return result
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

    if r > 1 and Map.tile[c][r-1] then
        love.graphics.draw(Texture.sheet, Texture.coast, T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
        love.graphics.draw(Texture.sheet, Texture.grassOut[4], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if r < MAP_SIZE and Map.tile[c][r+1] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[8], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if c > 1 and Map.tile[c-1][r] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[2], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if c < MAP_SIZE and Map.tile[c+1][r] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[6], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if r > 1 and c > 1 and Map.tile[c-1][r-1] and not Map.tile[c-1][r] and not Map.tile[c][r-1] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[3], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if r > 1 and c < MAP_SIZE and Map.tile[c+1][r-1] and not Map.tile[c+1][r] and not Map.tile[c][r-1] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[5], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if r < MAP_SIZE and c > 1 and Map.tile[c-1][r+1] and not Map.tile[c-1][r] and not Map.tile[c][r+1] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[1], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end

    if r < MAP_SIZE and c < MAP_SIZE and Map.tile[c+1][r+1] and not Map.tile[c+1][r] and not Map.tile[c][r+1] then
        love.graphics.draw(Texture.sheet, Texture.grassOut[7], T*(c-1), T*(r-1), 0, TEXTURE_SCALE, TEXTURE_SCALE)
    end
end

function Map.draw()
    for r = 1, MAP_SIZE do
        for c = 1, MAP_SIZE do
            Map.drawTile(c, r)
        end
    end
end
