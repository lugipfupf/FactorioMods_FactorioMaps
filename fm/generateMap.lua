
require "stdlib/area/area"

function fm.generateMap(data)
    -- delete folder (if it already exists)
    local basePath = "FactorioMaps/" .. data.folderName
    game.remove_path(basePath)

    local inGameTotalWidth = math.ceil(math.abs(data.topLeft.x) + math.abs(data.bottomRight.x))
    local inGameTotalHeight = math.ceil(math.abs(data.topLeft.y) + math.abs(data.bottomRight.y))
    local inGameResolution = 0
    local inGameCenter = Area.center({data.topLeft, data.bottomRight})

    local gridSizes = {256, 512, 1024, 2048}
    local gridSize = gridSizes[data.gridSize]

    local gridPixelSizes = {8, 16, 32, 64}
    local gridPixelSize = gridPixelSizes[data.gridSize]

    local numHScreenshots = 0
    local numVScreenshots = 0

    local currentZoomLevel = 1 -- counter for measuring zoom, 1/1, 1/2,1/4,1/8 etc
    local minZoomLevel = data.gridSize
    local maxZoomLevel = 0 -- default

    local resolutionArray = {8,16,32,64,128,256,512,1024,2048,4096,8192} -- resolution for each zoom level, lvl 0 is always 8x8 (256x256 pixels)

    local tmpCounter = 0 -- in google maps, max zoom out level is 0, so start with 0
    for _, resolution in pairs(resolutionArray) do
        if(inGameTotalWidth < resolution and inGameTotalHeight < resolution) then
            maxZoomLevel = tmpCounter
            inGameResolution = resolution
            break
        end
        tmpCounter = tmpCounter + 1
    end

    if maxZoomLevel < minZoomLevel then maxZoomLevel = minZoomLevel end

    --Setup the results table for feeding into generateIndex
    data.index = {}
    data.index.inGameCenter = inGameCenter
    data.index.maxZoomLevel = maxZoomLevel
    data.index.minZoomLevel = minZoomLevel
    data.index.gridSize = gridSize
    data.index.gridPixelSize = gridPixelSize
    data.index.inGameResolution = inGameResolution

    --Temp variables used in loops
    local extension = ""
    local pathText = ""
    local positionText = ""
    local resolutionText = ""
    local screenshotTopLeftX = 0
    local screenshotTopLeftY = 0

    numHScreenshots = math.ceil(inGameTotalWidth / gridPixelSize)
    numVScreenshots =  math.ceil(inGameTotalHeight / gridPixelSize)
    --Attempts to align the center of the map with the center of the base center
    --Really only works for zoom level 1
    --Need to find magic math for aligning it for all zoom levels. This will require adjusting num*Screenshots
    screenshotTopLeftX = inGameCenter.x - math.floor(numHScreenshots * gridPixelSize / 2)
    screenshotTopLeftY = inGameCenter.y - math.floor(numVScreenshots * gridPixelSize / 2)

    for z = maxZoomLevel, minZoomLevel, -1 do  -- max and min zoomlevels
        for y = 0, numVScreenshots - 1 do
            for x = 0, numHScreenshots - 1 do
                if((data.extension == 2 and z == maxZoomLevel) or data.extension == 3) then
                    extension = "png"
                else
                    extension = "jpg"
                end
                positionTable = {screenshotTopLeftX + (1 / (2 * currentZoomLevel)) * gridPixelSize + x * (1 / currentZoomLevel) * gridPixelSize, screenshotTopLeftY + (1 / (2 * currentZoomLevel)) * gridPixelSize + y * (1 / currentZoomLevel) * gridPixelSize}
                pathText = basePath .. "/Images/" .. z .. "_" .. x .. "_" .. y .. "." .. extension
                game.take_screenshot({position = positionTable, resolution = {gridSize, gridSize}, zoom = currentZoomLevel, path = pathText, show_entity_info = data.altInfo})
            end
        end

        currentZoomLevel = currentZoomLevel / 2
        numHScreenshots = math.ceil(numHScreenshots / 2)
        numVScreenshots = math.ceil(numVScreenshots / 2)
    end
end
