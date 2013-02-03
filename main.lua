local palabra, correcta, erronea1, erronea2, erronea3

--local json = require "json"
local json = require "dkjson"

local genera
local clean
local rect1, rect2, rect3, rect4

-- jsonFile() loads json file & returns contents as a string
local jsonFile = function( filename, base )
	
	-- set default base dir if none specified
	if not base then base = system.ResourceDirectory; end
	
	-- create a file path for corona i/o
	local path = system.pathForFile( filename, base )
	
	-- will hold contents of file
	local contents
	
	-- io.open opens a file at path. returns nil if no file found
	local file = io.open( path, "r+" )
	if file then
	   -- read all contents of file into a string
	   contents = file:read( "*a" )

	   io.close( file )	-- close the file after using it
	end

	return contents
end

local contenidos

local function onComplete( event )
	if event.action == "clicked" then
		if event.index == 2 then
			clean()
--			genera()
		end
	end
end

local function esCorrecta( event )
	
	if event.target.texto.text == contenidos.right then
		--display.newText( "CORRECTA!!!", 100, 200, nil, 50 )
		--native.showAlert( "CORRECTA!", "Respuesta correcta", { "OK", "Repetir" },onComplete )
	else
		--display.newText( "INCORRECTA :(", 100, 300, nil, 50 )
		--native.showAlert( "INCORRECTA", "Respuesta incorrecta", { "OK", "Repetir" },onComplete )
	end
	return true 
	-- body
end


local function networkListener( event )
	if event.isError then
		print( "Network error" )
	else
		js = event.response
		contenidos = json.decode( jsonFile( "test.json", system.DocumentsDirectory ), 1, nil)
		--for i = 1, #contenidos do
		palabra = contenidos.word
		correcta = contenidos.right 
		erronea1 = contenidos.wrongs[1] 
		erronea2 = contenidos.wrongs[2]
		erronea3 = contenidos.wrongs[3] 

		texto = display.newText( palabra, 100,100, nil, 40 )

		rect1 = display.newRect( 0, 0 , 200, 100 )
		rect1.x = display.contentWidth * 0.25
		rect1.y = display.contentHeight * 0.6
		rect1.texto = display.newText( correcta, rect1.x- 50, rect1.y, nil, 30 )
		rect1.texto:setTextColor( 0,0,0 )

		rect2 = display.newRect( 0, 0 , 200, 100 )
		rect2.x = display.contentWidth * 0.75
		rect2.y = display.contentHeight * 0.6
		rect2.texto = display.newText( erronea1, rect2.x- 50, rect2.y, nil, 30 )
		rect2.texto:setTextColor( 0,0,0 )

		rect3 = display.newRect( 0, 0 , 200, 100 )
		rect3.x = display.contentWidth * 0.25
		rect3.y = display.contentHeight * 0.8
		rect3.texto = display.newText( erronea2, rect3.x- 50, rect3.y, nil, 30 )
		rect3.texto:setTextColor( 0,0,0 )

		rect4 = display.newRect( 0, 0 , 200, 100 )
		rect4.x = display.contentWidth * 0.75
		rect4.y = display.contentHeight * 0.8
		rect4.texto = display.newText( erronea3, rect4.x- 50, rect4.y, nil, 30 )
		rect4.texto:setTextColor( 0,0,0 )
		--end

		rect1:addEventListener( "tap", esCorrecta )
		rect2:addEventListener( "tap", esCorrecta )
		rect3:addEventListener( "tap", esCorrecta )
		rect4:addEventListener( "tap", esCorrecta )

	end
end

--genera = function()

	network.download( "http://tranquil-reef-7447.herokuapp.com/api/core/vocabulary", "GET", networkListener, "test.json", system.DocumentsDirectory )

--end
--[[
clean = function()

	rect1:removeEventListener( "tap", esCorrecta )
	rect2:removeEventListener( "tap", esCorrecta )
	rect3:removeEventListener( "tap", esCorrecta )
	rect4:removeEventListener( "tap", esCorrecta )

	display.remove( rect1.texto )
	display.remove( rect1 )

	display.remove( rect2.texto )
	display.remove( rect2 )

	display.remove( rect3.texto )
	display.remove( rect3 )

	display.remove( rect4.texto )
	display.remove( rect4 )
end--]]

--genera()

--local contenidos = json.decode ( jsonFile( "test.json", system.DocumentsDirectory ) )

--print( #contenidos )

--for i = 1, #contenidos do
--	print( contenidos[i] .. "\n")
--end 