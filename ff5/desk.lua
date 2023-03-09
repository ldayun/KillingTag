-----------------------------------------------------------------------------------------
--
-- desk.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/lab1_desk.jpg", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight/ 2

	local left = display.newImage("image/leftButton.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5
	
    local right = display.newImage("image/rightButton.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	local key = display.newImageRect("image/item_key.png", display.contentWidth * 0.3, display.contentHeight * 0.3)
    key.x, key.y = display.contentWidth * 0.5, display.contentHeight * 0.48

	-- 대사창
	local dialog = display.newImageRect("image/dialog.png", display.contentWidth * 0.9 , display.contentHeight * 0.6)
	dialog.x, dialog.y = display.contentCenterX * 0.9, display.contentHeight * 1.05
	dialog.alpha = 0
	-- 대사창 다음버튼
	local next = display.newImageRect("image/next.png", display.contentWidth * 0.044 , display.contentHeight * 0.03)
	next.x, next.y = display.contentCenterX * 1.66, display.contentHeight * 0.95
	next.alpha = 0

	script =  display.newText("", 210, 590)

	--local effect = display.newImage("")
	--이벤트리스너
	function left:tap(event)
		composer.gotoScene("ff5.lab1")
	end

	function next:tap(event)
		script.text = ""
		dialog.alpha = 0
		next.alpha = 0
	end

	function key:tap(event)
		composer.setVariable("num", 5)
		composer.showOverlay("ff5.popUp")
		
		local effect = composer.getVariable("effect")
		display.remove(effect)
		effect = nil

		display.remove(event.target)
		script.text = "[어딘가에 쓰일 것 같다.]"



		
		item_index = item_index + 1
		inventory_index = inventory_index + 1
		items[item_index] = display.newImageRect(itemGroup, "image/item_key.png", display.contentWidth * 0.1, display.contentHeight * 0.18)
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		goldkey_flag = 1
		inventoryGroup:insert(items[item_index])
		goldkey_index = item_index

		dialog.alpha = 1
		next.alpha = 1

		script.size = 26
	end

    left:addEventListener("tap", left)
	key:addEventListener("tap", key)
	--self.view:addEventListener("tap", key)
	next:addEventListener("tap", next)
	
	sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(key)
	sceneGroup:insert(dialog)
	sceneGroup:insert(next)
	sceneGroup:insert(script)
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