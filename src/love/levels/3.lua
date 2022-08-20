return {
    enter = function(self)
        graphics.newBlock("normal", 150, lg.getHeight() - 900, 50, 900)
        graphics.newFinish(200, lg.getHeight()-50, 50, 50)
        player.x = 0
        player2 = {
            x = lg.getWidth(),
            y = lg.getHeight() - 50,
            width = 50,
            height = 50,
            speed = 150
        }
    end,
    update = function(self, dt)
        player2.x = lg.getWidth() + player.x
        player2.y = player.y
    end,
    draw = function(self, dt)
        lg.setColor(0.85, 0.85, 0.85)
        player.draw()
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
            for i = 1, #finish do
                finish[i]:draw()
            end
        end
    end
}
