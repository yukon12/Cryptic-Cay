Camera = {}

function Camera.load()
    Camera.horizontal = 0
    Camera.vertical = 0
end

function Camera.setPosition(x, y)
    Camera.horizontal = -T*x+WINDOW_WIDTH/2
    Camera.vertical = -T*y+WINDOW_HEIGHT/2
    Camera.horizontal = math.min(0, Camera.horizontal)
    Camera.vertical = math.min(0, Camera.vertical)
    Camera.horizontal = math.max(-T*MAP_SIZE+WINDOW_WIDTH, Camera.horizontal)
    Camera.vertical = math.max(-T*MAP_SIZE+WINDOW_HEIGHT, Camera.vertical)
end

function Camera.enable()
    love.graphics.translate(Camera.horizontal, Camera.vertical)
end

function Camera.disable()
    love.graphics.translate(-Camera.horizontal, -Camera.vertical)
end
