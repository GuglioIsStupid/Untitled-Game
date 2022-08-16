return {
    enter = function(self)
        for i = 1, 1 do
            graphics.newBlock("normal", 200, lg.getHeight() - 125, 50, 125) -- create a new block 1 time
            
        end
    end,
    update = function(self, dt)
        levelsUpdates[1]:update(dt) -- update the level
    end,
    draw = function(self)
        lg.setColor(0.85, 0.85, 0.85) -- set player colour
        player.draw()
        for i = 1, #blocks do
            blocks[i]:draw() -- draw all the blocks in the table
        end
        lg.setColor(0,0.4,0)
        lg.rectangle("fill",lg.getWidth()-50,lg.getHeight()-50,50,50)
        lg.setColor(1,1,1)
    end,
}