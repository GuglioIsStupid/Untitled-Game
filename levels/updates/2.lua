return {
    update = function(self, dt)
        if input:pressed("jump") then
            if jumpsound[#jumpsound]:isPlaying() then
                jumpsound[#jumpsound] = jumpsound[#jumpsound]:clone()
                jumpsound[#jumpsound]:play()
            else
                jumpsound[#jumpsound]:play()
            end
            for i = 2, #jumpsound do
                if not jumpsound[i]:isPlaying() then
                    jumpsound[i] = nil -- Nil afterwords to prevent memory leak
                end --                             maybe, idk how love2d works lmfao
            end
            Timer.tween(
                0.7,
                player,
                {y = player.y - 100},
                "out-quad",
                function()
                    Timer.tween(
                        0.7,
                        player,
                        {y = player.y + 100},
                        "in-quad",
                        function()
                            if player.y == 550 then landsound:play() end
                        end
                    )
                end
            )
        end
        if input:down("right") then
            for i = 1, #blocks do
                if not checkCollision(player.x, player.y, player.width, player.height, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                    player.x = player.x + player.speed * dt
                else
                    Timer.tween(0.3, player, {x=player.x-10},"out-quad")
                end
            end
        elseif input:down("left") then
            for i = 1, #blocks do
                if not checkCollision(player.x, player.y, player.width, player.height, blocks[i].x, blocks[i].y, blocks[i].width, blocks[i].height) then
                    player.x = player.x - player.speed * dt
                else
                    Timer.tween(0.3, player, {x=player.x+10},"out-quad")
                end
            end
        end
        if checkCollision(player.x, player.y, player.width, player.height, lg.getWidth()-50,lg.getHeight()-50,50,50) then
            changeLevel()
        end 
    end
}