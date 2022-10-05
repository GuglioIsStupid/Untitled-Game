return {
    enter = function(self)
        graphics.newBlock("normal", 200, lg.getHeight() - 300, 50, 300)
        graphics.newBlock("transparent", 248, lg.getHeight() - 900, 2, 900)
        graphics.newFinish(lg.getWidth()-50, lg.getHeight()-50, 50, 50)
        player.x = 0
        for i = 1, #blocks do blocks[i]:init() end
    end,
    update = function(self, dt) end,
    draw = function(self)
        love.graphics.polygon("fill", world.ground.body:getWorldPoints(
                                    world.ground.shape:getPoints()))
        player.draw()
        for i = 1, #blocks do blocks[i]:draw() end
        for i = 1, #finish do finish[i]:draw() end
    end,
}
