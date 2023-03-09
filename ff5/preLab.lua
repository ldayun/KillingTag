-----------------------------------------------------------------------------------------
--
-- preLab.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/preLab.jpg", display.contentWidth, display.contentHeight)
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
		
	-- 아이템이 없는 서랍

	local itemCabinet = display.newRect(570, 300, 355, 500)

	local Data = jsonParse("json/preLab.json")
	-- script
	script =  display.newText("", 210, 590)

	local index1 = 1
	local index2 = 0
	local preLabScript = 5

	script = display.newText( Data[index1].script, 210, 590)
	index1 = index1 + 1
	script.size = 26
	script:toFront()

	--이벤트리스너
	function left:tap(event)
		composer.gotoScene("ff5.F5_2")
	end

	function next:tap(event)
		display.remove(script.text)
		index1 = index1 + 1
		if(index1 < preLabScript) then
			script.text = Data[index1].script, 210, 590
			script.size = 26
		else
			script.text = ""
			dialog.alpha = 0
			next.alpha = 0
		end
	end

	function cabinet(event)
		if(event.x >= 80 and event.x <= 360 and event.y >= 50 and event.y <= 540 
		or event.x >= 770 and event.x <= 1030 and event.y >= 50 and event.y <= 540 ) then
			composer.setVariable("num", 6)
			composer.showOverlay("ff5.popUp")
		end
	end
	
	-- 캐비닛 event
	function itemCabinet:tap(event)
		composer.gotoScene("ff5.cabinet")
	end

	left:addEventListener("tap", left)
  	itemCabinet:addEventListener("tap", itemCabinet)
	next:addEventListener("tap", next)
	self.view:addEventListener("tap", cabinet)
	
	sceneGroup:insert(background)
    sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(dialog)
	sceneGroup:insert(next)
	sceneGroup:insert(script)
	sceneGroup:insert(itemCabinet)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	--cabinetGroup:toBack()
	itemCabinet:toBack()
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