--Load Sprites
local sheet_minions = love.graphics.newImage("assets/img/enemy/enemy_minion.png")

local EnemyTypes = {
    --Maggot
    Maggot = {
        animType = "spriteAnimator",
        sheet = sheet_minions,
        frameW = 64,
        frameH = 64,
        anims = {
            walk = {1, 2}
        },
        startAnim = "walk",
        animSpeed = 0.5,
        loop = true,
        posX = 0,
        posY = 0,
        movSpeed = 220,
        damage = 10,
        behaviors = {
            "chase"
        }
    },
    --Slime
    Slime = {
        animType = "spriteAnimator",
        sheet = sheet_minions,
        frameW = 64,
        frameH = 64,
        anims = {
            walk = {3, 4}
        },
        startAnim = "walk",
        animSpeed = 0.5,
        loop = true,
        posX = 0,
        posY = 0,
        movSpeed = 280,
        damage = 20,
        behaviors = {
            "chase",
            "throw"
        }
    }
}

return EnemyTypes
