-----------------------------------------------------------------------------------------
--
-- item.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- inventoryGroup = display.newGroup()
	-- inven_bg = display.newImage(inventoryGroup, "image/ui.png", display.contentWidth*0.945, display.contentHeight/2)
	-- inven_bg.alpha = 0.5
	-- inventory = {} 
	-- inventory_index = 1
	-- itemGroup = display.newGroup()
	-- items = {}
	-- item_index = 1
	-- red = {}
	


	-- for i = 1, 9 do 
	-- 	inventory[i] = display.newImage(inventoryGroup, "image/ui3.png")
	-- 	inventory[i].x, inventory[i].y = display.contentWidth*0.945, display.contentHeight*0.1 + (i-1)*130
	-- end

	-- function drag ( event )
	-- 	if( event.phase == "began" ) then
	-- 	   display.getCurrentStage():setFocus( event.target )
	-- 	   event.target.isFocus = true
	 
	-- 	   event.target.yStart = event.target.y
	 
	-- 	elseif( event.phase == "moved" ) then
	-- 	   if( event.target.isFocus ) then
	-- 		  event.target.y = event.target.yStart + event.yDelta
	-- 	   end
	-- 	elseif( event.phase == "ended" or event.phase == "cancelled") then
	-- 	   if( event.target.isFocus ) then
	-- 		  display.getCurrentStage():setFocus( nil )
	-- 		  event.target.isFocus = false
	-- 		  if(event.target.y > 100) then
	-- 			 event.target.y = 0
	-- 		  end
	-- 		  if(event.target.y < -600) then
	-- 			 event.target.y = display.contentHeight*-0.65
	-- 		  end
	-- 	   else
	-- 		  display.getCurrentStage():setFocus( nil )
	-- 		  event.target.isFocus = false
	-- 	   end
	-- 	end
	--  end
	--  inventoryGroup:addEventListener("touch", drag)
	 
	-- -- 적용이 안됨..
	-- function itemsTap( event )
	-- 	local position_x = event.target.x
	-- 	local position_y = event.target.y
	-- 	if ((flag == 0)and event.target ==inventory[key_index]) then
	-- 		flag = 1
	-- 		print("클릭")
	-- 		red = display.newImage(inventoryGroup, "image/red.png")
	-- 		red.x, red.y = position_x, position_y
	-- 		items[item_index] = display.newImage(itemGroup, "image/mediakey.png", display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130)
	-- 		inventoryGroup:insert(items[item_index])
	-- 	elseif (flag == 1 and event.target ==inventory[key_index]) then
	-- 		flag = 0
	-- 		red:removeSelf()
	-- 	end
 --    end
	-- for i = 1, 9 do
 --    	inventory[i]:addEventListener("tap", itemsTap)
	-- end
	
		--[[
		if (composer.getVariable("flag") == "mediaKey") then
			items[item_index] = display.newImage(itemGroup, "image/mediakey.png")
			items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130 
			print("방송실열쇠 획득")
			-- local timeAttack = composer.getVariable("timeAttack")
			item_index = item_index + 1
		end
		]]


		

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
		composer.removeScene("item")

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