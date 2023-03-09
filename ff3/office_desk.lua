-----------------------------------------------------------------------------------------
--
-- office_desk.lua    교무실의 서랍 장면
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_office_Block.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local left = display.newImage("Image_K/left.png")
 	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

	local lock = display.newRect( display.contentWidth*0.7, display.contentHeight*0.3, 150, 150 )
	------ 화면전환 ------------------------------------------------------------
 	local function tapLockEventListener( event )
 	 	print("자물쇠를 클릭했습니다")
 	 	if(scene_cnt == 0) then
 	 		composer.gotoScene('ff3.office_unlock')
 	 	else
 	 		composer.gotoScene('ff3.office_lock')
 	 	end
 	end 
 	lock:addEventListener("tap", tapLockEventListener)

 	local function tapLeftEventListener( event )
 		print("왼쪽을 클릭했습니다")
 		composer.gotoScene('ff3.office_in')
 	end 
 	left:addEventListener("tap", tapLeftEventListener)

 	-------- 클릭후 멘트 ---------------------------------------------------------------
	local Data = jsonParse("json/officeMent.json")

	local next  = display.newImage(Data[3].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local image = display.newImage(Data[3].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local info = display.newText(Data[3].info, display.contentWidth*0.5, display.contentHeight*0.5)
	local info2 = display.newText(Data[3].info2, display.contentWidth*0.5, display.contentHeight*0.88)
	next:toBack()
	image:toBack()
	info2:toBack()

	info:setFillColor(1)
	info.size = 50

	local function tapEventListener( event )
		info.alpha = 0
		
		next:toFront()
		image:toFront()
		info2:toFront()
		
		info2:setFillColor(1)
		info2.size = 25
 	end
	
 	local function tapNeEventListener( event )
 		print("다음")
		next:toBack()
		image:toBack()
		info2:toBack()
 	end 
 	info:addEventListener("tap", tapEventListener)
 	next:addEventListener("tap", tapNeEventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
	sceneGroup:insert(lock)
	sceneGroup:insert(left)
	sceneGroup:insert(info)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)


	lock:toBack(lock)
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
		composer.removeScene("ff3.office_desk")
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
