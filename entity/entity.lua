local Entity = {}
--TODO: This should have a "create entity" function that is similar to the create UI function. Something to offload the specifics here
Entity.Player = require("entity.player")
Entity.Enemy = require("entity.enemy")

return Entity
