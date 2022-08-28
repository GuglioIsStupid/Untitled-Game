local level = {}

function level.changeLevel() -- Change the current level
    sounds.finishsound:play()
    if player2 then player2 = nil end
    curLevel = curLevel + 1
    finish.destroy()
    blocks.destroy()
    levels[curLevel]:enter()
end


function level.load()
    levels = {}
    curLevel = 0
    for i = 1, #love.filesystem.getDirectoryItems("levels") do -- require the available levels from function
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
