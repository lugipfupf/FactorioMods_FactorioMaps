function fm.generateMap(data)
	playerposition = game.players[player_index].position
	ingameresolution = 0 -- default

	local squaresize = gridpixelarray[gridsizeindex]
	local ingametotalwidth = math.ceil(math.abs(txtTopLeftX.text) + math.abs(txtBottomRightX.text))
	local ingametotalheight = math.ceil(math.abs(txtTopLeftY.text) + math.abs(txtBottomRightY.text))
	local numberofhorizontalscreenshots = math.ceil(ingametotalwidth/squaresize)
	local numberofverticalscreenshots =  math.ceil(ingametotalheight/squaresize)
	local zooming = 1 -- counter for measuring zoom, 1/1, 1/2,1/4,1/8 etc

	-- delete folder (if it already exists)
	game.remove_path("FactorioMaps/" .. txtFolderName.text)

	-- calculate min/max zoom levels
	--
	minzoom = 0 -- lvl 0 is always 256x256, the resolution in which google maps calculates positions
	maxzoom = 0 -- default

	local resolutionarray = {8,16,32,64,128,256,512,1024,2048,4096,8192} -- resolution for each zoom level, lvl 0 is always 8x8 (256x256 pixels)

	local maxcounter = 0 -- in google maps, max zoom out level is 0, so start with 0
	for _,res in pairs(resolutionarray) do
		if(ingametotalwidth < res and ingametotalheight < res) then
			maxzoom = maxcounter
			ingameresolution = res
			center = toLatLng(res, {x=ingametotalwidth/2, y=ingametotalheight/2})
			break
		end
		maxcounter = maxcounter + 1
	end

	local latlng = toLatLng(ingameresolution,{x=ingametotalwidth,y=ingametotalheight})
	linesarray =
	{
		{lat = 84.5, lng = -179}, -- start top left
		{lat = 84.5, lng = -50}, -- lng = latlng.lng/2}, -- intermediate point, so the line won't "flip"
		{lat = 84.5, lng = latlng.lng},
		{lat = latlng.lat, lng = latlng.lng},
		{lat = latlng.lat, lng =  -50},
		{lat = latlng.lat, lng = -179},
		{lat = 84.5, lng = -179} -- start top left
	}
	if gridsizeindex == 1 then
		minzoom = 0
	elseif gridsizeindex == 2 then
		minzoom = 2
	elseif gridsizeindex == 3 then
		minzoom = 3
	end

	if(extrazoomin == false) then -- if (no max level zoom in), skip this step
		maxzoom = maxzoom - 1
		zooming = zooming / 2 -- startzoom
		numberofhorizontalscreenshots = math.ceil(numberofhorizontalscreenshots/2)
		numberofverticalscreenshots = math.ceil(numberofverticalscreenshots/2)
	elseif(z==minzoom and extrazoomout == false) then -- if (no extra zoom out), skip this step
		-- debug: if minzoom < smallest zoomlevel possible, skip the step before the minzoom level
		minzoom = minzoom + 1
	end

	--debug: fails for very small maps where maxzoom < minzoom
	for z=maxzoom,minzoom,-1 do  -- max and min zoomlevels
		for y=0,numberofverticalscreenshots-1 do


			for x=0,numberofhorizontalscreenshots-1 do
				if((extensionindex==2 and z==maxzoom) or extensionindex==3) then
					extension = "png"
				else
					extension = "jpg"
				end
				local positiontext = {txtTopLeftX.text + (1/(2*zooming))*squaresize + x*(1/zooming)*squaresize, txtTopLeftY.text + (1/(2*zooming))*squaresize + y*(1/zooming)*squaresize}
				local resolutiontext = {gridsizearray[gridsizeindex],gridsizearray[gridsizeindex]}
				local pathtext = "FactorioMaps/".. txtFolderName.text .. "/Images/".. z .."_".. x .."_".. y ..".".. extension
				game.take_screenshot({position=positiontext, resolution=resolutiontext, zoom=zooming, path= pathtext, show_entity_info=showalt})
			end
		end

		zooming = zooming/2
		if gridsizeindex == 1 and zooming < 1/256 then
			game.players[player_index].print("max level zoom break")
			minzoom = z
			break
		elseif gridsizeindex == 2 and zooming < 1/64 then
			game.players[player_index].print("max level zoom break")
			minzoom = z
			break
		elseif gridsizeindex == 3 and zooming < 1/32 then
			game.players[player_index].print("max level zoom break")
			minzoom = z
			break
		end

		numberofhorizontalscreenshots = math.ceil(numberofhorizontalscreenshots/2)
		numberofverticalscreenshots = math.ceil(numberofverticalscreenshots/2)
	end
end
