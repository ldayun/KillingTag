-----------------------------------------------------------------------------------------
--
-- cabinet_get.lua
-- 캐비닛에서 무기 획득 시 열릴 파일 
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	--display
	local background = display.newImageRect("image/P.E/cabinet_get.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--방향키
	local back = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight/2)

	--설정
	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	local box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.9)

	local content_cabinet_get = display.newText("자기 보호용이다..보호용...", display.contentWidth*0.5, display.contentHeight*0.88)
	content_cabinet_get.size = 25

	----------------------------------event
	function back:tap( event )
		print("준비실로 다시가기 캐비넷바이")
		print(weapon_flag)
		composer.gotoScene("ff1.PE")
	end
	back:addEventListener("tap", back)

	sceneGroup:insert(background)
	sceneGroup:insert(back)
	sceneGroup:insert(setting)
	sceneGroup:insert(box)
	sceneGroup:insert(content_cabinet_get)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	sceneGroup:insert(itemGroup)

	itemGroup:toFront()
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
		weapon_flag = 1
		timer.cancel("cctv_timer")
		composer.removeScene("ff1.cabinet_get")
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