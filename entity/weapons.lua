local sheet_weapons = love.graphics.newImage("assets/img/weapons/claws.png")

local Weapons = {
    --Claws (Default)
    Claws = {
        animType = "SpriteAnimator",
        sheet = sheet_weapons,
        frameW = 64,
        frameH = 64,
        anims = {
            swing = {1, 2, 3, 4}
        },
        startAnim = "swing",
        animSpeed = 0.1,
        loop = false,
        damage = 40,
        range = 100,
        hitArc = math.rad(90)
    }
}
