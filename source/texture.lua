Texture = {}

function Texture.load()
    Texture.sheet = love.graphics.newImage("resources/sheet.png")
    Texture.player = {
        love.graphics.newQuad(0, 0, 16, 16, Texture.sheet),
        love.graphics.newQuad(16, 0, 16, 16, Texture.sheet),
        love.graphics.newQuad(32, 0, 16, 16, Texture.sheet),
        love.graphics.newQuad(48, 0, 16, 16, Texture.sheet),
        love.graphics.newQuad(64, 0, 16, 16, Texture.sheet),
    }
    Texture.grassTile = {
        love.graphics.newQuad(0, 16, 16, 16, Texture.sheet),
        love.graphics.newQuad(16, 16, 16, 16, Texture.sheet)
    }
    Texture.emptyTile = love.graphics.newQuad(32, 16, 16, 16, Texture.sheet)
    Texture.sea = {
        love.graphics.newQuad(0, 64, 16, 16, Texture.sheet),
        love.graphics.newQuad(16, 64, 16, 16, Texture.sheet),
        love.graphics.newQuad(32, 64, 16, 16, Texture.sheet),
        love.graphics.newQuad(48, 64, 16, 16, Texture.sheet),
        love.graphics.newQuad(64, 64, 16, 16, Texture.sheet),
    }
    Texture.coast = love.graphics.newQuad(0, 48, 16, 16, Texture.sheet)
    Texture.grassOut = {
        love.graphics.newQuad(48, 16, 16, 16, Texture.sheet),
        love.graphics.newQuad(0, 32, 16, 16, Texture.sheet),
        love.graphics.newQuad(16, 48, 16, 16, Texture.sheet),
        love.graphics.newQuad(16, 32, 16, 16, Texture.sheet),
        love.graphics.newQuad(32, 48, 16, 16, Texture.sheet),
        love.graphics.newQuad(32, 32, 16, 16, Texture.sheet),
        love.graphics.newQuad(48, 48, 16, 16, Texture.sheet),
        love.graphics.newQuad(48, 32, 16, 16, Texture.sheet),
    }
end
