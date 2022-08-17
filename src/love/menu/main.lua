local menuText
local tweenTitle, tweenVersion
return { 
    enter = function(self)
        __TITLE__ = "Untitled Game" -- Title name
        if love.filesystem.getInfo("version.txt") then -- load game version, else unknown version
            __VERSION__ = love.filesystem.read("version.txt")
        else
            __VERSION__ = "???"
        end
        menuText = { -- set all the menu text
            title = {
                text = __TITLE__,
                x = lg.getWidth() / 2-50,
                y = 110
            },
            version = {
                text = __VERSION__,
                x = lg.getWidth()/2+50,
                y = 150
            }
        }
        function tweenTitle() 
            Timer.tween(
                1.5, menuText.title, {y = 170}, "linear",
                function()
                    Timer.tween(
                        1.5, menuText.title, {y = 110}, "linear",
                        function()
                            tweenTitle()
                        end
                    )
                end
            )
        end
        function tweenVersion()
            Timer.tween(
                1.5, menuText.version, {y = 210}, "linear",
                function()
                    Timer.tween(
                        1.5, menuText.version, {y = 150}, "linear",
                        function()
                            tweenVersion()
                        end
                    )
                end
            )
        end
        tweenTitle()
        tweenVersion()
    end,

    update = function(self, dt)
        if input:pressed("confirm") then
            level.changeLevel()
        end
    end,

    draw = function(self)
        lg.printf(
            menuText.title.text,
            menuText.title.x,
            menuText.title.y,
            50,
            'center',
            0,
            2
        )
        lg.printf(
            menuText.version.text,
            menuText.version.x,
            menuText.version.y,
            190,
            "left",
            0,
            1.75
        )
    end
}
