-----------------------------------------------------------------------------------------
--
-- lib1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/library2.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	-- 대사창
	local dialog = display.newImageRect("image/dialog.png", display.contentWidth * 0.9 , display.contentHeight * 0.6)
	dialog.x, dialog.y = display.contentCenterX * 0.9, display.contentHeight * 1.05
	-- 대사창 다음버튼
	local next = display.newImageRect("image/next.png", display.contentWidth * 0.044 , display.contentHeight * 0.03)
	next.x, next.y = display.contentCenterX * 1.66, display.contentHeight * 0.95
	
	local item = display.newRect(555, 280, 40, 180)
    item.alpha = 0.5


	local Data = jsonParse("json/library.json")
	local content = display.newGroup()
	--local script = display.newText("", 210, 590)

    function left:tap(event)
		if (event.target.x > left.x - 50 and event.target.x < left.x + 50
		 	and event.target.y > left.y - 50 and event.target.y < left.y + 50) then
	        	composer.gotoScene("ff5.lib")
 		end
	end

    function item:tap(event)
		composer.setVariable("num", 2)
		composer.showOverlay("ff5.popUp")
	end
	
	function next:tap(event)
		if(script ~= nil) then
			script.text = ""
		end
		--script.size = 26
		script:toFront()
	end


	left:addEventListener("tap", left)
    item:addEventListener("tap", item)
	next:addEventListener("tap", next)

	sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
    sceneGroup:insert(item)
	sceneGroup:insert(dialog)
	sceneGroup:insert(next)
	sceneGroup:insert(script)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

    item:toBack()
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