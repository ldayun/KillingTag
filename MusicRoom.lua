-----------------------------------------------------------------------------------------
--
-- Musicroom.lua  보건실 잠긴 문
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/Music/Musicroom.jpg", display.contentWidth*0.9, display.contentHeight)
	bg.x, bg.y = display.contentWidth*0.45, display.contentHeight/2

	local bg1 = display.newImageRect("ff1/image2/Music/Mic.jpg", display.contentWidth*0.9, display.contentHeight)
	bg1.x, bg1.y = display.contentWidth*0.45, display.contentHeight/2

	local bg2 = display.newImageRect("ff1/image2/Music/Micget.jpg", display.contentWidth*0.9, display.contentHeight)
	bg2.x, bg2.y = display.contentWidth*0.45, display.contentHeight/2
	
	--복도로 가는 버튼
	local back = display.newImage("ff1/image2/back.png")
	back.x, back.y = display.contentWidth*0.5, display.contentHeight*0.94
	back.alpha = 0

	--음악실로 가는 버튼
	local back2 = display.newImage("ff1/image2/back.png")
	back2.x, back2.y = display.contentWidth*0.5, display.contentHeight*0.94
	back2.alpha = 0

	--bg1,bg2는 투명화
	bg1.alpha = 0
	bg2.alpha = 0


	--마이크 임시 오브젝트
	local mic_Close = display.newRect(display.contentWidth*0.15, display.contentHeight*0.46, 100, 120)
	mic_Close.alpha = 0

	--고장난 마이크 임시 오브젝트
	local mic_2 = display.newRect(display.contentWidth*0.6, display.contentHeight*0.46, 160, 320)
	mic_2.alpha = 0


	--텍스트 바
	local textbar = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)

	--텍스트 바 안에 있는 yes 버튼
	local yes = display.newImage("ff1/image2/yes.png")
	yes.x, yes.y = display.contentWidth*0.75, display.contentHeight*0.95

	--텍스트 바 안에 있는 yes 버튼
	local no = display.newImage("ff1/image2/no.png")
	no.x, no.y = display.contentWidth*0.85, display.contentHeight*0.95

	local text = display.newText("시간이 감소하였습니다. 계속 머무르시겠습니까?", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1, 0, 0)


	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 0

	local text2 = display.newText("고장난 마이크를 획득하였습니다.", display.contentWidth*0.5, display.contentHeight*0.88)
	text2.size = 25
	text2:setFillColor(1)
	text2.alpha = 0

	--안나갔을때의 문구
	local text3 = display.newText("빨리 둘러보고 나가자..\n다음 번에 안 들어오려면 대충이라도 보고 나가야..", display.contentWidth*0.5, display.contentHeight*0.88)
	text3.size = 25
	text3:setFillColor(1)
	text3.alpha = 0

	--안나갔을때 다음 버튼
	local next_button2 = display.newImage("ff1/image2/next.png")
	next_button2.x, next_button2.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button2.alpha = 0

	--책상 위 마이크 터치
	local function tapMic( event )
		bg.alpha = 0
		bg1.alpha = 1
		mic_Close.alpha = 0
		mic_2.alpha = 0.01
		back.alpha = 0
		back2.alpha = 1
	end

	--(확대)책상 위 유선마이크 터치
	local function tapMic_1( event )
		bg.alpha = 0
		bg1.alpha = 1
		mic_Close.alpha = 0
	end

	--(확대)책상 위 고장난 마이크 터치
	local function tapMic_2( event )
		bg1.alpha = 0
		bg2.alpha = 1
		textbar.alpha = 1
		text2.alpha = 1
		next_button.alpha = 1
		mic_2.alpha = 0
		--인벤토리에 마이크모양 표시
		-- item[3] = display.newImage(content, "ff1/image2/mic.png")
		-- item[3].x, item[3].y = display.contentWidth*0.948, display.contentHeight*(0.1 + 0.175 * ( 3 - 1))
		item_mic = 1

		print("획득")
		inventory_index = inventory_index + 1
		item_index = item_index + 1
		-- inventory[inventory_index] = display.newImage(inventoryGroup, "image/P.E/weapon.png")
		-- inventory[inventory_index].x, inventory[inventory_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (inventory_index-1)*130
		-- print(inventory_index)
		items[item_index] = display.newImage(itemGroup, "image/mike.png")
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		mic_flag = 1
		inventoryGroup:insert(items[item_index])
		mic_index = item_index
	end

	local function tapYes( event )
		textbar.alpha = 1
		text3.alpha = 1
		text.alpha = 0
		next_button2.alpha = 1
		mic_Close.alpha = 0.01
		yes.alpha = 0
		no.alpha = 0
	end

	local function tapNo( event )
		--음악실에서 나가기를 눌렀을 때
		music_q = 1
		composer.gotoScene("ff1.view4")
	end

	local function tapNext( event )
		textbar.alpha = 0
		text2.alpha = 0
		next_button.alpha = 0
		text.alpha = 0
	end

	local function tapNext2( event )
		textbar.alpha = 0
		text3.alpha = 0
		next_button2.alpha = 0
		back.alpha = 1
	end

	local function tapBack( event )
		composer.gotoScene("ff1.view4")
	end

	local function tapBack2( event )
		back2.alpha = 0
		bg.alpha = 1
		bg1.alpha = 0
		bg2.alpha = 0
		back.alpha = 1
	end
	
	local time = display.newText(5, display.contentWidth/2, display.contentHeight/2)
	time:setFillColor(1)
	time.alpha = 0

	local function fiveMinute_counter ( event )
		time.text = time.text - 1
	 	if time.text == '0' then
	 		playTime.text = playTime.text / 2
	 		count = count / 2

			text.text = "[시간이 감소하였습니다.]"
 			textbar.alpha = 1
 			next_button.alpha = 1
 			text.alpha = 1
	 	end
	 end
	timeAttack = timer.performWithDelay(60000, fiveMinute_counter, 5)

	mic_Close:addEventListener("tap", tapMic)
	mic_2:addEventListener("tap",tapMic_2)
	yes:addEventListener("tap", tapYes)
	no:addEventListener("tap",tapNo)
	next_button:addEventListener("tap",tapNext)
	next_button2:addEventListener("tap",tapNext2)
	back:addEventListener("tap", tapBack)
	back2:addEventListener("tap", tapBack2)

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(bg2)
	sceneGroup:insert(back)
	sceneGroup:insert(back2)
	sceneGroup:insert(textbar)
	sceneGroup:insert(yes)
	sceneGroup:insert(no)
	sceneGroup:insert(text)
	sceneGroup:insert(next_button)
	sceneGroup:insert(text2)
	sceneGroup:insert(text3)
	sceneGroup:insert(next_button2)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
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
		composer.removeScene("ff1.MusicRoom")
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