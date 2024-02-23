require "source/constants"
require "source/map"
require "source/camera"
require "source/player"
require "source/texture" 

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest")
    Texture.load()
    Map.load()
    Camera.load()
    Player.load()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    Player.update(dt)
end

function love.draw()
    love.graphics.clear(0.0, 0.0, 0.0, 1.0)
    Camera.enable()
    Map.draw()
    Player.draw()
end
