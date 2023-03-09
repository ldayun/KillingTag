local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_hall_class (2).jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2
 	
 	local right = display.newImage("Image_K/right.png")
 	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

	------ 화면전환 ------------------------------------------------------------
	local function tapRightEventListener( event )
 		print("오른쪽을 클릭했습니다")
 		composer.gotoScene('ff3.class4')
 	end 
 	right:addEventListener("tap", tapRightEventListener)
 	-------- 클릭후 멘트 ---------------------------------------------------------------

 	local classFive = display.newRect( display.contentWidth*0.73, display.contentHeight*0.6, 150, 400)
 	local classSix = display.newRect( display.contentWidth*0.61, display.contentHeight*0.6, 70, 300)
 	local classSixB = display.newRect( display.contentWidth*0.5, display.contentHeight*0.6, 40, 200)
	local classSeven = display.newRect( display.contentWidth*0.46, display.contentHeight*0.55, 30, 250)
	local classSevenB = display.newRect( display.contentWidth*0.4, display.contentHeight*0.55, 10, 200)
	local classEight = display.newRect( display.contentWidth*0.35, display.contentHeight*0.55, 10, 190)
	local classEightB = display.newRect( display.contentWidth*0.38, display.contentHeight*0.55, 10, 200)

	local function tapEventListener( event )
 		print("문을 클릭했습니다")

		composer.showOverlay('ff1.locked')
 	end

 	classFive:addEventListener("tap", tapEventListener)
 	classSix:addEventListener("tap", tapEventListener)
 	classSixB:addEventListener("tap", tapEventListener)
 	classSeven:addEventListener("tap", tapEventListener)
 	classSevenB:addEventListener("tap", tapEventListener)
 	classEight:addEventListener("tap", tapEventListener)
 	classEightB:addEventListener("tap", tapEventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
 	sceneGroup:insert(right)
 	sceneGroup:insert(classFive)
 	sceneGroup:insert(classSix)
 	sceneGroup:insert(classSixB)
 	sceneGroup:insert(classSeven)
 	sceneGroup:insert(classSevenB)
 	sceneGroup:insert(classEight)
 	sceneGroup:insert(classEightB)
 	sceneGroup:insert(inven_bg)
 	sceneGroup:insert(inventoryGroup)

 	classFive:toBack()
 	classSix:toBack()
 	classSixB:toBack()
 	classSeven:toBack()
 	classSevenB:toBack()
 	classEight:toBack()
 	classEightB:toBack()
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
		composer.removeScene("ff3.class2")
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