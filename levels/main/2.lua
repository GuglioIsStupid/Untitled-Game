return {
    enter = function(self)
        finish.destroy()
        blocks.destroy()
        graphics.newBlock("normal", 200, lg.getHeight() - 300, 50, 300)
        graphics.newBlock("transparent", 248, lg.getHeight() - 900, 2, 900)
        player.x = 0
    end,
    update = function(self, dt)
        levelsUpdates[2]:update(dt)
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