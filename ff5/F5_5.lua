-----------------------------------------------------------------------------------------
--
-- 5F_5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    local background = display.newImageRect("image/5F_5.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	local door = display.newRect(display.contentCenterX + 290, display.contentCenterY + 90, 160, 530)
	door.path.y4 = -30

	local lockedDoor = display.newText("", display.contentCenterX, 450)
	lockedDoor.size = 40
	lockedDoor:toFront()

	function right:tap(event)
		composer.gotoScene("ff5.F5_4")
	end

	function door:tap(event)
		composer.setVariable("num", 7)
		composer.showOverlay("ff5.popUp")
	end


    right:addEventListener("tap", right)
	door:addEventListener("tap", door)

    sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
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
