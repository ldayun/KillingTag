-----------------------------------------------------------------------------------------
--
-- cctv_af.lua
-- cctv 제거 후
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/adm/cctv_af.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	
	-- 방향키
	local back = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight/2)

	--설정
	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)
	
	local box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.9)

	local nextKey = display.newImage("image/UI/next.png", display.contentWidth*0.86, display.contentHeight*0.95)

	local content_cctv_off = display.newText("[ 밝은 불빛이 갑자기 블랙아웃된다. ]", display.contentWidth*0.5, display.contentHeight*0.88)
	content_cctv_off.size = 25----------------------------------event

	function back:tap( event )
		print("행정실로")
		composer.gotoScene("ff1.adm")
	end
	back:addEventListener("tap", back)


	sceneGroup:insert(background)
	sceneGroup:insert(setting)
	sceneGroup:insert(back)
	sceneGroup:insert(box)
	sceneGroup:insert(nextKey)
	sceneGroup:insert(content_cctv_off)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
end	



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		composer.showOverlay("ff1.cctv_off")
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
		cctv_flag = 1
		composer.removeScene("ff1.cctv_af")
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