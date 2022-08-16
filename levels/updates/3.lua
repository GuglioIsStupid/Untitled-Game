return {
    update = function(self, dt)
        player2.x = lg.getWidth() + player.x
        if input:pressed("jump") then
            if not jumping then
                if jumpsound[#jumpsound]:isPlaying() then
                    jumpsound[#jumpsound] = sounds.jumpsound[#jumpsound]:clone()
                    jumpsound[#jumpsound]:play()
                else
                    jumpsound[#jumpsound]:play()
                end
                for i = 2, #jumpsound do
                    if not jumpsound[i]:isPlaying() then
                        jumpsound[i] = nil -- Nil afterwords to prevent memory leak
                    end --                             maybe, idk how love2d works lmfao
                end
                jumping = true
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
                                landsound:play()
                                jumping = false
                            end
                        )
                    end
                )
                Timer.tween(
                    0.7,
                    player2,
                    {y = player2.y - 100},
                    "out-quad",
                    function()
                        Timer.tween(
                            0.7,
                            player2,
                            {y = player2.y + 100},
                            "in-quad"
                        )
                    end
                )
            end
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
    end
}