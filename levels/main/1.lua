return {
    enter = function(self)
        for i = 1, 1 do
            graphics.newBlock("normal", 200, lg.getHeight() - 125, 50, 125)
            
        end
    end,
    update = function(self, dt)
        levelsUpdates[1]:update(dt)
    end,
    draw = function(self)
        lg.setColor(0.85, 0.85, 0.85)
        lg.rectangle("fill", player.x, player.y, player.width, player.height)
        for i = 1, #blocks do
            blocks[i]:draw()
        end
        lg.setColor(0,0.4,0)
        lg.rectangle("fill",lg.getWidth()-50,lg.getHeight()-50,50,50)
        lg.setColor(1,1,1)
    end,
}