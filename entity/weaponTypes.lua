local sheet_weapons = love.graphics.newImage("assets/img/weapons/weapons.png")

local Weapons = {
    --Claws (Default)
    Claws = {
        animType = "spriteAnimator",
        wType = "melee",
        sheet = sheet_weapons,
        frameW = 64,
        frameH = 64,
        anims = {
            atk = {1, 2, 3, 4}
        },
        startAnim = "atk",
        animSpeed = 0.05,
        loop = false,
        damage = 40,
        range = 100,
        rotationOffset = 0,
        originX = 32,
        originY = 32,
        scale = 2
    }
}

return Weapons
