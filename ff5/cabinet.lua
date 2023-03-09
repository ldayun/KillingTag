-----------------------------------------------------------------------------------------
--
-- cabinet.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 배경
	local background = display.newImageRect("image/cabinet.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	script.text = ""
	script.size = 25

	-- 서랍 오브젝트
	local drawerGroup = display.newGroup()
    local drawer = {}
    for i = 0, 1 do
        drawer[i] = display.newRect(drawerGroup, display.contentCenterX, display.contentCenterY + 45 + (i * 210), 780, 150)
	end

	-- 왼 event
	function left:tap(event)
		composer.gotoScene("ff5.preLab")
	end

	-- 캐비닛-서랍 event
	function drawer1(event)
		if(goldkey_flag == 1) then
			composer.gotoScene("ff5.drawer")
		else
			composer.setVariable("num", 6)
			composer.showOverlay("ff5.popUp")
		end
	end
	-- 아이템 없는 서랍
	function drawer0(event)
		composer.setVariable("num", 6)
		composer.showOverlay("ff5.popUp")
	end

	left:addEventListener("tap", left)
  	drawer[1]:addEventListener("tap", drawer1)
	drawer[0]:addEventListener("tap", drawer0)

	sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(drawerGroup)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

  	drawerGroup:toBack()
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