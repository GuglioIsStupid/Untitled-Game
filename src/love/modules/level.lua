local level = {}

function level.changeLevel() -- Change the current level
    sounds.finishsound:play()
    curLevel = curLevel + 1
    levels[curLevel]:enter()
end

function level.getLevels(dir) -- Get the amount of levels available
    curDirMain = dir .. "/main/"
    curDirUpdates = dir .. "/updates/"
    dirTableMain = love.filesystem.getDirectoryItems(curDirMain)
    dirTableUpdates = love.filesystem.getDirectoryItems(curDirUpdates)
end

function level.load()
    level.getLevels("levels")
    levels = {}
    levelsUpdates = {}
    curLevel = 0
    for i = 1, #dirTableUpdates do -- require the available levels from function
        levels[i] = require ("levels.main." .. i)
        levelsUpdates[i] = require ("levels.updates." .. i)
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
