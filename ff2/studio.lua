-----------------------------------------------------------------------------------------
--
-- studio.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local background
local index = 1
local first = 1 --첫 화면
local wire_flag = 0
local mike_flag = 0
local button_flag = 0

local wire_outline = {}
local leftButton, rightButton, backButton
local dialog, dialogButton, text, dialog_text

local Data = jsonParse("json/studio_background.json")

local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view

	background = display.newImageRect("image/studio1.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	dialog = display.newImage("image/dialog.png")
	dialog.x , dialog.y = display.contentWidth*0.5, display.contentHeight*0.9
	dialog.alpha = 0

	dialogButton = display.newImage("image/dialog_next.png")
	dialogButton.x , dialogButton.y = display.contentWidth*0.86, display.contentHeight*0.95
	dialogButton.alpha = 0

	local function tapDialogButton( event )
		dialog.alpha = 0
		dialogButton.alpha = 0
		text.alpha = 0
		dialog_text.alpha = 0
	end
	dialogButton:addEventListener("tap", tapDialogButton)

	text = display.newText(0, display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 0

	dialog_text = display.newText(0, display.contentWidth*0.5, display.contentHeight*0.88)
	dialog_text.size = 25
	dialog_text:setFillColor(1)
	dialog_text.alpha = 0

	local studio_mike = display.newRect(display.contentCenterX + 30, display.contentCenterY + 100, 100, 120) -- 그림상 마이크 위치
	-- 마이크 드래그 이벤트 함수 -------------------------------------------------------------------------------------------
	local function dragMike( event )
		if mike_flag == 0 then
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

		 			if ( event.target.x > studio_mike.x - 50 and event.target.x < studio_mike.x + 50
		 				and event.target.y + contentDelta > studio_mike.y - 50 and event.target.y + contentDelta < studio_mike.y + 50 and index == 1 ) then
		 			 	index = 6
		 			 	background.fill = {
		 					type = "image",
		 					filename = Data[index].image
		 				}

		 				mike_flag = 1

						dialog_text.alpha = 0

		 				text.text = "[고장난 마이크로 변경되었습니다. 이제 방송이 나오지 않습니다.]"
		 				dialog.alpha = 1
		 				dialogButton.alpha = 1
		 				text.alpha = 1

		 				if mic_flag == 1 then
		 					items[mic_index].alpha = 0
		 				end

		 				index = 7
						background.fill = {
							type = "image",
							filename = Data[index].image
						}
					else
		 				event.target.x = event.target.initX
		 				event.target.y = event.target.initY
		 			end
		 		else
		 			display.getCurrentStage():setFocus( nil )
	 				event.target.isFocus = false
	 			end

	 			inventoryGroup:addEventListener("touch", drag)
	 		end
	 	end
 	end
 	if mic_flag == 1 then
 		items[mic_index]:addEventListener("touch", dragMike)
 	end

	local wire = display.newRect(display.contentCenterX - 190, display.contentCenterY + 135, 40, 100)
	-- wire 클릭 시 장면 전환 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapWire( event )
		leftButton.alpha = 0
		rightButton.alpha = 0
		backButton.alpha = 1

		if wire_flag == 0 then -- wire 안 자름
			dialog.alpha = 0
			dialogButton.alpha = 0
			text.alpha = 0
			dialog_text.alpha = 0

			if scissors_flag == 1 then
				dialog_text.text = "일단 모든 경우의 수를 제거해야 해... 미친 살인마한테서 살아남으려면.\n저기 있는 선... 가위로 잘라버리자."
				dialog.alpha = 1
				dialogButton.alpha = 1
				dialog_text.alpha = 1
			end

			index = 3
		elseif wire_flag == 1 then -- wire 자름
			index = 4
		end

	 	background.fill = {
	 		type = "image",
	 		filename = Data[index].image
	 	}
	end
	wire:addEventListener("tap", tapWire)

	local wire_outline_group = display.newGroup() -- wire 선 outline
	wire_outline[1] = display.newRect(wire_outline_group, display.contentCenterX - 370, display.contentCenterY + 110, 70, 100)
	wire_outline[1]:rotate(110)
	wire_outline[2] = display.newRect(wire_outline_group, display.contentCenterX - 300, display.contentCenterY + 170, 70, 100)
	wire_outline[2]:rotate(150)
	wire_outline[3] = display.newRect(wire_outline_group, display.contentCenterX - 247, display.contentCenterY + 250, 70, 100)
	wire_outline[3]:rotate(140)
	wire_outline[4] = display.newRect(wire_outline_group, display.contentCenterX - 160, display.contentCenterY + 275, 70, 100)
	wire_outline[4]:rotate(80)
	wire_outline[5] = display.newRect(wire_outline_group, display.contentCenterX - 65, display.contentCenterY + 250, 70, 100)
	wire_outline[5]:rotate(70)
	wire_outline[6] = display.newRect(wire_outline_group, display.contentCenterX + 30, display.contentCenterY + 220, 70, 100)
	wire_outline[6]:rotate(80)
	wire_outline[7] = display.newRect(wire_outline_group, display.contentCenterX + 125, display.contentCenterY + 235, 70, 100)
	wire_outline[7]:rotate(100)
	wire_outline[8] = display.newRect(wire_outline_group, display.contentCenterX + 220, display.contentCenterY + 260, 70, 100)
	wire_outline[8]:rotate(90)
	wire_outline[9] = display.newRect(wire_outline_group, display.contentCenterX + 315, display.contentCenterY + 240, 70, 100)
	wire_outline[9]:rotate(70)
	wire_outline[10] = display.newRect(wire_outline_group, display.contentCenterX + 390, display.contentCenterY + 180, 70, 100)
	wire_outline[10]:rotate(30)
	wire_outline[11] = display.newRect(wire_outline_group, display.contentCenterX + 420, display.contentCenterY + 90, 70, 100)
	wire_outline[11]:rotate(10)
	wire_outline[12] = display.newRect(wire_outline_group, display.contentCenterX + 430, display.contentCenterY - 10, 70, 100)
	wire_outline[13] = display.newRect(wire_outline_group, display.contentCenterX + 430, display.contentCenterY - 90, 70, 70)

	local controller = display.newRect(display.contentCenterX + 330, display.contentCenterY + 38, 110, 60)
	-- controller 클릭 시 장면 전환 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapController( event )
		leftButton.alpha = 0
		rightButton.alpha = 0
		backButton.alpha = 1
		control_button.alpha = 1

		index = 5
		background.fill = {
			type = "image",
			filename = Data[index].image
		}

		if button_flag == 0 then -- 버튼 설정 안 함
			text.alpha = 0

			dialog_text.text = "볼륨.. 이것만 위로 올라가 있네...?"
			dialog.alpha = 1
			dialogButton.alpha = 1
			dialog_text.alpha = 1
		end
	end
	controller:addEventListener("tap", tapController)

	control_button = display.newImage("image/control_button.png")
	control_button.x, control_button.y = display.contentWidth*0.765, display.contentHeight*0.23
	control_button.alpha = 0
	-- button 드래그 이벤트 함수 -------------------------------------------------------------------------------------------
	local function dragButton( event )
 		if( event.phase == "began" ) then
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true

 			event.target.initY = event.target.y
 		elseif( event.phase == "moved" ) then
 			if ( event.target.isFocus ) then
 				if event.yStart + event.yDelta > event.target.initY and event.yStart + event.yDelta < event.target.initY + 110 and button_flag == 0 then
 					event.target.y = event.yStart + event.yDelta - event.target.parent.y
 				end
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 			if ( event.target.isFocus ) then
	 			display.getCurrentStage():setFocus( nil )
	 			event.target.isFocus = false

	 			if event.target.y > event.target.initY + 100 and event.target.y < event.target.initY + 110 then
	 				control_button.y = event.target.y
	 				dialog_text.alpha = 0

	 				text.text = "[볼륨이 내려갔습니다.]"
	 				text.alpha = 1
	 				dialog.alpha = 1
	 				dialogButton.alpha = 1

	 				button_flag = 1
	 			else
	 				event.target.y = event.target.initY
	 			end
	 		else
	 			display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end
 		end
 	end
 	control_button:addEventListener("touch", dragButton)

	leftButton = display.newImage("image/left.png")
	leftButton.x, leftButton.y = display.contentWidth*0.04, display.contentHeight*0.5

	rightButton = display.newImage("image/right.png")
	rightButton.x, rightButton.y = display.contentWidth*0.86, display.contentHeight*0.5

	-- 왼쪽, 오른쪽 방향키 작동 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapLeftButton( event )
		if index == 1 or index == 6 or index == 7 then
			backButton.alpha = 0

			index = 2
			background.fill = {
				type = "image",
				filename = Data[index].image
			}
		end
	end
	local function tapRightButton( event )
		if index == 2 then
			backButton.alpha = 1

			if mike_flag == 1 then
				index = 7
			else
				index = 1
			end
			background.fill = {
				type = "image",
				filename = Data[index].image
			}
		end
	end
	leftButton:addEventListener("tap", tapLeftButton)
	rightButton:addEventListener("tap", tapRightButton)

	backButton = display.newImage("image/back.png")
	backButton.x, backButton.y = display.contentWidth*0.5, display.contentHeight*0.94
	-- back 방향키 작동 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapBackButton( event )
		dialog.alpha = 0
		dialogButton.alpha = 0
		dialog_text.alpha = 0
		text.alpha = 0

		if index == 3 or index == 4 then
			backButton.alpha = 0
			index = 2
		elseif index == 5 then
			backButton.alpha = 0
			control_button.alpha = 0
			index = 2
		elseif index == 1 or index == 6 or index == 7 then
			composer.gotoScene("ff2.floor2")
		end

		background.fill = {
			type = "image",
			filename = Data[index].image
		}

		leftButton.alpha = 1
		rightButton.alpha = 1
	end
	backButton:addEventListener("tap", tapBackButton)

	sceneGroup:insert(background)
	sceneGroup:insert(studio_mike)
	sceneGroup:insert(wire)
	sceneGroup:insert(wire_outline_group)
	sceneGroup:insert(controller)
	sceneGroup:insert(control_button)
	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(backButton)
	sceneGroup:insert(setting)
	sceneGroup:insert(dialog)
	sceneGroup:insert(dialogButton)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	studio_mike:toBack()
	wire:toBack()
	wire_outline_group:toBack()
	controller:toBack()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-----------------------------------행정실 사망 루트
		counter = display.newText(1, display.contentWidth/2, display.contentHeight/2)
		counter:setFillColor(1)
		counter.alpha = 0
		counter.size = 20
		local function cctv_twoMinute_counter ( event )
			counter.text = counter.text - 1
			if (counter.text == '0' and cctv_flag == 0) then
				--엔딩
				print("사망")
			end
		end
		timeAttack_adm = timer.performWithDelay(120000, cctv_twoMinute_counter, 1, "cctv_timer")
		-- Called when the scene is still off screen and is about to move on screen

		-- 가위 드래그 이벤트 함수 -------------------------------------------------------------------------------------------
		local function dragScissors( event )		
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

		  			for i = 1, 13 do
		  				if event.target.x > wire_outline[i].x - 50 and event.target.x < wire_outline[i].x + 50
		  					and event.target.y + contentDelta > wire_outline[i].y - 50 and event.target.y + contentDelta < wire_outline[i].y + 50 and index == 3 then
		 				 	dialog.alpha = 0
		 				 	dialogButton.alpha = 0
		 				 	dialog_text.alpha = 0

		  			 		background.fill = {
		 						type = "image",
		 						filename = Data[4].image
		 					}
		 					text.text = "[방송 배선을 잘랐습니다.]"
		  					dialog.alpha = 1
		  					dialogButton.alpha = 1
		  					text.alpha = 1

		  					wire_flag = 1 --자르기 성공
		 				end
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
		if scissors_flag == 1 then
			items[scissors_index]:addEventListener("touch", dragScissors)
		end

		sceneGroup:insert(inven_bg)
		sceneGroup:insert(inventoryGroup)
		sceneGroup:insert(setting)

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

		--content.y = 0

		timer.cancel("cctv_timer")

		if mike_flag == 1 and button_flag == 1 then
			composer.setVariable("studio_flag", 1)
		end

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
