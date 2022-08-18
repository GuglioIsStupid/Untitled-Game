
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
    player = require "data.player" -- Load the player data
    level = require "modules.level" -- Load the levels module
    level.load()

    -- load sounds
    sounds = {
        explosion = love.audio.newSource("sounds/explosion.wav", "static"),
        messup = love.audio.newSource("sounds/messup.wav", "static"),
        optionChange = love.audio.newSource("sounds/optionChange.wav", "static"),
        optionSelect = love.audio.newSource("sounds/optionSelect.wav", "static"),
        landsound = love.audio.newSource("sounds/land.wav", "static"),
        finishsound = love.audio.newSource("sounds/finish.wav", "static"),
        jumpsound = { -- table for overlapping sounds
            love.audio.newSource("sounds/jump.wav", "static")
        },
    }

    menu = require "menu.mainMenu"
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
    if level.current() ~= 0 then level:update(dt) else menu:update(dt) end-- menu = curLevel 0
end

function love.draw() -- draw all current assets on screen
    lg.push()
    if level.current() ~= 0 then level.draw() else menu:draw() end
    ----[[
    lg.print(
        "Player X: " .. math.floor(player.x) ..
        "\nPlayer Y: " .. math.floor(player.y) ..
        "\nLevel Num: " .. level.current()
    )
    --]]
    lg.pop()
end
