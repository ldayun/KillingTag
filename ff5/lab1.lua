-----------------------------------------------------------------------------------------
--
-- lab.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/lab1.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	local effect = display.newImageRect("image/lab1_effect.png", display.contentWidth * 0.03, display.contentHeight * 0.05)
	effect.x, effect.y = display.contentCenterX, display.contentCenterY + 10

	if(goldkey_flag == 1) then
		display.remove(effect)
	end
	--이벤트리스너
	function left:tap(event)
		composer.gotoScene("ff5.F5_1")
	end

	function effect:tap(event)
		composer.setVariable("effect", effect)
		composer.gotoScene("ff5.desk")
	end
	
	left:addEventListener("tap", left)
	effect:addEventListener("tap", effect)

	sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(effect)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

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