Player = {}

function Player.load()
    Player.position = {}
    Player.position.x = 64
    Player.position.y = 64
    Player.direction = true
    Player.walking = true
    Player.hand = "nothing"
end

function Player.tread()
    local x = math.ceil(Player.position.x+0.5)
    local y = math.ceil(Player.position.y+1)
    if Map.trodden[x][y] then
        return
    end
    Map.trodden[x][y] = true
    Timer.insert(function()
        Map.trodden[x][y] = false
    end, 5)
end

function Player.moveLeft(dt)
    Player.position.x = Player.position.x - PLAYER_SPEED*dt
    if Map.isOnSea(Player.position.x+0.125, Player.position.y+1) or Map.isOnSea(Player.position.x+0.875, Player.position.y+1) then
        Player.position.x = math.ceil(Player.position.x)-0.125
    end
    Player.direction = false
    Player.walking = true
    Player.tread()
end

function Player.moveRight(dt)
    Player.position.x = Player.position.x + PLAYER_SPEED*dt
    if Map.isOnSea(Player.position.x+0.125, Player.position.y+1) or Map.isOnSea(Player.position.x+0.875, Player.position.y+1) then
        Player.position.x = math.floor(Player.position.x)+0.125
    end
    Player.direction = true
    Player.walking = true
    Player.tread()
end

function Player.moveUp(dt)
    Player.position.y = Player.position.y - PLAYER_SPEED*dt
    if Map.isOnSea(Player.position.x+0.125, Player.position.y+1) or Map.isOnSea(Player.position.x+0.875, Player.position.y+1) then
        Player.position.y = math.ceil(Player.position.y)
    end
    Player.walking = true
    Player.tread()
end

function Player.moveDown(dt)
    Player.position.y = Player.position.y + PLAYER_SPEED*dt
    if Map.isOnSea(Player.position.x+0.125, Player.position.y+1) or Map.isOnSea(Player.position.x+0.875, Player.position.y+1) then
        Player.position.y = math.floor(Player.position.y)
    end
    Player.walking = true
    Player.tread()
end

function Player.collect()
    Player.hand, Map.object[math.ceil(Player.position.x+0.5)][math.ceil(Player.position.y+1)] = Map.object[math.ceil(Player.position.x+0.5)][math.ceil(Player.position.y+1)], Player.hand
end

function Player.update(dt)
    Player.walking = false
    if love.keyboard.isDown('a') then
        Player.moveLeft(dt)
    end
    if love.keyboard.isDown('d') then
        Player.moveRight(dt)
    end
    if love.keyboard.isDown('w') then
        Player.moveUp(dt)
    end
    if love.keyboard.isDown('s') then
        Player.moveDown(dt)
    end
    Camera.setPosition(Player.position.x, Player.position.y)
end

function Player.drawHand()
    if Player.hand == "nothing" then
        return
    end

    if Player.hand == "wood" then
        love.graphics.draw(Texture.sheet, Texture.wood, T*Player.position.x, T*Player.position.y, 0, T/16, T/16)
    end

    if Player.hand == "stone" then
        love.graphics.draw(Texture.sheet, Texture.stone, T*Player.position.x, T*Player.position.y, 0, T/16, T/16)
    end

    if Player.hand == "weed" then
        love.graphics.draw(Texture.sheet, Texture.weed, T*Player.position.x, T*Player.position.y, 0, T/16, T/16)
    end
end

function Player.draw()
    local frame = 1
    if Player.walking then
        frame = frame + Animation.getPhase(0.2, 2)
        if not Player.direction then
            frame = frame + 2
        end
    end
    love.graphics.draw(Texture.sheet, Texture.player[frame], T*Player.position.x, T*Player.position.y, 0, T/16, T/16)
    Player.drawHand()
end
