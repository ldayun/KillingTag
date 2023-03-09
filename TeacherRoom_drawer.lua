-----------------------------------------------------------------------------------------
--
-- Teacheroom.lua  1층 교무실 책장
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/Drawer.jpg", display.contentWidth*0.9, display.contentHeight)
	bg.x, bg.y = display.contentWidth*0.45, display.contentHeight/2

	local bg1 = display.newImageRect("ff1/image2/Drawer_keyget.jpg", display.contentWidth*0.9, display.contentHeight)
	bg1.x, bg1.y = display.contentWidth*0.45, display.contentHeight/2
	bg1.alpha = 0



	--체육쌤자리로 가는 버튼
	local button_right = display.newImage("ff1/image2/Button_right.png")
	button_right.x, button_right.y = display.contentWidth*0.86, display.contentHeight*0.5
	button_right.alpha = 0



	--복도로 가는 버튼
	local back = display.newImage("ff1/image2/back.png")
	back.x, back.y = display.contentWidth*0.5, display.contentHeight*0.94
	back.alpha = 0


	--체육쌤 책상으로 가는 버튼
	local back2 = display.newImage("ff1/image2/back.png")
	back2.x, back2.y = display.contentWidth*0.5, display.contentHeight*0.94
	back2.alpha = 0




	-- --열쇠 임시 오브젝트
	-- local key = display.newRect(display.contentWidth*0.27, display.contentHeight*0.11, 70, 20)
	-- key.alpha = 0.01

	back.alpha = 1
	button_right.alpha = 1

	if(item_schoolgate_key == 1)then
		key.alpha = 0
		bg.alpha = 0
		bg1.alpha = 1
	end

	local function tapBack( event )
		back.alpha = 0
		composer.gotoScene("ff1.view2")
	end


	local function tapRight( event )
		composer.gotoScene("ff1.teacherRoom")
	end

	local function tapKey( event )
		if(event.x >= 312 and event.x <= 374 and event.y >= 76 and event.y <= 86) then
			bg.alpha = 0
			bg1.alpha = 1
			composer.gotoScene("ff1.Drawer_closeup")
		end
	end
	self.view:addEventListener("tap", tapKey)

	back:addEventListener("tap", tapBack)
	button_right:addEventListener("tap", tapRight)

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(button_right)
	sceneGroup:insert(back)
	sceneGroup:insert(back2)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
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

				-- 기존 음악들 제거
				audio.pause( backSound )

				-- badEnding sound play
				audio.play(sound_badEnding, {loops = 0})

				composer.gotoScene("ff2.gameOver")
			end
		end
		timeAttack_adm = timer.performWithDelay(120000, cctv_twoMinute_counter, 1, "cctv_timer")
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