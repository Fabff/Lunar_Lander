-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local ship = {}
        ship.img = love.graphics.newImage("assets/images/ship.png")
        ship.x = 0
        ship.y = 0
        ship.vx = 0
        ship.vy = 0
        ship.speed = 3
        ship.angle = 270
        ship.sx = 1
        ship.sy = 1
        ship.ox = 0
        ship.oy = 0
        ship.enginImg = love.graphics.newImage("assets/images/engine.png")
        ship.engineOx = 0
        ship.engineOy = 0
local gravity = 0.6
local engineOn = false

function love.load()
    largeur_ecran = love.graphics.getWidth()
    hauteur_ecran = love.graphics.getHeight()

    ship.x = largeur_ecran/2
    ship.y = hauteur_ecran/2
    ship.ox = ship.img:getWidth()/2
    ship.oy = ship.img:getHeight()/2
    ship.engineOx = ship.enginImg:getWidth()/2
    ship.engineOy = ship.enginImg:getHeight()/2

    engineOn = false
    gravity = 0.6
end

function love.update(dt)
    ship.vy = ship.vy + (gravity*dt)

    if love.keyboard.isDown("right") then
        ship.angle = ship.angle+(90*dt)
    end
    if love.keyboard.isDown("left") then
        ship.angle = ship.angle-(90*dt)
    end
    if love.keyboard.isDown("up") then
        engineOn = true
        
        local ForceX = math.cos(math.rad(ship.angle)) * (ship.speed * dt)
        local ForceY = math.sin(math.rad(ship.angle)) * (ship.speed * dt)
        ship.vx = ship.vx + ForceX
        ship.vy = ship.vy + ForceY
    else
        engineOn = false
    end
    ship.y = ship.y + ship.vy
    ship.x = ship.x + ship.vx
end

function love.draw()
    love.graphics.draw(ship.img, ship.x, ship.y, math.rad(ship.angle), ship.sx, ship.sy, ship.ox, ship.oy)
    if engineOn then 
        love.graphics.draw(ship.enginImg, ship.x, ship.y, math.rad(ship.angle), ship.sx, ship.sy, ship.engineOx, ship.engineOy)
    end

end

function love.keypressed(key)
  print(key)
end
