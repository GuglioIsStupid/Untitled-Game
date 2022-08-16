function getLevels(dir)
    curDirMain = dir .. "/main/"
    curDirUpdates = dir .. "/updates/"
    dirTableMain = love.filesystem.getDirectoryItems(curDirMain)
    dirTableUpdates = love.filesystem.getDirectoryItems(curDirUpdates)
end
function love.load()
    lg = love.graphics
    Timer = require "libs.timer"
    input = (require "libs.baton").new({
        controls = {
            jump = {"key:space"},
            left = {"key:left"},
            right = {"key:right"},
            confirm = {"key:return"}
        },
        joystick = love.joystick.getJoysticks()[1]
    })
    graphics = require("modules.graphics")
    jumping = false
    player = {
        x = 0,
        y = lg.getHeight() - 50,
        width = 50,
        height = 50,
        speed = 150
    }

    function changeLevel()
        finishsound:play()
        curLevel = curLevel + 1
        levels[curLevel]:enter()
    end

    jumpsound = {
        love.audio.newSource("sounds/jump.wav", "static")
    }
    landsound = love.audio.newSource("sounds/land.wav", "static")
    finishsound = love.audio.newSource("sounds/finish.wav", "static")
    
    getLevels("levels")
    levels = {}
    levelsUpdates = {}
    curLevel = 0
    for i = 1, #dirTableUpdates do
        levels[i] = require ("levels.main." .. i)
        levelsUpdates[i] = require ("levels.updates." .. i)
    end
    menu = require "menu.main"
    menu:enter()
    lg.setBackgroundColor(0.4, 0.4, 0.4)
    music = love.audio.newSource("music/placeholderMusic.wav", "stream")
    music:setLooping(true)
    music:play()

    ----[[
    function checkCollision(a_x, a_y, a_width, a_height, b_x, b_y, b_width, b_height)
        return (a_x + a_width > b_x) and (a_x < b_x + b_width) and (a_y + a_height > b_y) and (a_y < b_y + b_height)
    end
    --]]
end
function love.update(dt)
    Timer.update(dt)
    input:update(dt)
    if curLevel ~= 0 then levelsUpdates[curLevel]:update(dt) else menu:update(dt) end
    if curLevel ~= 3 then
        if player.x < 0 then
            player.x = 0
        elseif player.x > lg.getWidth()-player.width then
            player.x = lg.getWidth()-player.width
        end
    end
    if player.y > lg.getHeight() then
        player.y = lg.getHeight()-player.width
    end
end
function love.draw()
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