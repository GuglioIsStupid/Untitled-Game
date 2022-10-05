return {
    enter = function(self)
        graphics.newBlock("normal", 200, lg.getHeight() - 125, 50, 125) -- create a new block 1 time
        graphics.newFinish(lg.getWidth()-50, lg.getHeight()-50, 50, 50)
        for i = 1, #blocks do blocks[i]:init() end
    end,
    update = function(self, dt) end,
    draw = function(self)
        love.graphics.polygon("fill", world.ground.body:getWorldPoints(
                                    world.ground.shape:getPoints()))
        player.draw()
        for i = 1, #blocks do blocks[i]:draw() end
        for i = 1, #finish do finish[i]:draw() end
    end
}
