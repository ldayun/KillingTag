-----------------------------------------------------------------------------------------
--
-- view3.lua
-- 복도 세번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/background/bg3.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	

	local left = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	local right = display.newImage("image/UI/right.png", display.contentWidth*0.86, display.contentHeight*0.5)

	local up = display.newImage("image/UI/up.png", display.contentWidth*0.45, display.contentHeight*0.2)

	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)


	

	--event-----------------------------------------------------------------
	function left:tap( event )
		print("2로이동")
		composer.gotoScene("ff1.view2")
	end
	left:addEventListener("tap", left)

	function right:tap( event )
		print("4으로이동")
		composer.gotoScene("ff1.view4")
		-- body
	end
	right:addEventListener("tap", right)

	function up:tap( event )
		print("2층으로 이동")
		composer.gotoScene("ff2.floor2")
	end
	up:addEventListener("tap", up)
	
	--json	

	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(up)
	sceneGroup:insert(setting)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	right:toFront()
	inven_bg:toFront()
	inventoryGroup:toFront()
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

	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene("ff1.view3")
		inventoryGroup.y = 0
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
