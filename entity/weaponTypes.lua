local sheet_weapons = love.graphics.newImage("assets/img/weapons/claws.png")

local Weapons = {
    --Claws (Default)
    Claws = {
        animType = "spriteAnimator",
        sheet = sheet_weapons,
        frameW = 64,
        frameH = 64,
        anims = {
            swing = {1, 2, 3, 4}
        },
        startAnim = "swing",
        animSpeed = 0.05,
        loop = false,
        damage = 40,
        range = 100,
    }
}

return Weapons
