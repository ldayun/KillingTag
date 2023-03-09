-----------------------------------------------------------------------------------------
--
-- cctv_bf.lua
-- cctv제거 전
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/adm/cctv_bf.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	
	-- 방향키
	local back = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight/2)

	--설정
	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)

	--대화박스
	local box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.9)

	local nextKey = display.newImage("image/UI/next.png", display.contentWidth*0.86, display.contentHeight*0.95)

	local content_cctv_bf = display.newText("cctv제거 전 대사.", display.contentWidth*0.5, display.contentHeight*0.88)
	content_cctv_bf.size = 25--------

	--json 적용하기
	local Data = jsonParse("json/text_cctv_bf.json")
	if Data then
		print(Data[1].dialog)
	end

	--json 적용하기
	local index = 0
	function nextScript( event )
		index = index + 1
		if(index > #Data) then 
			box.alpha = 0
			nextKey.alpha = 0
			content_cctv_bf.alpha = 0
		else
			content_cctv_bf.text = Data[index].content
		end
	end
	nextKey:addEventListener("tap", nextScript)
	nextScript()

	----------------------------------event
	function back:tap( event )
		print("행정실로")
		composer.gotoScene("ff1.adm")
	end
	back:addEventListener("tap", back)

	function click( event )
		-- body
		if (event.x >= 988 and event.x <= 1072 and event.y >= 292 and event.y <= 340) then
			print("끄기")
			composer.gotoScene("ff1.cctv_af")
		end
	end
	self.view:addEventListener("tap", click)



	sceneGroup:insert(background)
	sceneGroup:insert(setting)
	sceneGroup:insert(back)
	sceneGroup:insert(box)
	sceneGroup:insert(nextKey)
	sceneGroup:insert(content_cctv_bf)
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
		composer.showOverlay("ff1.cctv_on")
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
		composer.removeScene("ff1.cctv_bf")
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