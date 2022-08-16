return { 
    update = function(self, dt)
        if checkCollision(player.x, player.y, player.width, player.height, lg.getWidth()-50,lg.getHeight()-50,50,50) then -- finish block collision
            changeLevel()
        end 
    end
}