-----------------------------------------------------------------------------------------
--
-- HealthRoom.lua  보건실 잠긴 문
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImage("ff1/image2/Health/Door.jpg", display.contentWidth/2, display.contentHeight/2)

	local lock = display.newImage("ff1/image2/Health/Lock.jpg", display.contentWidth/2, display.contentHeight/2)
	lock.alpha = 0

	local open = display.newImage("ff1/image2/Health/Open.jpg", display.contentWidth/2, display.contentHeight/2)
	open.alpha = 0



	local sparkle = display.newImage("ff1/image2/Health/Sparkle.png")
	sparkle.x, sparkle.y = display.contentWidth*0.75, display.contentHeight*0.1
	sparkle.alpha = 0

	--뒤로가는 버튼
	local back = display.newImage("ff1/image2/back.png")
	back.x, back.y = display.contentWidth*0.5, display.contentHeight*0.94
	back.alpha = 0

	--문 터치를 위한 임시 오브젝트
	local door = display.newRect(display.contentWidth*0.448, display.contentHeight*0.5, 315, 550)
	door.alpha = 0.01


	--텍스트 바
	local textbar = display.newImage("ff1/image2/textbar.png",display.contentWidth/2, display.contentHeight*0.9)
	textbar.alpha = 0

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 0

	local text = display.newText("문이 잠겨있습니다. 자신의 눈썹을 자신은 볼 수 없습니다.", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 0

	local text2 = display.newText("문이 잠겨있어.. 이건 무슨 말이지\n열쇠를 찾아봐야겠어", display.contentWidth*0.5, display.contentHeight*0.88)
	text2.size = 25
	text2:setFillColor(1)
	text2.alpha = 0


	--혼잣말 뒤
	local next_button2 = display.newImage("ff1/image2/next.png")
	next_button2.x, next_button2.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button2.alpha = 1



	--들어오자마자 보이는 텍스트 바
	local textbar1 = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)
	textbar1.alpha = 1

	--텍스트 바 안에 있는 다음 버튼
	local next_button1 = display.newImage("ff1/image2/next.png")
	next_button1.x, next_button1.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button1.alpha = 1

	local text1 = display.newText("보건실은 침대가 있으니까 숨을 수 있지 않을까..", display.contentWidth*0.5, display.contentHeight*0.88)
	text1.size = 25
	text1:setFillColor(1)
	text1.alpha = 1

	--처음 대사 일회성(열쇠를 획득한 뒤에는 보이지 않음)
	if(item_key == 1) then
		text1.alpha = 0
		textbar1.alpha = 0
		next_button1.alpha = 0
		next_button2.alpha = 0
		door.alpha = 0.01
	end

	--스파클 터치하면 키화면으로 넘어가기
	local function tapSparkle( event )
		sparkle.alpha = 0
		door.alpha = 0
		back.alpha = 0
		-- composer.hideOverlay("ff1.HealthRoom")
		-- composer.showOverlay("ff1.HealthKey")
		composer.gotoScene("ff1.HealthKey")
	end

	if(health_key == 1)then
		door.alpha = 0.01
	end

	local function tapDoor( event )
		if(item_key == 1) then
			print("열쇠있음")
			door.alpha = 0
			bg.alpha = 0
			lock.alpha = 1
		else
			print("열쇠없음")
			back.alpha = 0
			textbar.alpha = 1
			text.alpha = 1
			next_button.alpha = 1
			door.alpha = 0
		end
		print("문터치")
	end

	local function tapLock( event )
		lock.alpha = 0
		open.alpha = 1
	end

	local  function tapOpen( event )
		open.alpha = 0
		composer.hideOverlay("ff1.HealthRoom")
		composer.showOverlay("ff1.HealthRoom_inside")
		print("안으로 이동")
		composer.gotoScene("ff1.HealthRoom_inside")
	end

	local function tapNext( event )
		next_button.alpha = 0
		next_button2.alpha = 1
		text.alpha = 0
		text2.alpha = 1
	end

	local function tapNext2( event )
		next_button2.alpha = 0
		back.alpha = 1
		sparkle.alpha = 1
		text2.alpha = 0
		textbar.alpha = 0
		door.alpha = 0.01
	end

	--처음 다음버튼
	local function tapNext1( event )
		textbar1.alpha = 0
		text1.alpha = 0
		next_button1.alpha = 0
		back.alpha = 1
		door.alpha = 0.01
	end

	local function tapBack( event )
		sparkle.alpha = 0
		door.alpha = 0
		back.alpha = 0
		composer.gotoScene("ff1.view2")
	end

	sparkle:addEventListener("tap", tapSparkle)
	next_button:addEventListener("tap", tapNext)
	next_button1:addEventListener("tap", tapNext1)
	next_button2:addEventListener("tap", tapNext2)
	door:addEventListener("tap", tapDoor)
	back:addEventListener("tap",tapBack)
	lock:addEventListener("tap", tapLock)
	open:addEventListener("tap", tapOpen)

	sceneGroup:insert(bg)
	sceneGroup:insert(back)
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