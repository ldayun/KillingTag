-----------------------------------------------------------------------------------------
--
-- Teacheroom.lua  1층 교무실
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/Teacher_desk.jpg", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth*0.5, display.contentHeight/2

	--포스트잇 확대
	local bg1 = display.newImageRect("ff1/image2/postit.jpg", display.contentWidth*0.9, display.contentHeight)
	bg1.x, bg1.y = display.contentWidth*0.5, display.contentHeight/2
	bg1.alpha = 0


	--서랍장으로 가는 버튼
	local button_left = display.newImage("ff1/image2/Button_left.png")
	button_left.x, button_left.y = display.contentWidth*0.04, display.contentHeight*0.5
	button_left.alpha = 0


	--복도로 가는 버튼
	local back = display.newImage("ff1/image2/back.png")
	back.x, back.y = display.contentWidth*0.5, display.contentHeight*0.94
	back.alpha = 0

	--체육쌤 책상으로 가는 버튼
	local back2 = display.newImage("ff1/image2/back.png")
	back2.x, back2.y = display.contentWidth*0.5, display.contentHeight*0.94
	back2.alpha = 0


	--텍스트 바
	local textbar = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)

	local text = display.newText("체육쌤 자리..\n주변에 적혀있다고...", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 1

	--서랍 임시 오브젝트
	local drawer = display.newRect(display.contentWidth*0.525, display.contentHeight*0.75, 140, 100)
	drawer.alpha = 0


	local function tapNext( event )
		textbar.alpha = 0
		text.alpha = 0
		next_button.alpha = 0
		back.alpha = 1
		-- postit.alpha = 0.01
		drawer.alpha = 0.01
		button_left.alpha = 1
	end

	local function tapBack( event )
		-- composer.hideOverlay("TeacherRoom")
		-- composer.showOverlay("Floor_2")
		composer.gotoScene("ff1.view2")
	end

	local function tapBack2( event )
		back2.alpha = 0
		bg1.alpha = 0
		bg.alpha = 1
		back.alpha = 1
		button_left.alpha = 1
	end

	local function tapPostit( event )
		if(event.x >= 343 and event.x <= 370 and event.y >= 270 and event.y <= 300) then
			bg.alpha = 0
			bg1.alpha = 1
			back.alpha = 0
			back2.alpha = 1
			button_left.alpha = 0
		end
	end
	self.view:addEventListener("tap", tapPostit)

	local function tapLeft( event )
		print("서랍 이동")
		composer.gotoScene("ff1.TeacherRoom_drawer")
	end

	local function tapDrawer( event )
		if (event.x >= 680 and event.x <= 820 and event.y >= 484 and event.y <= 603) then
			drawer.alpha = 0
			back.alpha = 0
			composer.gotoScene("ff1.drawer_zoom")
		end
	end
	self.view:addEventListener("tap", tapDrawer)

	back:addEventListener("tap", tapBack)
	next_button:addEventListener("tap", tapNext)
	back2:addEventListener("tap", tapBack2)
	button_left:addEventListener("tap", tapLeft)
	drawer:addEventListener("tap", tapDrawer)

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(button_left)
	sceneGroup:insert(back)
	sceneGroup:insert(back2)
	sceneGroup:insert(textbar)
	sceneGroup:insert(text)
	sceneGroup:insert(next_button)
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
		composer.removeScene("ff1.teacherRoom")
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