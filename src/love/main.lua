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
    world = {}
    world.world = love.physics.newWorld(0, 9.2*64, true)
    world.ground = {}
    world.ground.body = love.physics.newBody(world.world, 650/2, 650-50/2)
    world.ground.shape = love.physics.newRectangleShape(1200, 50)
    world.ground.fixture = love.physics.newFixture(world.ground.body,
                                                    world.ground.shape)
    graphics = require("modules.graphics") -- Graphics module inspired by HTV04's graphics module
    player = require "data.player" -- Load the player data
    player.load()
    level = require "modules.level" -- Load the levels module
    level.load()
    windowClosed = false
    windowX, windowY = love.window.getPosition()
	SpinAmount = 0
    thisX, thisY = 0, 0

    -- load sounds
    sounds = {
        explosion = love.audio.newSource("sounds/explosion.wav", "static"),
        messup = love.audio.newSource("sounds/messup.wav", "static"),
        optionChange = love.audio.newSource("sounds/optionChange.wav", "static"),
        optionSelect = love.audio.newSource("sounds/optionSelect.wav", "static"),
        landsound = love.audio.newSource("sounds/land.wav", "static"),
        finishsound = love.audio.newSource("sounds/finish.wav", "static"),
        jumpsound = {love.audio.newSource("sounds/jump.wav", "static")}, -- table for overlapping sounds
    }

    menu = require "menu.mainMenu"; menu:enter()
    lg.setBackgroundColor(0.4, 0.4, 0.4) -- set the background colour to a nice grey
    music = love.audio.newSource("music/placeholderMusic.wav", "stream"); music:setLooping(true); music:play()

    ----[[
    function checkCollision(a_x, a_y, a_width, a_height, b_x, b_y, b_width, b_height) -- check the collision of a current object with another object, returns a boolean
        return (a_x + a_width > b_x) and (a_x < b_x + b_width) and (a_y + a_height > b_y) and (a_y < b_y + b_height)
    end
    --]]
    print(love.graphics.getWidth(), love.graphics.getHeight())
end
function love.update(dt)
    Timer.update(dt)
    world.world:update(dt) -- this puts the world into motion
    if not windowClosed then
        input:update(dt)
        player.update(dt)
        if level.current() ~= 0 then level:update(dt) else menu:update(dt) end-- menu = curLevel 0
    end
    if love.keyboard.isDown("v") then
        thisX, thisY = math.sin(SpinAmount * (SpinAmount / 2)) * 100, math.sin(SpinAmount * (SpinAmount)) * 100
        xVal, yVal = windowX + thisX, windowY + thisY
        love.window.setPosition(xVal, yVal)
        SpinAmount = SpinAmount + 1 * dt
    end
end
function love.keypressed(key)
    if key == "c" then
        if not windowClosed then
            windowClosed = true
            sounds.explosion:play()
            love.window.close()
            Timer.after(
                0.9,
                function()
                    love.window.setMode(800, 600)
                    love.window.setPosition(xVal, yVal)
                    windowClosed = false
                    sounds.jumpsound[1]:play()
                end
            )
        end
    elseif key == "=" then level.changeLevel()
    end
end

function love.draw() -- draw all current assets on screen
    if not windowClosed then
        lg.push()
        if level.current() ~= 0 then level.draw() else menu:draw() end
        ----[[
        lg.print(
            "FPS: " .. love.timer.getFPS() ..
            "\nPlayer X: " .. math.floor(player.getX()) ..
            "\nPlayer Y: " .. math.floor(player.getY()) ..
            "\nLevel Num: " .. level.current()
        )
        --]]
        lg.pop()
    end
end
