-----------------------------------------------------------------------------------------
--
-- blackout.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0)

	local time = display.newText(2, display.contentWidth*0.23, display.contentHeight*0.1)
	time.size = 20
	time:setFillColor(1)

	local back = display.newImage("image/UI/left.png", display.contentWidth*0.03, display.contentHeight/2)
	back.x, back.y = display.contentWidth*0.04, display.contentHeight*0.5
    back.alpha = 0

	local function counter ( event )
		time.text = time.text - 1

	 	if time.text == '0' then
			back.alpha = 1
		end
	end
	local timeAttack = timer.performWithDelay(1000, counter, 2)

	function back:tap( event )
		composer.hideOverlay("blackout")
	end
	back:addEventListener("tap", back)

	sceneGroup:insert(background)
	sceneGroup:insert(time)
	sceneGroup:insert(back)

	time:toBack()
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