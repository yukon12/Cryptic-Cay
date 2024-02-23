require "source/constants"

Player = {}

function Player.load()
    Player.position = {}
    Player.position.x = 64
    Player.position.y = 64
end

function Player.update(dt)
    if love.keyboard.isDown('a') then
        Player.position.x = Player.position.x - PLAYER_SPEED*dt
    end
    if love.keyboard.isDown('d') then
        Player.position.x = Player.position.x + PLAYER_SPEED*dt
    end
    if love.keyboard.isDown('w') then
        Player.position.y = Player.position.y - PLAYER_SPEED*dt
    end
    if love.keyboard.isDown('s') then
        Player.position.y = Player.position.y + PLAYER_SPEED*dt
    end
    Camera.setPosition(Player.position.x, Player.position.y)
end

function Player.draw()
    love.graphics.setColor(CRIMSON, 1.0)
    love.graphics.rectangle("line", T*Player.position.x, T*Player.position.y, T, T)
end
