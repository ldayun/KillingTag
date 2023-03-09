-----------------------------------------------------------------------------------------
--
-- view2.lua
-- 복도 두번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view

	item_key = 0
	
	--display

	local background = display.newImageRect("image/background/bg2.png", display.contentWidth, display.contentHeight)
		background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	local left = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	local right = display.newImage("image/UI/right.png", display.contentWidth*0.86, display.contentHeight*0.5)

	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	-- local box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.865)

	-- local nextKey = display.newImage("image/UI/next.png", display.contentWidth*0.83, display.contentHeight*0.95)

	right:toFront()

	--event-----------------------------------------------------------------
	function left:tap( event )
		print("1로이동")
		composer.gotoScene("ff1.view1")
	end
	left:addEventListener("tap", left)

	function right:tap( event )
		print("3으로이동")
		if(keyring_flag == 1) then
			composer.gotoScene("ff1.view3_2")
		else
			composer.gotoScene("ff1.view3")
		end
		-- body
	end
	right:addEventListener("tap", right)

	function gotoTeacherRoom( event )
		if (event.x >= 634 and event.x <= 735 and event.y >= 250 and event.y <= 520) then
			composer.gotoScene("ff1.teacherRoom")
		end
	end
	self.view:addEventListener("tap", gotoTeacherRoom)

	function gotoHealth( event )
		-- body
		if (event.x >= 90 and event.x <= 207 and event.y >= 275 and event.y <= 530) then
			composer.gotoScene("ff1.HealthRoom") -- 보건실로이동
		end
	end
	self.view:addEventListener("tap", gotoHealth)
	
	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(setting)

	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)

	inven_bg:toFront()
	inventoryGroup:toFront()
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
		composer.removeScene('ff1.view2')
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
