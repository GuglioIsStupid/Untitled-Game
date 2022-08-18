return {
    enter = function(self)
        graphics.newBlock("normal", 200, lg.getHeight() - 125, 50, 125) -- create a new block 
        graphics.newFinish(lg.getWidth()-50, lg.getHeight()-50, 50, 50)
    end,
    update = function(self, dt)
    end,
    draw = function(self)
        player.draw()
        for i = 1, #blocks do
            blocks[i]:draw() -- draw all the blocks in the table
        end
        for i = 1, #finish do 
            finish[i]:draw()
        end
    end,
}
