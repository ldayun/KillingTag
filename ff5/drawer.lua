-----------------------------------------------------------------------------------------
--
-- drawer.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 아이템 오브젝트
	local item = display.newImageRect("image/item_2.png", 780, 355)
	item.x, item.y = 545, 325

	-- 배경
	local background = display.newImageRect("image/drawer2.jpg", display.contentWidth, display.contentHeight)
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

	local getCutter = 0
	local index = 5

	local Data = jsonParse("json/preLab.json")

	script.text = Data[index].script
	script.size = 26

	composer.setVariable("num", 3)
	composer.showOverlay("ff5.popUp")
	
	function left:tap(event)
		composer.gotoScene("ff5.cabinet")
	end

	function next:tap(event)
		display.remove(script.text)
		if(index <= #Data) then
			script.text = Data[index].script
			script.size = 26
		else
			dialog.alpha = 0
			next.alpha = 0
			script.alpha = 0
		end
		
		index = index + 1
	end

	function item:tap(event)
		getCutter = 1
		display.remove(event.target)
		
		index = 7
		display.remove(script.text)
		script.text = Data[index].script
		script.size = 26
		index = index + 1
		
		composer.setVariable("num", 4)
		composer.showOverlay("ff5.popUp")

		
		
		inventory_index = inventory_index + 1
		item_index = item_index + 1
		items[item_index] = display.newImageRect(itemGroup,  "image/item_2.png", display.contentWidth * 0.08, display.contentHeight * 0.16)
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		cutter_flag = 1
		inventoryGroup:insert(items[item_index])
		cutter_index = item_index
	end

	left:addEventListener("tap", left)
	next:addEventListener("tap", next)
	item:addEventListener("tap", item)


	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(item)
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