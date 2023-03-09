-----------------------------------------------------------------------------------------
--
-- class.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_hall_class4.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2
 	
 	local right = display.newImage("Image_K/right.png")
 	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

 	local left = display.newImage("Image_K/left.png")
 	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

	local classFourB = display.newRect( display.contentWidth*0.56, display.contentHeight*0.55, 100, 200)

	------ 화면전환 ------------------------------------------------------------
	local function tapRightEventListener( event )
 		print("오른쪽을 클릭했습니다")
 		composer.gotoScene('ff3.viewK')
 	end 
 	right:addEventListener("tap", tapRightEventListener)

 	local function tapLeftEventListener( event )
 		print("왼쪽을 클릭했습니다")
 		composer.gotoScene('ff3.class2')
 	end 
 	left:addEventListener("tap", tapLeftEventListener)

 	local function tapFourEventListener( event )
 		print("교실을 클릭했습니다")
 		composer.gotoScene('ff3.class4_in')
 	end 
 	classFourB:addEventListener("tap", tapFourEventListener)
 	-------- 클릭후 멘트 ---------------------------------------------------------------

 	local computer = display.newRect( display.contentWidth*0.85, display.contentHeight*0.65, 100, 150)
 	local classFour = display.newRect( display.contentWidth*0.15, display.contentHeight*0.6, 200, 250)
	
	local function tapEventListener( event )
 		print("문을 클릭했습니다")
		composer.showOverlay('ff1.locked')
 	end
 	
 	computer:addEventListener("tap", tapEventListener)
 	classFour:addEventListener("tap", tapEventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
 	sceneGroup:insert(right)
 	sceneGroup:insert(left)
 	sceneGroup:insert(computer)
 	sceneGroup:insert(classFour)
 	sceneGroup:insert(classFourB)
 	sceneGroup:insert(inven_bg)
 	sceneGroup:insert(inventoryGroup)

	classFour:toBack()
 	computer:toBack()
 	classFourB:toBack()
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
		-- Called when the scene is on screen and is about to move off screen
		timer.cancel("cctv_timer")
		composer.removeScene("ff3.class4")
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
