return {
    UI = {
        {
            type = "progressBar",
            id = "healthbar",
            x = 50,
            y = 50,
            w = 200,
            h = 30,
            val = 100,
            col = {1.0, 1.0, 1.0, 1.0},
            crtCol = {0.9, 0.1, 0.1, 1.0},
            crtThreshold = 20,
            datasrc = "state",
            datakey = "health"    
        },
        {
            type = "counter",
            id = "points",
            x = love.graphics.getWidth() * 0.9,
            y = 50,
            w = 200,
            h = 30,
            val = 0,
            font = "assets/fonts/Cartoon.ttf",
            size = 50,
            datasrc = "state",
            datakey = "coins",
        },
        {
            type = "counter",
            id = "wavecounter",
            title = "wave",
            x = love.graphics.getWidth() * 0.5,
            y = 50,
            w = 200,
            h = 30,
            val = 0,
            font = "assets/fonts/Cartoon.ttf",
            size = 50,
            datasrc = "state",
            datakey = "wave"
        },
        {
            type = "stack",
            id = "decreestack",
            centx = (love.graphics.getWidth() * 0.5),
            centy = (love.graphics.getHeight() * 0.9),
            w = 400,
            h = 96,

            font = "assets/fonts/PixelOperator.ttf",
            fontTitle = 35,
            fontBody = 25,

            datasrc = "state",
            datakey = "inventory"
        },
        {
            type = "decreePicker",
            id = "decreepicker",
            centx = (love.graphics.getWidth() * 0.5),
            centy = (love.graphics.getHeight() * 0.5),
            w = 600,
            h = 400,
            choice = {},

            font = "assets/fonts/PixelOperator.ttf",
            tsize = 25,
            size = 16,

            datasrc = "state",
            datakey = "decrees"
        }
    },
    PlayerOpts = {
        type = "spriteAnimator",
        sheet   = love.graphics.newImage("assets/img/player/player_sheet.png"),
        frameW  = 64,
        frameH  = 64,
        anims  = {
            idle = {1, 2},
            walk = {2, 3},
            attack = {4}
        },
        startAnim = "idle",
        speed   = 0.5,
        loop    = true
    },
    EnemyOpts = {
        type = "spriteAnimator",
        sheet = love.graphics.newImage("assets/img/enemy/enemy_minion.png"),
        posX = 0,
        posY = 0,
        frameW = 64,
        frameH = 64,
        anims = {
            typeA = {1, 2},
            typeB = {3, 4}
        },
        startAnim = "typeA",
        speed = 0.5,
        loop = true
    }
}
