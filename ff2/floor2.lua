-----------------------------------------------------------------------------------------
--
-- floor2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local index = 3
local firstTag = 1
local flag = 0
local studio_flag -- 0: studio에서 트리거 제거 실패
local artRoom_flag = 0 --artRoom 안 들어감
local timeAttack_flag = 0 --timeAttack 진행 중 아님

local dialog, dialogButton, text, dialogText

local time2, timeAttack2
local emergency, killer, killer_text

local counter, timeAttack_adm

-- 살인마 속도, 발걸음 소리 1.5배 sound
local sound_speedUp = audio.loadStream( "music/killer_run_sound.flac" )
local sound_speedUp_in
-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/floor2_3.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local Data = jsonParse("json/background.json")

	--scene1
	local close_door_group = display.newGroup()
	local close_door = {} --문 위치
	close_door[1] = display.newRect(close_door_group, display.contentCenterX + 193, display.contentCenterY + 25, 10, 200)
	close_door[2] = display.newRect(close_door_group, display.contentCenterX + 156, display.contentCenterY + 34, 15, 225)
	close_door[3] = display.newRect(close_door_group, display.contentCenterX + 130, display.contentCenterY + 38, 16, 245)
	close_door[4] = display.newRect(close_door_group, display.contentCenterX + 53, display.contentCenterY + 47, 30, 305)
	close_door[5] = display.newRect(close_door_group, display.contentCenterX, display.contentCenterY + 58, 25, 350)
	close_door[6] = display.newRect(close_door_group, display.contentCenterX - 135, display.contentCenterY + 77, 51, 450)
	--scene2
	close_door[7] = display.newRect(close_door_group, display.contentCenterX + 201, display.contentCenterY + 31, 100, 293)
	close_door[8] = display.newRect(close_door_group, display.contentCenterX + 339, display.contentCenterY + 33, 110, 320)
	close_door[9] = display.newRect(close_door_group, display.contentCenterX - 489, display.contentCenterY + 39, 120, 233)
	--scene3
	close_door[10] = display.newRect(close_door_group, display.contentCenterX - 552, display.contentCenterY + 70, 150, 310)
	close_door[11] = display.newRect(close_door_group, display.contentCenterX - 307, display.contentCenterY + 70, 155, 310)
	--scene4
	close_door[12] = display.newRect(close_door_group, display.contentCenterX + 75, display.contentCenterY + 45, 105, 210)
	close_door[13] = display.newRect(close_door_group, display.contentCenterX - 467, display.contentCenterY + 60, 245, 352)
	--scene5
	close_door[14] = display.newRect(close_door_group, display.contentCenterX + 290, display.contentCenterY + 93, 135, 535)
	close_door[15] = display.newRect(close_door_group, display.contentCenterX + 139, display.contentCenterY + 83, 50, 440)
	close_door[16] = display.newRect(close_door_group, display.contentCenterX + 5, display.contentCenterY + 60, 25, 350)
	close_door[17] = display.newRect(close_door_group, display.contentCenterX - 50, display.contentCenterY + 55, 27, 310)
	close_door[18] = display.newRect(close_door_group, display.contentCenterX - 125, display.contentCenterY + 35, 17, 250)
	close_door[19] = display.newRect(close_door_group, display.contentCenterX - 151, display.contentCenterY + 33, 15, 230)
	close_door[20] = display.newRect(close_door_group, display.contentCenterX - 187, display.contentCenterY + 25, 13, 202)

	local studio_close_door = display.newRect(display.contentCenterX + 45, display.contentCenterY + 33, 107, 270) --studio 문 위치
	local dialogButton_flag = 0 --0: 다음 대화 없음
	-- studio 문 잠김 이벤트 힘수 -------------------------------------------------------------------------------------------
	local function tapStudioCloseDoor( event )
		dialogText.alpha = 0

		if index == 2 then
			composer.showOverlay("locked")

			dialogButton_flag = 1
			text.text = "[3학년 8반으로 가십시오.]"

			dialog.alpha = 1
			dialogButton.alpha = 1
			text.alpha = 1
		end
		--키 있을 경우 방송실로 이동
		if mediaKey_flag == 1 then
			composer.gotoScene("ff2.studio")
		end
	end
	studio_close_door:addEventListener("tap", tapStudioCloseDoor)

	local function tapCloseDoor( event )
		if flag == 0 then
			composer.showOverlay("locked")
		end
	end

	-- 문 잠김 이벤트 함수 설정하는 함수 -------------------------------------------------------------------------------------------
	local function closeDoorEvent()
		if index == 1 then
			for i = 1, 6 do
				close_door[i]:addEventListener("tap", tapCloseDoor)
			end
			for i = 7, 20 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
		elseif index == 2 then
			for i = 7, 9 do
				close_door[i]:addEventListener("tap", tapCloseDoor)
			end
			for i = 1, 6 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
			for i = 10, 20 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
		elseif index == 3 then
			for i = 10, 11 do
				close_door[i]:addEventListener("tap", tapCloseDoor)
			end
			for i = 1, 9 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
			for i = 12, 20 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
		elseif index == 4 then
			for i = 12, 13 do
				close_door[i]:addEventListener("tap", tapCloseDoor)
			end
			for i = 1, 11 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
			for i = 14, 20 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
		elseif index == 5 then
			for i = 14, 20 do
				close_door[i]:addEventListener("tap", tapCloseDoor)
			end
			for i = 1, 13 do
				close_door[i]:removeEventListener("tap", tapCloseDoor)
			end
		end
	end
	closeDoorEvent()

	local artRoom_door = display.newRect(display.contentCenterX + 453, display.contentCenterY + 70, 120, 270)
	-- artRoom 탭 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapArtRoomDoor( event )
		if index == 4 and flag == 0 then
			dialog.alpha = 0
			dialogButton.alpha = 0
			text.alpha = 0
			dialogText.alpha = 0

			if timeAttack2 ~= nil then
		 		timer.pause(timeAttack2)
		 	end
			emergency.alpha = 0
			killer.alpha = 0
			killer_text.alpha = 0

			artRoom_flag = 1
			composer.gotoScene("ff2.artRoom")
		end
	end
	artRoom_door:addEventListener("tap", tapArtRoomDoor)

	local leftButton = display.newImage("image/left.png")
	leftButton.x, leftButton.y = display.contentWidth*0.04, display.contentHeight*0.5

	local rightButton = display.newImage("image/right.png")
	rightButton.x, rightButton.y = display.contentWidth*0.86, display.contentHeight*0.5

	local upButton = display.newImage("image/up.png")
	upButton.x, upButton.y = display.contentWidth*0.45, display.contentHeight*0.2

	local downButton = display.newImage("image/down.png")
	downButton.x, downButton.y = display.contentWidth*0.6, display.contentHeight*0.7

	-- 인형키링 타이머 설정 작업
	time2 = display.newText(50, display.contentWidth*0.23, display.contentHeight*0.1) --15초
	time2.size = 20
	time2:setFillColor(1)

	emergency = display.newImage("image/emergency.png")
	emergency.x, emergency.y = display.contentWidth*0.5, display.contentHeight*0.5
	emergency.alpha = 0

	killer = display.newImage("image/killer.png")
	killer.x, killer.y = display.contentWidth*0.4, display.contentHeight*0.5
	killer.alpha = 0

	killer_text = display.newText(0, display.contentWidth*0.5, display.contentHeight*0.5)
	killer_text.size = 40
	killer_text:setFillColor(1, 0, 0)
	killer_text.text = "살인마를 피해 옆으로 빠르게 이동하라!"
	killer_text.alpha = 0

	local function counter2 ( event )
		time2.text = time2.text - 1

		if emergency.alpha == 0 then
			emergency.alpha = 1
			killer.y = display.contentHeight*0.6
			killer_text.alpha = 0
		else
			emergency.alpha = 0
			killer.y = display.contentHeight*0.5
			killer_text.alpha = 1
		end

		killer:scale(1.01, 1.01)


	 	if time2.text == '0' then
	 		emergency.alpha = 0
	 		killer.alpha = 0
	 		killer_text.alpha = 0

			if bandage_flag == 1 then --붕대있음
		  		bandage_flag = 0
		 	 	composer.showOverlay("ff2.heal_question")
		  	else
				-- 1시간짜리 타이머 제거 timer.cancel(timeAttack)
				--timer.pause(timeAttack)

			  	-- 기존 음악들 제거
			  	if sound_speedUp_in ~= nil then
   					audio.stop(sound_speedUp_in)
   				end

		   		-- badEnding sound play
		   		audio.play(sound_badEnding, {loops = 0})
				composer.gotoScene("ff2.gameOver")
		  	end
		end
	end

	-- 왼쪽, 오른쪽 방향키 작동 이벤트 함수 -------------------------------------------------------------------------------------------
	local function tapLeftButton( event )
		if index < 5 then
			index = index + 1
		end
		background.fill = {
			type = "image",
			filename = Data[index].image
		}

		if index == 3 then
			upButton.alpha = 1
			downButton.alpha = 1
		else
			upButton.alpha = 0
			downButton.alpha = 0
		end

		-- 인형키링이 있을 때 --------------------------------
		if index == 4 and timeAttack_flag == 0 then
			if keyring_flag == 1 then
				text.alpha = 0

				text.text = "[술래잡기를 시작합니다.]"
				dialog.alpha = 1
				dialogButton.alpha = 1
				text.alpha = 1

				killer.alpha = 1
				timeAttack_flag = 1

				timeAttack2 = timer.performWithDelay(300, counter2, 50)
			end
		end

		closeDoorEvent()

		if index == 3 or index == 4 then
			flag = 1
		end
		timer.performWithDelay( 500, function()
	 			    			flag = 0
	 							end )
	end
	local function tapRightButton( event )
		if index > 1 then
			index = index - 1
		end
		background.fill = {
			type = "image",
			filename = Data[index].image
		}

		if index == 3 then
			upButton.alpha = 1
			downButton.alpha = 1
		else
			upButton.alpha = 0
			downButton.alpha = 0
		end

		closeDoorEvent()

		if index == 4 then
			flag = 1
		end
		timer.performWithDelay( 500, function()
	 			    			flag = 0
	 							end )
	end
	leftButton:addEventListener("tap", tapLeftButton)
	rightButton:addEventListener("tap", tapRightButton)

	local function tapUpButton( event )
		composer.gotoScene("ff3.viewK")
	end
	upButton:addEventListener("tap", tapUpButton)

	local function tapDownButton( event )
		-- body
		print("1층으로")
		if(keyring_flag == 1) then
			composer.gotoScene("ff1.view3_2")
		else
			composer.gotoScene("ff1.view3")
		end
	end 
	downButton:addEventListener("tap", tapDownButton)

	dialog = display.newImage("image/dialog.png")
	dialog.x , dialog.y = display.contentWidth*0.5, display.contentHeight*0.9
	dialog.alpha = 0

	dialogButton = display.newImage("image/dialog_next.png")
	dialogButton.x , dialogButton.y = display.contentWidth*0.86, display.contentHeight*0.95
	dialogButton.alpha = 0

	local function tapDialogButton( event )
		text.alpha = 0

		if dialogButton_flag == 1 then
			dialogText.text = "문이 잠겨있어.. 열쇠를 찾고 와야겠네."
			dialogText.alpha = 1

			dialogButton_flag = 0
		else
			dialog.alpha = 0
			dialogButton.alpha = 0
			dialogText.alpha = 0
		end
	end
	dialogButton:addEventListener("tap", tapDialogButton)

	text = display.newText(0, display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 0

	dialogText = display.newText(0, display.contentWidth*0.5, display.contentHeight*0.88)
	dialogText.size = 25
	dialogText:setFillColor(1)
	dialogText.alpha = 0

	sceneGroup:insert(background)
	sceneGroup:insert(time2)
	sceneGroup:insert(close_door_group)
	sceneGroup:insert(studio_close_door)
	sceneGroup:insert(artRoom_door)
	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(upButton)
	sceneGroup:insert(downButton)
	sceneGroup:insert(emergency)
	sceneGroup:insert(killer)
	sceneGroup:insert(killer_text)	
	sceneGroup:insert(setting)
	sceneGroup:insert(dialog)
	sceneGroup:insert(dialogButton)
	sceneGroup:insert(text)
	sceneGroup:insert(dialogText)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	close_door_group:toBack()
	studio_close_door:toBack()
	artRoom_door:toBack()
	time2:toBack()
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
		
		studio_flag = composer.getVariable("studio_flag") -- timer에서 쓰임

		local stay = composer.getVariable("stay") -- 미술실 y / n 대답
		if stay == "no" and artRoom_flag == 1 then
			dialog.alpha = 1
		 	dialogButton.alpha = 1
			text.text = "후우... 무슨 교실 하나 들어왔다고 시간이 주냐고... 미친 주최자! 아오!"
			text.alpha = 1

			artRoom_flag = 0
		end
		
		-- 캐비넷 숨은 여부 파악 -------------------------------------------------------------------------------------------
		local killer_stop = composer.getVariable("killer_stop")
		if killer_stop == "false" then
			if timeAttack2 ~= nil then
				killer.alpha = 1
				timer.resume(timeAttack2)
			end
		end

		sceneGroup:insert(inven_bg)
		sceneGroup:insert(inventoryGroup)

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
		timer.cancel("cctv_timer")
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

		-- content.y = 0
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
