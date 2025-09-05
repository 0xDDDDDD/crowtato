local decrees = {
        {
            id = 1,
            name = "Full Moon",
            tooltip = "Increases damage by 50% but reduces speed by 20% during every 5th wave",
            icon = "assets/img/decrees/01_fullmoon.png"
        },
        {
            id = 2,
            name = "Snowfall",
            tooltip = "Enemies move at 30% speed and take 20% more damage for 3 seconds on hit",
            icon = "assets/img/decrees/02_snowfall.png"
        },
        {
            id = 3,
            name = "Calcium",
            tooltip = "Reduce incoming damage by 7% per decree",
            icon = "assets/img/decrees/03_calcium.png"
        },
        {
            id = 4,
            name = "Capacitor",
            tooltip = "Health received while at full health is converted into radial damage",
            icon = "assets/img/decrees/04_capacitor.png"
        },
        {
            id = 5,
            name = "Devourer",
            tooltip = "5% chance to heal 10% of HP on enemy kill",
            icon = "assets/img/decrees/05_devourer.png"
        },
        {
            id = 6,
            name = "Magnificent Envy",
            tooltip = "1.5x coins collected, but enemies move 30% faster when within 5 meters",
            icon = "assets/img/decrees/06_magenvy.png"
        },
        {
            id = 7,
            name = "Pit Stop",
            tooltip = "Every 10th wave, get 20% health back",
            icon = "assets/img/decrees/07_pitstop.png"
        },
        {
            id = 8,
            name = "Stonks",
            tooltip = "5% chance that an enemy gives 10x coins amount",
            icon = "assets/img/decrees/08_stonks.png"
        },
        {
            id = 9,
            name = "Circular Saw",
            tooltip = "The more coins required, the faster you attack",
            icon = "assets/img/decrees/09_circularsaw.png"
        },
        {
            id = 10,
            name = "Confetti Regretti",
            tooltip = "10% chance to teleport to a random point in the map on hit",
            icon = "assets/img/decrees/10_confetti.png"
        },
        {
            id = 11,
            name = "Devils Deal",
            tooltip = "Survive lethal damage. Consumes this and 2 other random decrees",
            icon = "assets/img/decrees/11_devilsdeal.png"
        },
        {
            id = 12,
            name = "Nice",
            tooltip = "Waves: Multiples of 6, you move faster. Multiples of 9, enemies do",
            icon = "assets/img/decrees/12_nice.png"
        }
    }

for _, decree in ipairs (decrees) do
    decree.icon = love.graphics.newImage(decree.icon)
end

return decrees
