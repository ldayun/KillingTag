-----------------------------------------------------------------------------------------
--
-- view3.lua
-- 복도 세번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

audio.play(backSound, {loops = -1})

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/F1_keyring.jpg", display.contentWidth, display.contentHeight)
		background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	local left = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	local right = display.newImage("image/UI/right.png", display.contentWidth*0.86, display.contentHeight*0.5)

	local up = display.newImage("image/UI/up.png", display.contentWidth*0.45, display.contentHeight*0.2)

	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	local keyring = display.newCircle(560, 600, 20)


	--event-----------------------------------------------------------------
	function left:tap( event )
		print("2로이동")
		composer.gotoScene("ff1.view2")
	end
	left:addEventListener("tap", left)

	function right:tap( event )
		print("4으로이동")
		composer.gotoScene("ff1.view4")
		-- body
	end
	right:addEventListener("tap", right)

	function up:tap( event )
		print("2층으로 이동")
		composer.gotoScene("ff2.floor2")
	end
	up:addEventListener("tap", up)
	
	function keyring:tap(event)
		print("키링 tab")
		-- 키링 확대로 이동
		if keyring_flag == 0 then
			composer.gotoScene("ff1.keyring_zoomin")
		else
			composer.gotoScene("ff1.keyring_empty")
		end
	end
	keyring:addEventListener("tap", keyring)


	--json	

	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(up)
	sceneGroup:insert(setting)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	sceneGroup:insert(keyring)
	-- sceneGroup:insert(inven_bg)
	-- sceneGroup:insert(inventoryGroup)
	right:toFront()
	keyring:toBack()

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

	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		timer.cancel("cctv_timer")
		composer.removeScene("ff1.view3")
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
