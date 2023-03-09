-----------------------------------------------------------------------------------------
--
-- artRoom.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local index = 1
local flag = 0
local flag_scissors = 0

local dialog, dialogButton, text, dialog_text
local backButton

local time, timeAttack
local killer_stop = "false"

local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/artRoom1.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local Data = jsonParse("json/artRoom_background.json")

	local cabinet = display.newRect(display.contentCenterX + 422, display.contentCenterY - 82, 82, 175)
	local function tapCabinet( event )
		if flag == 0 then
			killer_stop = "true"
			composer.showOverlay("ff2.blackout")
		end
	end
	cabinet:addEventListener("tap", tapCabinet)

	local desk = display.newRect(display.contentCenterX - 155, display.contentCenterY + 150, 90, 60)
	-- 가위 획득 여부에 따른 책상 클릭 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapDesk( event )
		if flag == 0 then
			if flag_scissors == 0 then --가위 획득 안 함
				text.alpha = 0

				dialog_text.text = "가위? 이거면 위협은 되겠다. 가져가자."
				dialog.alpha = 1
				dialogButton.alpha = 1
				dialog_text.alpha = 1

				index = 3
			elseif flag_scissors == 1 then
				index = 4
			end

			background.fill = {
				type = "image",
				filename = Data[index].image
			}

			if index == 3 then
				flag = 1
			end
			timer.performWithDelay( 500, function()
									flag = 0
		 							end )
		end
	end
	desk:addEventListener("tap", tapDesk)

	local scissors = display.newRect(display.contentCenterX - 180, display.contentCenterY - 20, 430, 335)
	-- 가위 클릭 시 장면 전환 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapScissors( event )
		if flag == 0 and index == 3 then
			dialog_text.alpha = 0

			if flag_scissors == 0 then --가위 획득 안함
				--인벤토리에 가위 표시
					inventory_index = inventory_index + 1
					item_index = item_index + 1
					items[item_index] = display.newImage(itemGroup, "image/scissors.png")
					items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
					scissors_flag = 1
					inventoryGroup:insert(items[item_index])
					scissors_index = item_index
			end

			flag_scissors = 1
			index = 4
			background.fill = {
				type = "image",
				filename = Data[index].image
			}

			dialog.alpha = 1
			dialogButton.alpha = 1
			text.text = "[가위를 획득하였습니다.]"
			text.alpha = 1
		end
	end
	scissors:addEventListener("tap", tapScissors)

	backButton = display.newImage("image/back.png")
	backButton.x, backButton.y = display.contentWidth*0.5, display.contentHeight*0.94

	local function tapBackButton( event )
		if index == 3 then
			index = 1
		elseif index == 4 then
			index = 2
		elseif index == 1 or index == 2 then
			dialog.alpha = 0
			dialogButton.alpha = 0
			text.alpha = 0
			dialog_text.alpha = 0

			timer.cancel(timeAttack)
			time.alpha = 0

			composer.gotoScene("ff2.floor2")
		end

		background.fill = {
			type = "image",
			filename = Data[index].image
		}
	end
	backButton:addEventListener("tap", tapBackButton)

	dialog = display.newImage("image/dialog.png")
	dialog.x , dialog.y = display.contentWidth*0.5, display.contentHeight*0.9
	dialog.alpha = 0

	dialogButton = display.newImage("image/dialog_next.png")
	dialogButton.x , dialogButton.y = display.contentWidth*0.86, display.contentHeight*0.95
	dialogButton.alpha = 0

	local function tapDialogButton( event )
		flag = 0

		dialog.alpha = 0
		dialogButton.alpha = 0
		text.alpha = 0
		dialog_text.alpha = 0

		backButton.alpha = 1
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

	sceneGroup:insert(background)
	sceneGroup:insert(cabinet)
	sceneGroup:insert(desk)
	sceneGroup:insert(scissors)
	sceneGroup:insert(backButton)
	sceneGroup:insert(setting)
	sceneGroup:insert(dialog)
	sceneGroup:insert(dialogButton)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	cabinet:toBack()
	desk:toBack()
	scissors:toBack()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
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

		local stay_y = display.newRect(display.contentCenterX + 180, display.contentCenterY + 273, 30, 30)
		local stay_n = display.newRect(display.contentCenterX + 237, display.contentCenterY + 273, 60, 30)
		
		-- 미술실 계속 있을지에 대한 이벤트 함수 -------------------------------------------------------------------------------------------
		local function tap_stayState( event )
			text.alpha = 0

			if event.target.x > stay_y.x - 10 and event.target.x < stay_y.x + 10 then --yes
				dialog_text.text = "줄어봐야 고작 5분 정도 줄었겠지. 일단 뭐라도 찾아야 돼. 싸워서라도 이겨야하니까...\n미술실에는 무슨 도구라도 있겠지."
		 		dialog.alpha = 1
		 		dialogButton.alpha = 1
		 		dialog_text.alpha = 1

		 		composer.setVariable("stay", "yes")
			elseif event.target.x > stay_n.x - 10 and event.target.x < stay_n.x + 10 then --no
				dialog.alpha = 0
				dialogButton.alpha = 0
				dialog_text.alpha = 0

				timer.cancel(timeAttack)
				composer.setVariable("stay", "no")

				composer.gotoScene("ff2.floor2")
			end
		end
		stay_y:addEventListener("tap", tap_stayState)
		stay_n:addEventListener("tap", tap_stayState)

		local function decreaseTime()
			playTime.text = playTime.text - 300
			count = count - 300
			dialog_text.alpha = 0

			text.text = "[시간이 감소하였습니다. 계속 머무르시겠습니까?]   네 / 아니오"
			dialog.alpha = 1
			text.alpha = 1

			dialogButton.alpha = 0
			backButton.alpha = 0

			flag = 1
		end
		decreaseTime()

		time = display.newText(5, display.contentWidth*0.23, display.contentHeight*0.1)
		time.size = 20
		time:setFillColor(1)

		local function fiveMinute_counter ( event )
			time.text = time.text - 1

	 		if time.text == '0' then
	 			playTime.text = playTime.text / 2
	 			count = count / 2
	 			dialog_text.alpha = 0

	 			text.text = "[시간이 감소하였습니다.]"
	 			dialog.alpha = 1
	 			dialogButton.alpha = 1
	 			text.alpha = 1

				backButton.alpha = 1
	 			composer.setVariable("timeDecrease", "true")
	 		end
	 	end
	 	timeAttack = timer.performWithDelay(60000, fiveMinute_counter, 5)

		sceneGroup:insert(time)
		sceneGroup:insert(stay_y)
		sceneGroup:insert(stay_n)
		sceneGroup:insert(inven_bg)
		sceneGroup:insert(inventoryGroup)
		sceneGroup:insert(setting)

		time:toBack()
		stay_y:toBack()
		stay_n:toBack()
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

		-- 캐비넷 숨은 여부
		composer.setVariable("killer_stop", killer_stop)
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
