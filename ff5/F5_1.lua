-----------------------------------------------------------------------------------------
--
-- ff5_1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- 배경
    local background = display.newImageRect("image/5F_1.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	local door = display.newRect(display.contentCenterX, display.contentCenterY + 70, 410, 300)
	door.path.x1, door.path.y1 = -2, -78
	door.path.x2, door.path.y2 = -2, 138
	door.path.y3 = -100
	
	function left:tap(event)
	    composer.gotoScene("ff5.F5_2")
	end

	-- 문 누르면
	function door:tap(event)
		composer.gotoScene("ff5.lab1")
	end
	
	left:addEventListener("tap", left)
	door:addEventListener("tap", door)

    sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(door)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	door:toBack()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
