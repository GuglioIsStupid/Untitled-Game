local level = {}

function level.changeLevel() -- Change the current level
    sounds.finishsound:play()
    curLevel = curLevel + 1
    finish.destroy()
    blocks.destroy()
    levels[curLevel]:enter()
end

function level.getLevels(dir) -- Get the amount of levels available
    dirTableMain = love.filesystem.getDirectoryItems("levels")
end

function level.load()
    level.getLevels("levels")
    levels = {}
    curLevel = 0
    for i = 1, #dirTableMain do -- require the available levels from function
        levels[i] = require ("levels." .. i)
    end
end

function level.current()
    return curLevel
end

function level.update(dt)
    levels[curLevel]:update(dt)
end

function level.draw()
    levels[curLevel]:draw()
end

return level
