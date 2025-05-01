FieldSizeX = 6
FieldSizeY = 6
Field = {}
FieldScanned = {}
Time = 0
Icons = {"\27[30;47m   \27[0m","\27[30;44m 1 \27[0m","\27[30;42m 2 \27[0m","\27[30;43m 3 \27[0m","\27[30;41m 4 \27[0m"}

for x = 1,FieldSizeX do
    Field[x] = {}

    for y = 1,FieldSizeY do
        Field[x][y] = math.random(0, 4)
    end
end

function display()
    for y = 1,FieldSizeY do
        for x = 1,FieldSizeX do
            if Field[x][y] > 4 then
              io.write('\27[30;41m ',Field[x][y],' \27[0m')
            else
              io.write(Icons[Field[x][y] + 1])
            end
        end
        io.write("\n")
    end
    io.write("\n")
end

function spread(x,y)
    local decX = x - 1
    local incX = x + 1
    local decY = y - 1
    local incY = y + 1
    Field[x][y] = Field[x][y] - 4
    if x ~= 1 and x ~= FieldSizeX then
        Field[decX][y] = Field[decX][y] + 1
        Field[incX][y] = Field[incX][y] + 1

        elseif x == 1 then Field[incX][y] = Field[incX][y] + 1
        elseif x == FieldSizeX then Field[decX][y] = Field[decX][y] + 1
    end
    if y ~= 1 and y ~= FieldSizeY then
        Field[x][decY] = Field[x][decY] + 1
        Field[x][incY] = Field[x][incY] + 1

        elseif y == 1 then Field[x][incY] = Field[x][incY] + 1
        elseif y == FieldSizeY then Field[x][decY] = Field[x][decY] + 1
    end
end

function scan()
    -- creates an array of cordinates of items greater than 3
    for x = 1,FieldSizeX do
        for y = 1,FieldSizeY do
            if Field[x][y] >= 4 then
                table.insert(FieldScanned, {x, y})
            end
        end
    end
end

function displayScanned()
    for n = 1,#FieldScanned do
        local extracted = FieldScanned[n]
        local x = extracted[1]
        local y = extracted[2]
        print(x, y)
    end
end

function runSpread()
    for n = 1,#FieldScanned do
        local extracted = FieldScanned[n]
        local x = extracted[1]
        local y = extracted[2]
        spread(x, y)
    end
    local count = #FieldScanned
    for i=0, count do FieldScanned[i]=nil end
end

function check()
    for y = 1,FieldSizeY do
        for x = 1,FieldSizeX do
            if Field[x][y] >= 4 then
                scan()
                runSpread()
                display()
                check()
            end
        end
    end
end

display()
check()
