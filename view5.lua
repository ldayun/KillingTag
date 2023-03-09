-----------------------------------------------------------------------------------------
--
-- view5.lua
-- 복도 다섯번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/background/bg5.png", display.contentWidth, display.contentHeight)
		background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	local left = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	local right = display.newImage("image/UI/right.png", display.contentWidth*0.86, display.contentHeight*0.5)

	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	local box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.9)
	box.alpha = 0

	local nextKey = display.newImage("image/UI/next.png", display.contentWidth*0.86, display.contentHeight*0.95)
	nextKey.alpha = 0

	local content = display.newText("대사", display.contentWidth*0.5, display.contentHeight*0.88)
	content.size = 25
    content.alpha = 0

	right:toFront()

	--event-----------------------------------------------------------------
	function left:tap( event )
		print("4으로이동")
		composer.gotoScene("ff1.view4")
	end
	left:addEventListener("tap", left)

	function locked ( event )
		-- body
		if (event.x >= 815 and event.x <= 1020 and event.y >= 170 and event.y <=530) then
			if (PE_key_flag == 0) then
				print("잠겨있음(체육준비실)")
				composer.showOverlay('ff1.locked')
				content.text = "잠겨있네... 열쇠를 어디서 얻어야 하지?"
				box.alpha = 1
				nextKey.alpha = 1
				content.alpha = 1
			elseif (PE_key_flag) then
				composer.gotoScene("ff1.PE")
			end
		end
		if (event.x >= 530 and event.x <= 630 and event.y >= 320 and event.y <= 480) then
			print("잠겨있음(별관통로)")
			composer.showOverlay('ff1.locked')
		end
	end
	self.view:addEventListener("tap", locked)

	function tapNext( event )
		-- body
		box.alpha = 0
		nextKey.alpha = 0
		content.alpha = 0
	end
	nextKey:addEventListener("tap", tapNext)
	--json	
	
	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(setting)
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
		composer.removeScene("ff1.view5")
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
