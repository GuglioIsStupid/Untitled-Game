function getLevels(dir) -- Get the amount of levels available
    curDirMain = dir .. "/main/"
    curDirUpdates = dir .. "/updates/"
    dirTableMain = love.filesystem.getDirectoryItems(curDirMain)
    dirTableUpdates = love.filesystem.getDirectoryItems(curDirUpdates)
end
function love.load()
    lg = love.graphics -- shorten love.graphics (makes it easier for me)
    Timer = require "libs.timer" -- Load required libraries
    input = (require "libs.baton").new({ -- Load the input for it to work properly
        controls = {
            jump = {"key:space", "button:a", "button:b"},
            left = {"key:left", "button:dpleft", "axis:leftx-"},
            right = {"key:right", "button:dpright", "axis:leftx+"},
            confirm = {"key:return", "button:start"},
        },
        joystick = love.joystick.getJoysticks()[1]
    })
    graphics = require("modules.graphics") -- Graphics module inspired by HTV04's graphics module
    jumping = false
    player = require "data.player" -- Load the player data

    function changeLevel() -- Change the current level
        finishsound:play()
        curLevel = curLevel + 1
        levels[curLevel]:enter()
    end

    -- load sounds
    jumpsound = {
        love.audio.newSource("sounds/jump.wav", "static")
    }
    landsound = love.audio.newSource("sounds/land.wav", "static")
    finishsound = love.audio.newSource("sounds/finish.wav", "static")
    
    getLevels("levels")
    levels = {}
    levelsUpdates = {}
    curLevel = 0
    for i = 1, #dirTableUpdates do -- require the available levels from function
        levels[i] = require ("levels.main." .. i)
        levelsUpdates[i] = require ("levels.updates." .. i)
    end
    menu = require "menu.main" -- Load the... well, the menu
    menu:enter()
    lg.setBackgroundColor(0.4, 0.4, 0.4) -- set the background colour to a nice grey
    music = love.audio.newSource("music/placeholderMusic.wav", "stream")
    music:setLooping(true)
    music:play()

    ----[[
    function checkCollision(a_x, a_y, a_width, a_height, b_x, b_y, b_width, b_height) -- check the collision of a current object with another object, returns a boolean
        return (a_x + a_width > b_x) and (a_x < b_x + b_width) and (a_y + a_height > b_y) and (a_y < b_y + b_height)
    end
    --]]
end
function love.update(dt)
    Timer.update(dt)
    input:update(dt)
    player.update(dt)
    if curLevel ~= 0 then levelsUpdates[curLevel]:update(dt) else menu:update(dt) end -- menu = curLevel 0
end
function love.draw() -- draw all current assets on screen
    lg.push()
    if curLevel ~= 0 then levels[curLevel]:draw() else menu:draw() end
    ----[[
    lg.print(
        "Player X: " .. math.floor(player.x) ..
        "\nPlayer Y: " .. math.floor(player.y) ..
        "\nLevel Num: " .. curLevel
    )
    --]]
    lg.pop()
end