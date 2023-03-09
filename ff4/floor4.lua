-----------------------------------------------------------------------------------------
--
-- floor4.lua (계단, 위아래 이동 가능 구역)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local timeAttack
local endingText


-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImage("image/stairs.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--양 옆 이동 
	local right = display.newImage("image/right.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	local left = display.newImage("image/left.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

	--계단 위 아래 층 이동
	local stairup = display.newImage("image/stairup.png")
	stairup.x, stairup.y =  display.contentWidth*0.45, display.contentHeight*0.2

	local stairdown = display.newImage("image/stairdown.png")
	stairdown.x, stairdown.y = display.contentWidth*0.6, display.contentHeight*0.7


	local function tapUpEventListener( event )
		print("위쪽을 클릭")
		composer.gotoScene('ff5.F5_3')
	end 
	stairup:addEventListener("tap", tapUpEventListener)

   local function tapDownEventListener( event )
		print("아래쪽을 클릭")
		composer.gotoScene('ff3.viewK')
	end 
	stairdown:addEventListener("tap", tapDownEventListener)

	-- 왼쪽으로 이동
	local function tapLeft( event )
		composer.gotoScene("ff4.class4")
		print("class4으로 이동")
	end
	left:addEventListener("tap", tapLeft)

	--오른쪽으로 이동
	local function tapRight( event )
		composer.gotoScene("ff4.toilet") --toilet으로 이동
		print("toilet으로 이동")
	end
	right:addEventListener("tap", tapRight)

	--notice창 코드

	function backgroundTap ( event )
		if((event.x > 50 and event.x < 153 and event.y > 280 and event.y <580)
			or (event.x > 255 and event.x < 400 and event.y > 278 and event.y < 577)) then
			composer.showOverlay("ff4.notice")
		end
	end
	self.view:addEventListener("tap", backgroundTap)



	--레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(left)
 	sceneGroup:insert(right)
	sceneGroup:insert(stairup)
 	sceneGroup:insert(stairdown)
	sceneGroup:insert(inven_bg)
    sceneGroup:insert(inventoryGroup)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
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
	
	--will이 실행된 다음에 did가 실행됨
	if event.phase == "will" then 
		timer.cancel("cctv_timer")
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		composer.removeScene("ff4.floor4") --다른 신으로 넘어갈 때 floor4가 삭제되게끔 (처음부터 실행 가능)
	
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
