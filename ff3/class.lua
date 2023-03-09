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
	local background = display.newImageRect("Image_K/3rd_hall_class.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local left = display.newImage("Image_K/left.png")
 	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

	
	------ 화면전환 ------------------------------------------------------------
 	local function tapLeftEventListener( event )
 		print("왼쪽을 클릭했습니다")
 		composer.gotoScene('ff3.office')
 	end 
 	left:addEventListener("tap", tapLeftEventListener)
 	-------- 클릭후 멘트 ---------------------------------------------------------------

 	local classOne = display.newRect( display.contentWidth*0.5, display.contentHeight*0.6, 50, 200)
 	local classOneB = display.newRect( display.contentWidth*0.4, display.contentHeight*0.7, 70, 250)
 	local classTwo = display.newRect( display.contentWidth*0.6, display.contentHeight*0.6, 10, 200)
 	local classTwoB = display.newRect( display.contentWidth*0.55, display.contentHeight*0.6, 60, 200)
	local classThree = display.newRect( display.contentWidth*0.65, display.contentHeight*0.55, 10, 200)
	local classThreeB = display.newRect( display.contentWidth*0.62, display.contentHeight*0.55, 10, 200)
	
	local function tapEventListener( event )
 		print("문을 클릭했습니다")

		composer.showOverlay('ff1.locked')
 	end

 	local function tapNeEventListener( event )
 		print("다음")
		next:toBack()
		image:toBack()
		info:toBack()
 	end 
 	
 	classOne:addEventListener("tap", tapEventListener)
 	classOneB:addEventListener("tap", tapEventListener)
 	classTwo:addEventListener("tap", tapEventListener)
 	classTwoB:addEventListener("tap", tapEventListener)
 	classThree:addEventListener("tap", tapEventListener)
 	classThreeB:addEventListener("tap", tapEventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
 	sceneGroup:insert(left)
 	sceneGroup:insert(classOne)
 	sceneGroup:insert(classOneB)
 	sceneGroup:insert(classTwo)
 	sceneGroup:insert(classTwoB)
 	sceneGroup:insert(classThree)
 	sceneGroup:insert(classThreeB)
 	sceneGroup:insert(inven_bg)
 	sceneGroup:insert(inventoryGroup)
 	--sceneGroup:insert(counter)


 	classOne:toBack()
 	classOneB:toBack()
 	classTwo:toBack()
 	classTwoB:toBack()
 	classThree:toBack()
 	classThreeB:toBack()
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
		composer.removeScene("ff3.class")
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
