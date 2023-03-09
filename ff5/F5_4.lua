-----------------------------------------------------------------------------------------
--
-- 5F_4.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    local background = display.newImageRect("image/5F_4.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	-- 도서관 문
	local doorGroup = display.newGroup()
	local door = {}

	door[1] = display.newRect(doorGroup, display.contentCenterX - 430, display.contentCenterY + 55, 200, 358)
	door[1].path.y1 = -20
	door[1].path.y2 = 30

	doorGroup:insert(door[1])

	door[2] = display.newRect(doorGroup, display.contentCenterX + 75, display.contentCenterY + 40, 110, 230)
	door[2].path.y2 = 20
	doorGroup:insert(door[2])

	avDoor = display.newRect(display.contentWidth - 185, display.contentCenterY + 70, 130, 280)
	avDoor.path.y3 = 20

	local lockedDoor = display.newText("", display.contentCenterX, 450)
	lockedDoor.size = 40
	lockedDoor:toFront()

	function left:tap(event)
		composer.gotoScene("ff5.F5_5")
	end

    function right:tap(event)
	   	composer.gotoScene("ff5.F5_3")
	end

	function doorGroup:tap(event)
		composer.gotoScene("ff5.lib")
	end

	--시청각실 event
	function avDoor:tap(event)
		composer.setVariable("num", 7)
		composer.showOverlay("ff5.popUp")
	end

    left:addEventListener("tap", left)
    right:addEventListener("tap", right)
	doorGroup:addEventListener("tap", doorGroup)
	avDoor:addEventListener("tap", avDoor)

    sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(doorGroup)
	sceneGroup:insert(avDoor)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	
	doorGroup:toBack()
	avDoor:toBack()
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
