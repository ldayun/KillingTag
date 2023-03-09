-----------------------------------------------------------------------------------------
--
-- 5678.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm


function scene:create( event )
	local sceneGroup = self.view

    --배경 설정
    local background = display.newImageRect("image/5678.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
    --오른쪽으로만 이동 

	local right = display.newImage("image/right.png")
	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5


    --오른쪽키 누르면 4com으로 장면 이동
    function right:tap( event )
        composer.gotoScene("ff4.class4") -- 추가
		print("class4으로 이동")
    end
    right:addEventListener("tap", right)
    
	--문 클릭하면 

	function backgroundTap ( event )
		if((event.x > 505 and event.x < 520 and event.y > 275 and event.y < 520)
			or (event.x > 575 and event.x < 605 and event.y > 260 and event.y <570)
			or (event.x > 630 and event.x < 655 and event.y > 245 and event.y <600)
			or (event.x > 750 and event.x < 800 and event.y > 210 and event.y <687)
			or (event.x > 855 and event.x < 1000 and event.y > 195 and event.y <720)) then
		--    local success= display.newText("방송실 열쇠 획득", display.contentWidth/2, display.contentHeight/2)
		composer.showOverlay("ff4.notice")
		end
	end
	self.view:addEventListener("tap", backgroundTap)

	--8반 문열기 클릭했을 경우
    function door8Tap( event )
		if((event.x > 475 and event.x < 495 and event.y > 280 and event.y <500)
		or (event.x > 445 and event.x < 452 and event.y > 285 and event.y <490)) then
		composer.gotoScene("ff4.class8")
		end
    end
    self.view:addEventListener("tap", door8Tap)

	
   sceneGroup:insert(background)
   sceneGroup:insert(right)
   --sceneGroup:insert(notice)
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
        composer.removeScene("ff4.5678")
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