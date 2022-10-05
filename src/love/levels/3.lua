return {
    enter = function(self)
        graphics.newBlock("normal", 150, lg.getHeight() - 900, 50, 900)
        graphics.newFinish(200, lg.getHeight()-50, 50, 50)
        for i = 1, #blocks do blocks[i]:init() end
    end,
    update = function(self, dt)
    end,
    draw = function(self, dt)
        love.graphics.polygon("fill", world.ground.body:getWorldPoints(
                                    world.ground.shape:getPoints()))
        lg.setColor(0.85, 0.85, 0.85)
        player.draw()
        for i = 1, #finish do finish[i]:draw() end
    end
}
