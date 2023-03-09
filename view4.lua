-----------------------------------------------------------------------------------------
--
-- view4.lua
-- 복도 네번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/background/bg4.png", display.contentWidth*0.9, display.contentHeight)
		background.x, background.y = display.contentWidth*0.45, display.contentHeight/2
	
	local left = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	local right = display.newImage("image/UI/right.png", display.contentWidth*0.86, display.contentHeight*0.5)

	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	--텍스트 바 (음악실에서 아니오 눌렀을때 활성화)
	local textbar = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)
	textbar.alpha = 0

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 0

	local text = display.newText("후.. 무슨 교실 하나 들어왔다고 시간이 줄어드냐고..\n미친 주최자! 아오!!", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 0

	--음악실에서 아니오를 누르고 나왔을때

	right:toFront()

	--event-----------------------------------------------------------------

	if(music_q == 1) then
		textbar.alpha = 1
		text.alpha = 1
		next_button.alpha = 1
		music_q = 0
	end

	function tapNext( event )
		textbar:removeSelf()
		text:removeSelf()
		next_button:removeSelf()
	end
	next_button:addEventListener("tap", tapNext)

	function left:tap( event )
		print("3으로이동")
		if(getKeyring == 1) then
			composer.gotoScene("ff1.view3_2")
		else
			composer.gotoScene("ff1.view3")
		end
	end
	left:addEventListener("tap", left)

	function right:tap( event )
		print("5으로이동")
		composer.gotoScene("ff1.view5")
		-- body
	end
	right:addEventListener("tap", right)


	function locked ( event )
		-- body
		if (event.x >= 63 and event.x <= 290 and event.y >=230 and event.y <=520) then
			print("잠겨있음(가사실)")
			composer.showOverlay('ff1.locked')
		end
		if (event.x >= 660 and event.x <=765 and event.y >=300 and event.y <= 525) then
			print("잠겨있음(가사실)")
			composer.showOverlay('ff1.locked')
		end
	end
	self.view:addEventListener("tap", locked)

	function gotoMusic( event )
		if (event.x >= 904 and event.x <= 1059 and event.y >= 265 and event.y <= 526) then
			print("음악실로 이동")
			playTime.text = playTime.text - 300
			count = count - 300
			composer.gotoScene("ff1.MusicRoom")
		end
	end
	self.view:addEventListener("tap", gotoMusic)
	--json	
	

	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(setting)
	sceneGroup:insert(textbar)
	sceneGroup:insert(text)
	sceneGroup:insert(next_button)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	inven_bg:toFront()
	inventoryGroup:toFront()
	right:toFront()
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
		composer.removeScene("ff1.view4")
		inventoryGroup.y = 0
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
