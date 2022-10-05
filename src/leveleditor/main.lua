function love.load()
    player = {
        x = 0,
        y = love.graphics.getHeight()-50,
        width = 50,
        height = 50
    }
    blocks = {}
    finish = {}
    love.graphics.setBackgroundColor(0.4, 0.4, 0.4) -- set the background colour to a nice grey
    function checkCollision(a_x, a_y, a_width, a_height, b_x, b_y, b_width, b_height) -- check the collision of a current object with another object, returns a boolean
        return (a_x + a_width > b_x) and (a_x < b_x + b_width) and (a_y + a_height > b_y) and (a_y < b_y + b_height)
    end

    function makeBlock(x, y, width, height)
        table.insert(blocks, {x = x, y = y, width = width, height = height})
    end
    function removeBlock(x, y)
        for i = 1, #blocks do
            if checkCollision(x, y, 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                table.remove(blocks[i], #blocks)
            end
        end
    end
    love.keyboard.setKeyRepeat(true)
end 

function love.update(dt)
    if love.mouse.isDown(1) then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].x, blocks[i].y = love.mouse.getX()-(blocks[i].width/2), love.mouse.getY()-(blocks[i].height/2)
            end
        end
        if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, player.x, player.y, player.width, player.height) then
            player.x, player.y = love.mouse.getX()-(player.width/2), love.mouse.getY()-(player.height/2)
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 2 then
        removeBlock(x, y)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "b" then
        makeBlock(love.mouse.getX()-25, love.mouse.getY()-25, 50, 50)
    end

    if key == "w" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].y = blocks[i].y - 1
            end
        end
    elseif key == "s" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].y = blocks[i].y + 1
            end
        end
    elseif key == "a" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].x = blocks[i].x - 1
            end
        end
    elseif key == "d" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].x = blocks[i].x + 1
            end
        end
    end

    if key == "up" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].height = blocks[i].height - 1
            end
        end
    elseif key == "down" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].height = blocks[i].height + 1
            end
        end
    elseif key == "left" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].width = blocks[i].width - 1
            end
        end
    elseif key == "right" then
        for i = 1, #blocks do
            if checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                blocks[i].width = blocks[i].width + 1
            end
        end
    end
end

function love.draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    love.graphics.setColor(0,0,0)
    love.graphics.print(
        "x: "..player.x.."\ny: "..player.y.."\nwidth: "..player.width.."\nheight: "..player.height,
        player.x, player.y-5
    )
    love.graphics.setColor(0.65,0.65,0.65,1)
    for i = 1, #blocks do
        love.graphics.rectangle("fill", blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height)
    end
    for i = 1, #blocks do
        love.graphics.setColor(0,0,0)
        love.graphics.print(
            "x: "..blocks[i].x.."\ny: "..blocks[i].y.."\nwidth: "..blocks[i].width.."\nheight: "..blocks[i].height,
            blocks[i].x, blocks[i].y-5
        )
    end
    love.graphics.setColor(1,1,1)
end