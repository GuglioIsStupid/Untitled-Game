local player = {
    x = 0,
    y = lg.getHeight() - 50,
    width = 50,
    height = 50,
    speed = 150,
    isJumping = false,
}

function player.checkCollision(b_x, b_y, b_width, b_height) -- check the collision of a current object with another object, returns a boolean
    --print((player.x + player.width > b_x) and (player.x < b_x + b_width) and (player.y + player.height > b_y) and (player.y < b_y + b_height))
    return (player.x + player.width > b_x) and (player.x < b_x + b_width) and (player.y + player.height > b_y) and (player.y < b_y + b_height)
end

function player.update(dt)
    if level.current() ~= 3 then if player.x < 0 then -- player x boundries
        player.x = 0
    elseif player.x > lg.getWidth()-player.width then
        player.x = lg.getWidth()-player.width
    end end
    if player.y > lg.getHeight() then -- only stop players from falling through the bottom with a broken jump
        player.y = lg.getHeight()-player.width
    end
    for i = 1, #blocks do
        block = blocks[i]
        if input:down("left") then
            if not player.checkCollision(block.x, block.y, block.width, block.height) then
                player.x = (player.x - (player.speed/#blocks) * dt)
            else
                player.x = (player.x + (player.speed/#blocks) * dt)
            end
        elseif input:down("right") then
            if not player.checkCollision(block.x, block.y, block.width, block.height) then
                --print(player.x)
                player.x = (player.x + (player.speed/#blocks) * dt)
            else
                player.x = (player.x - (player.speed/#blocks) * dt)
            end
        end
    end
    if input:pressed("jump") then
        if (level.current() ~= 2 and not player.isJumping) or (level.current() == 2) then
            player.isJumping = true
            if sounds.jumpsound[#sounds.jumpsound]:isPlaying() then
                sounds.jumpsound[#sounds.jumpsound] = sounds.jumpsound[#sounds.jumpsound]:clone()
                sounds.jumpsound[#sounds.jumpsound]:play()
            else
                sounds.jumpsound[#sounds.jumpsound]:play()
            end
            for i = 2, #sounds.jumpsound do
                if not sounds.jumpsound[i]:isPlaying() then
                    sounds.jumpsound[i] = nil -- Nil afterwords to prevent memory leak
                end --                             maybe, idk how love2d works lmfao
            end
            Timer.tween(
                0.7,
                player,
                {y = player.y - 100},
                "out-quad",
                function()
                    Timer.tween(
                        0.55,
                        player,
                        {y = player.y + 100},
                        "in-quad",
                        function()
                            if level.current() ~= 2 then sounds.landsound:play() 
                            elseif level.current() == 2 and player.y >= 549 then sounds.landsound:play() end 
                            player.isJumping = false
                        end
                    )
                end
            )
        end
    end
end

function player.draw()
    lg.push()
    lg.translate(player.x, player.y)
    lg.setColor(0.85, 0.85, 0.85)
    lg.rectangle("fill", 0, 0, player.width, player.height)
    lg.setColor(1,1,1)
    lg.pop()
end

return player
