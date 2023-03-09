-----------------------------------------------------------------------------------------
--
-- class4.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm


-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view

    --배경 설정
    local background = display.newImageRect("image/4com.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
   
    --양 옆 이동 
	local right = display.newImage("image/right.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	local left = display.newImage("image/left.png")
	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

  
   --오른쪽키 누르면 floor4으로 장면 이동
    function right:tap( event )
        composer.gotoScene("ff4.floor4") -- 추가
		print("floor4으로 이동")
    end
    right:addEventListener("tap", right)
    
    --왼쪽키 누르면 5678로 이동
    local function tapLeft( event )
		composer.gotoScene("ff4.5678")
		print("5678으로 이동")
	end
	left:addEventListener("tap", tapLeft)

	
	--문 클릭하면 

	function backgroundTap ( event )
		if((event.x > 50 and event.x < 285 and event.y > 216 and event.y <630)
			or (event.x > 680 and event.x < 770 and event.y > 297 and event.y <520)
			or (event.x > 1030 and event.x < 1093 and event.y > 300 and event.y <585)) then
		--    local success= display.newText("방송실 열쇠 획득", display.contentWidth/2, display.contentHeight/2)
		composer.showOverlay("ff4.notice")
		end
	end
	self.view:addEventListener("tap", backgroundTap)


   sceneGroup:insert(background)
   sceneGroup:insert(left)
   sceneGroup:insert(right)
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
	
	if event.phase == "will" then
		timer.cancel("cctv_timer")
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
        composer.removeScene("ff4.class4")
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
