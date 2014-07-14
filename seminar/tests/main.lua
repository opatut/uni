function line(x, y, a, len)
    len = (len or 14) * 0.5
    love.graphics.line(x - math.sin(a) * len, y - math.cos(a) * len, x + math.sin(a) * len, y + math.cos(a) * len)
end

time = 0

function love.update(dt)
    time = time + dt
end

function orientations()
    love.graphics.setBackgroundColor(255, 255, 255)

    love.graphics.setColor(0, 0, 0)
    
    s = 14
    w = love.graphics.getWidth() / s
    h = love.graphics.getHeight() / s

    px = math.random(5,w-5)
    py = math.random(5,h-5)
    pa = math.random()

    math.randomseed(math.floor(time))
    for x=0,w do
        for y=0,h do
            if math.abs(x-px) < 5 and math.abs(y-py) < 5 then 
                a = pa
            else
                a = math.random()
            end
            line(x*s, y*s, a * math.pi * 2 + time*0)
        end
    end
end

function colorstuff()
    if math.floor(time)%2 == 0 then return end

    love.graphics.setBackgroundColor(255, 255, 255)

    s = 100
    w = love.graphics.getWidth() / s - 1
    h = love.graphics.getHeight() / s - 1

    love.graphics.setColor(0, 0, 0)
    love.graphics.setLineWidth(10)
    math.randomseed(math.floor(time))

    px = math.random(0,w)
    py = math.random(0,h)
    qx = math.random(0,w)
    qy = math.random(0,h)

    ia = math.random() * 0.25

    for x=0,w do
        for y=0,h do
            love.graphics.setColor(0, 0, 0)
            if math.abs(x-px) < 1 and math.abs(y-py) < 1 then 
                love.graphics.setColor(255, 0, 0)
            end

            a = 0
            if math.abs(x-qx) < 1 and math.abs(y-qy) < 1 then 
                a = 0.25
            end

            line((0.5+x)*s, (0.5+y)*s, (ia+a) * math.pi * 2 + time*0, s*0.5)
        end
    end
end

love.draw = colorstuff
