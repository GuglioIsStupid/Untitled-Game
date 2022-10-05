local player = {}
local onGround
-- make a player with love.physics
function player.load()
    player.body = love.physics.newBody(world.world, 0, 0, "dynamic")
    player.shape = love.physics.newRectangleShape(50, 50)
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.fixture:setRestitution(0)
    player.fixture:setFriction(0.4)
end

-- update the player
function player.update(dt)
    -- dont let the player go off the screen
    if player.body:getX() < 0 then player.body:setX(0) end
    if player.body:getX() > lg.getWidth() - 50 then player.body:setX(lg.getWidth() - 50) end
    if player.body:getY() < 0 then player.body:setY(0) end
    if love.keyboard.isDown("right") then
        player.body:applyForce(800, 0)
    elseif love.keyboard.isDown("left") then
        player.body:applyForce(-800, 0)
    end

    -- jump
    if input:pressed("jump") then
        player.body:applyLinearImpulse(0, -800)
    end

    for i = 1, #finish do
        if checkCollision(player.body:getX(), player.body:getY(), 50, 50, finish[i].x, finish[i].y, 50, 50) then
            level.changeLevel()
        end
    end
end

function player.getX()
    return player.body:getX()
end
function player.getY()
    return player.body:getY()
end

-- draw the player
function player.draw()
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
end

return player