-----------------------------------------------------------------------------------------
--
-- Drawer_Open.lua  1층 교무실
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/TR/KeyOpen.jpg", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	--텍스트 바
	local textbar = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)
	textbar.alpha = 1

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 1

	local text = display.newText("열렸다..!\n역시 포스트잇에 적힌 숫자가 비밀번호였구나.", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 1



	
	--누르기전
	local btnGroup = display.newGroup()
	local btn = {}

	for i = 1, 5 do
		btn[i] = display.newImage(btnGroup, "ff1/image2/TR/KeyButton.jpg")
		if(i>3)then
			btn[i].x, btn[i].y = display.contentWidth*0.37, display.contentHeight*(0.31 + 0.116 * (i - 1))
		else
		btn[i].x, btn[i].y = display.contentWidth*0.37, display.contentHeight*(0.31 + 0.12 * (i - 1))
		end
		btn[i].alpha = 0.5
	end	

	for i = 6, 10 do
		btn[i] = display.newImage(btnGroup, "ff1/image2/TR/KeyButton.jpg")
		if(i>8)then
			btn[i].x, btn[i].y = display.contentWidth*0.606, display.contentHeight*(0.31 + 0.116 * (i - 6))
		else
		btn[i].x, btn[i].y = display.contentWidth*0.606, display.contentHeight*(0.31 + 0.12 * (i - 6))
		end
		btn[i].alpha = 0.5
	end	

	--누른 후 (어두운색)
	local btnGroup1 = display.newGroup()
	local btn1 = {}

	for i = 1, 5 do
		btn1[i] = display.newImage(btnGroup1, "ff1/image2/TR/KeyButton2.jpg")
		if(i>3)then
			btn1[i].x, btn1[i].y = display.contentWidth*0.37, display.contentHeight*(0.31 + 0.116 * (i - 1))
		else
		btn1[i].x, btn1[i].y = display.contentWidth*0.37, display.contentHeight*(0.31 + 0.12 * (i - 1))
		end
		btn1[i].alpha = 0
	end	

	for i = 6, 10 do
		btn1[i] = display.newImage(btnGroup1, "ff1/image2/TR/KeyButton2.jpg")
		if(i>8)then
			btn1[i].x, btn1[i].y = display.contentWidth*0.606, display.contentHeight*(0.31 + 0.116 * (i - 6))
		else
		btn1[i].x, btn1[i].y = display.contentWidth*0.606, display.contentHeight*(0.31 + 0.12 * (i - 6))
		end
		btn1[i].alpha = 0
	end	


	btn[1].alpha = 0
	btn1[1].alpha = 0.6

	btn[5].alpha = 0
	btn1[5].alpha = 0.6

	btn[6].alpha = 0
	btn1[6].alpha = 0.6
	
	btn[4].alpha = 0
	btn1[4].alpha = 0.6

	--찾았다 이후의 다음 누름
	local function tapNext( event )
		textbar.alpha = 0
		text.alpha = 0
		next_button.alpha = 0
		composer.gotoScene("ff1.Drawer_inside")
	end

	next_button:addEventListener("tap", tapNext)

	sceneGroup:insert(bg)
	sceneGroup:insert(btnGroup)
	sceneGroup:insert(btnGroup1)
	sceneGroup:insert(textbar)
	sceneGroup:insert(next_button)
	sceneGroup:insert(text)
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