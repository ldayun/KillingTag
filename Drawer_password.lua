-----------------------------------------------------------------------------------------
--
-- Drawer_password.lua  1층 교무실
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/TR/Key.jpg", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local button_left = display.newImage("ff1/image2/Button_left.png")
	button_left.x, button_left.y = display.contentWidth*0.04, display.contentHeight*0.5
	button_left.alpha = 1
	
	local num = {}
	for i = 1,10 do
		num[i] = 0
	end

	--누르기전

	local function tapLeft( event )
		composer.gotoScene("ff1.drawer_zoom")
	end
	button_left:addEventListener("tap", tapLeft)
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


	local function tapBtn1( event )
		btn[1].alpha = 0
		btn1[1].alpha = 0.8
		num[1] = 1
	end

	local function tapBtn1_1( event )
		btn[1].alpha = 0.6
		btn1[1].alpha = 0
		num[1] = 0
	end

	local function tapBtn2( event )
		btn[2].alpha = 0
		btn1[2].alpha = 0.8
		num[2] = 1
	end

	local function tapBtn2_1( event )
		btn[2].alpha = 0.6
		btn1[2].alpha = 0
		num[2] = 0
	end

	local function tapBtn3( event )
		btn[3].alpha = 0
		btn1[3].alpha = 0.8
		num[3] = 1
	end

	local function tapBtn3_1( event )
		btn[3].alpha = 0.6
		btn1[3].alpha = 0
		num[3] = 0
	end

	local function tapBtn4( event )
		btn[4].alpha = 0
		btn1[4].alpha = 0.8
		num[4] = 1
	end

	local function tapBtn4_1( event )
		btn[4].alpha = 0.6
		btn1[4].alpha = 0
		num[4] = 0
	end

	local function tapBtn5( event )
		btn[5].alpha = 0
		btn1[5].alpha = 0.8
		num[5] = 1
	end

	local function tapBtn5_1( event )
		btn[5].alpha = 0.6
		btn1[5].alpha = 0
		num[5] = 0
	end

	local function tapBtn6( event )
		btn[6].alpha = 0
		btn1[6].alpha = 0.8
		num[6] = 1
	end

	local function tapBtn6_1( event )
		btn[6].alpha = 0.6
		btn1[6].alpha = 0
		num[6] = 0
	end

	local function tapBtn7( event )
		btn[7].alpha = 0
		btn1[7].alpha = 0.8
		num[7] = 1
	end

	local function tapBtn7_1( event )
		btn[7].alpha = 0.6
		btn1[7].alpha = 0
		num[7] = 0
	end

	local function tapBtn8( event )
		btn[8].alpha = 0
		btn1[8].alpha = 0.8
		num[8] = 1
	end

	local function tapBtn8_1( event )
		btn[8].alpha = 0.6
		btn1[8].alpha = 0
		num[8] = 0
	end

	local function tapBtn9( event )
		btn[9].alpha = 0
		btn1[9].alpha = 0.8
		num[9] = 1
	end

	local function tapBtn9_1( event )
		btn[9].alpha = 0.6
		btn1[9].alpha = 0
		num[9] = 0
	end

	local function tapBtn10( event )
		btn[10].alpha = 0
		btn1[10].alpha = 0.8
		num[10] = 1
	end

	local function tapBtn10_1( event )
		btn[10].alpha = 0.6
		btn1[10].alpha = 0
		num[10] = 0
	end

	local function tap(event)
		if(num[1]==1 and num[5]==1 and num[6] == 1 and num[4]==1) then
			composer.gotoScene("ff1.drawer_open")
		else
			print("실패")
		end
	end



	btn[1]:addEventListener("tap", tapBtn1)
	btn1[1]:addEventListener("tap", tapBtn1_1)
	btn[1]:addEventListener("tap", tap)
	btn1[1]:addEventListener("tap", tap)

	btn[2]:addEventListener("tap", tapBtn2)
	btn1[2]:addEventListener("tap", tapBtn2_1)

	btn[3]:addEventListener("tap", tapBtn3)
	btn1[3]:addEventListener("tap", tapBtn3_1)

	btn[4]:addEventListener("tap", tapBtn4)
	btn1[4]:addEventListener("tap", tapBtn4_1)
	btn[4]:addEventListener("tap", tap)
	btn1[4]:addEventListener("tap", tap)

	btn[5]:addEventListener("tap", tapBtn5)
	btn1[5]:addEventListener("tap", tapBtn5_1)
	btn[5]:addEventListener("tap", tap)
	btn1[5]:addEventListener("tap", tap)

	btn[6]:addEventListener("tap", tapBtn6)
	btn1[6]:addEventListener("tap", tapBtn6_1)
	btn[6]:addEventListener("tap", tap)
	btn1[6]:addEventListener("tap", tap)

	btn[7]:addEventListener("tap", tapBtn7)
	btn1[7]:addEventListener("tap", tapBtn7_1)

	btn[8]:addEventListener("tap", tapBtn8)
	btn1[8]:addEventListener("tap", tapBtn8_1)

	btn[9]:addEventListener("tap", tapBtn9)
	btn1[9]:addEventListener("tap", tapBtn9_1)

	btn[10]:addEventListener("tap", tapBtn10)
	btn1[10]:addEventListener("tap", tapBtn10_1)



	--화면 전환시 임시 drawer.alpha 조절
	tap()

	sceneGroup:insert(bg)
	sceneGroup:insert(btnGroup)
	sceneGroup:insert(btnGroup1)
	sceneGroup:insert(button_left)
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