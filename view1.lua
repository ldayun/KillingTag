-----------------------------------------------------------------------------------------
--
-- view1.lua
-- 복도 제일 왼쪽 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )
local backSound = audio.loadStream( "music/gameplay.mp3" )
audio.play(backSound, {loops = -1})

playTime = display.newText(3600, display.contentWidth*0.9, display.contentHeight*0.15)

playTime.size = 100
playTime:setFillColor(0)
playTime.alpha = 0

count = 3600
setting.alpha = 1
function counter ( event )
	playTime.text = playTime.text - 1
	count = count - 1
	print(playTime.text, count)
	playTimeText.text = "제한 시간이 " ..math.floor(count/60) .. "분" .. math.floor(count%60) .."초 남았습니다."

	if (count < 300 and count > 0 and studio_flag ~= 1) then
		end_text.text = "[종료되었습니다.]"
   		end_dialog.alpha = 1
   		end_dialogButton.alpha = 1
   		end_text.alpha = 1

   		--살인마 속도, 발걸음 소리 1.5배 sound play
   		sound_speedUp_in = audio.play(sound_speedUp, {loops = -1})
   	end

	if (count < -1) then
		if count_flag == 1 then
			print("게임 오버")
			end_dialog.alpha = 0
   			end_dialogButton.alpha = 0
   			end_text.alpha = 0
			count_flag = 0
	   		-- 기존 음악들 제거
	   		audio.stop(backSound)
	   		-- badEnding sound play
	   		audio.play(sound_badEnding, {loops = 0})
	   		composer.gotoScene("ff2.gameOver")
	   	end
	end
end

timeAttack_play = timer.performWithDelay(1000, counter, 3601, "playTimeAttack")

function scene:create( event )
	local sceneGroup = self.view
	--인벤토리 보이게
	inven_bg.alpha = 0.5
	for i = 1, 13 do
		inventory[i].alpha = 1
	end
	
	--display

	local background = display.newImageRect("image/background/bg1.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--방향키
	local left = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	local right = display.newImage("image/UI/right.png", display.contentWidth*0.86, display.contentHeight*0.5)

	--설정
	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	-- time = display.newText(3600, display.contentWidth*0.9, display.contentHeight*0.15)

	-- time.size = 100
	-- time:setFillColor(0)
	-- time.alpha = 0

	local box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.9)
	box.alpha = 0
	local content = display.newText("1층 대사", display.contentWidth*0.5, display.contentHeight*0.88)
	content.size = 25
    content.alpha = 0
    local nextKey_hall = display.newImage("image/UI/next.png", display.contentWidth*0.86, display.contentHeight*0.95)
	nextKey_hall.alpha = 0

	local Data = jsonParse("json/text_hall.json")
	if Data then
		print(Data[1].dialog)
	end

	local index = 0

	local function nextScript( event )
		if(view1_flag == 0) then
			index = index + 1
 			if(index > #Data) then 
 				view1_flag = 1
 				box.alpha = 0
 				nextKey_hall.alpha = 0
 				content.alpha = 0
		 	end
		 	if (index <= #Data) then
		 		box.alpha = 1
		 		nextKey_hall.alpha = 1
		 		content.text = Data[index].content
		 		content.alpha = 1
		 	end
		end
	end
	nextKey_hall:addEventListener("tap", nextScript)
	nextScript()

	-- backButton 구현
	local backButton = display.newImage("image/back.png")
	backButton.x, backButton.y = display.contentWidth*0.5, display.contentHeight*0.94

	local function tapBackButton( event )
		box.alpha = 0
 		nextKey_hall.alpha = 0
 		content.alpha = 0

		composer.gotoScene("ff1.gate")
	end
	backButton:addEventListener("tap", tapBackButton)

	function right:tap( event )
		-- body
		print("2로이동")
		composer.gotoScene('ff1.view2')
	end
	right:addEventListener("tap", right)
	
	function gotoAdOffice( event )
		if (event.x >= 394 and event.x <= 445 and event.y >=274 and event.y <= 522) then
			composer.gotoScene("ff1.adm")
		end
	end
	self.view:addEventListener("tap", gotoAdOffice)

	-- function onMouseEvent( event )
	-- 	-- body
	-- 	print(event.x, event.y)
	-- end
	-- Runtime:addEventListener("mouse", onMouseEvent)

	local function locked ( event )
		-- body
		if (event.x >= 65 and event.x <=155 and event.y >=180 and event.y <=530) then
			print("잠겨있음(교장실)")
			composer.showOverlay('ff1.locked')
		end
	end
	self.view:addEventListener("tap", locked)


	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(setting)
	sceneGroup:insert(box)
	sceneGroup:insert(nextKey_hall)
	sceneGroup:insert(content)
	sceneGroup:insert(backButton)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	right:toFront()
	inven_bg:toFront()
	inventoryGroup:toFront()
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

				-- 기존 음악들 제거
				audio.pause( backSound )

				-- badEnding sound play
				audio.play(sound_badEnding, {loops = 0})

				composer.gotoScene("ff2.gameOver")
			end
		end
		timeAttack_adm = timer.performWithDelay(120000, cctv_twoMinute_counter, 1, "cctv_timer")
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
		timer.cancel("cctv_timer")
		composer.removeScene("ff1.view1")
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