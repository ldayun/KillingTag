-----------------------------------------------------------------------------------------
--
-- gate.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- goodEnding sound
local sound_goodEnding = audio.loadStream( "music/good_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/gate.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local GateData = jsonParse("json/gate_background.json")

	--설정
	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	-- backButton 구현
	local backButton = display.newImage("image/back.png")
	backButton.x, backButton.y = display.contentWidth*0.5, display.contentHeight*0.94

	local function tapBackButton( event )
		composer.gotoScene("ff1.view1")
	end
	backButton:addEventListener("tap", tapBackButton)

	local index = 2
	local door_lock1 = display.newRect(display.contentCenterX + 10, display.contentCenterY + 100, 70, 70) --자물쇠 위치
	-- 자물쇠 클릭하면 확대해서 보여주는 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapDoorLock( event )
		if index == 2 then
			index = 3
			backButton.alpha = 0

			background.fill = { 
				type = "image",
				filename = GateData[index].image
			}
		end
	end
	door_lock1:addEventListener("tap", tapDoorLock)

	local door_lock2 = display.newRect(display.contentCenterX, display.contentCenterY, 200, 200) --자물쇠 위치
	-- 교문 key 드래그해서 자물쇠 여는 이벤트 함수 -------------------------------------------------------------------------------------------
	local function dragGateKey( event )
 		if( event.phase == "began" ) then  
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true

 			event.target.initX = event.target.x
 			event.target.initY = event.target.y

 			inventoryGroup:removeEventListener("touch", drag)

 		elseif( event.phase == "moved" ) then
 			if ( event.target.isFocus ) then
 				event.target.x = event.xStart + event.xDelta - event.target.parent.x
 				event.target.y = event.yStart + event.yDelta - event.target.parent.y
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 			if ( event.target.isFocus ) then 
	 			display.getCurrentStage():setFocus( nil )
	 			event.target.isFocus = false 

	 			if( event.target.x > door_lock2.x - 100 and event.target.x < door_lock2.x + 100
	 				and event.target.y > door_lock2.y - 100 and event.target.y < door_lock2.y + 100 and index == 3 ) then
	 				index = 4
	 				background.fill = { 
						type = "image",
						filename = GateData[index].image
					}
	 			end

	 			event.target.x = event.target.initX
	 			event.target.y = event.target.initY
	 		else 
	 			display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end

 			inventoryGroup:addEventListener("touch", drag)
 		end
 	end
 	-- 아이템 임시구현 --------------------------
 -- 	items[item_index] = display.newImage(itemGroup, "image/gateKey.png")
	-- items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index)*130
	-- inventoryGroup:insert(items[item_index])
	items[gate_key_index]:addEventListener("touch", dragGateKey)
	--items[item_index].alpha = 0 --- 교문 열쇠. alpha 해제하면 보임

	local door_lock3 = display.newRect(display.contentCenterX, display.contentCenterY - 150, 500, 380) --자물쇠 위치
	-- 쇠 절단기 드래그해서 자물쇠 부수는 이벤트 함수 -------------------------------------------------------------------------------------------
	local function dragCutter( event )
 		if( event.phase == "began" ) then  
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true

 			event.target.initX = event.target.x
 			event.target.initY = event.target.y

 			inventoryGroup:removeEventListener("touch", drag)

 		elseif( event.phase == "moved" ) then
 			if ( event.target.isFocus ) then
 				event.target.x = event.xStart + event.xDelta - event.target.parent.x
 				event.target.y = event.yStart + event.yDelta - event.target.parent.y
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 			if ( event.target.isFocus ) then 
	 			display.getCurrentStage():setFocus( nil )
	 			event.target.isFocus = false 

	 			if( event.target.x > door_lock3.x - 100 and event.target.x < door_lock3.x + 100
	 				and event.target.y > door_lock3.y - 100 and event.target.y < door_lock3.y + 100 and index == 4 ) then
	 				index = 5
	 				background.fill = { 
						type = "image",
						filename = GateData[index].image
					}
	 			end

	 			event.target.x = event.target.initX
	 			event.target.y = event.target.initY
	 		else 
	 			display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end

 			inventoryGroup:addEventListener("touch", drag)
 		end
 	end
 	-- 아이템 임시구현 --------------------------
	-- items[item_index + 1] = display.newImage(itemGroup, "image/cutter.png")
	-- items[item_index + 1].x, items[item_index + 1].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index + 1)*130
	-- inventoryGroup:insert(items[item_index + 1])
	items[cutter_index]:addEventListener("touch", dragCutter)
	--items[item_index + 1].alpha = 0 --- 쇠 절단기. alpha 해제하면 보임

	-- 부서진 문 탭하면 밖으로 나가는 이벤트 함수 (에필로그와 이어짐) -------------------------------------------------------------------------------------------
	local function tapGate( event )
		if index == 5 then
			index = 6

			background.fill = { 
				type = "image",
				filename = GateData[index].image
			}

			timer.cancel(timeAttack)

			-- 기존 음악들 제거
			audio.pause(backSound)

			-- goodEnding sound play
   			audio.play(sound_goodEnding, {loops = 0})

   			-- 에필로그 영상 넣기
			composer.gotoScene("epilogue")
		end
	end
	background:addEventListener("tap", tapGate)

	sceneGroup:insert(background)
	sceneGroup:insert(setting)
	sceneGroup:insert(backButton)
	sceneGroup:insert(door_lock1)
	sceneGroup:insert(door_lock2)
	sceneGroup:insert(door_lock3)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	door_lock1:toBack()
	door_lock2:toBack()
	door_lock3:toBack()
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