return {
    enter = function(self)
        finish.destroy()
        blocks.destroy()
        player.x = 0
        player2 = {
            x = lg.getWidth(),
            y = lg.getHeight() - 50,
            width = 50,
            height = 50,
            speed = 150
        }
        graphics.newBlock("normal", 150, lg.getHeight() - 900, 50, 900)
        graphics.newFinish(200, lg.getHeight()-50, 50, 50)
    end,
    update = function(self, dt)
        levelsUpdates[3]:update(dt)
    end,
    draw = function(self, dt)
        lg.setColor(0.85, 0.85, 0.85)
        lg.rectangle("fill", player.x, player.y, player.width, player.height)
        lg.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
        for i = 1, #blocks do
            blocks[i]:draw()
        end
        lg.setColor(1,1,1)
        if player.x >= 190 then
            lg.print(
                "Nope, thats not it, try a different\nway...",
                300,
                100,
                0,
                2.33,
                2.33
            )
        else
            lg.setColor(0,0.4,0)
            lg.rectangle(
                "fill",
                200,
                lg.getHeight()-50, 50, 50
            )
            lg.setColor(1,1,1)
        end
    end
}
