-----------------------------------------------------------------------------------------
--
-- office.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm


function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("Image_K/3rd_hall_office.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2
 	
 	local right = display.newImage("Image_K/right.png")
 	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

 	local left = display.newImage("Image_K/left.png")
 	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

	local office = display.newRect( display.contentWidth*0.54, display.contentHeight*0.57, 100, 250)
	local office2 = display.newRect( display.contentWidth*0.12, display.contentHeight*0.57, 100, 250)

	------ 화면전환 ------------------------------------------------------------
	local function tapRightEventListener( event )
 		print("오른쪽을 클릭했습니다")
 		composer.gotoScene('ff3.class')
 	end 
 	right:addEventListener("tap", tapRightEventListener)

 	local function tapLeftEventListener( event )
 		print("왼쪽을 클릭했습니다")
 		composer.gotoScene('ff3.viewK')
 	end 
 	left:addEventListener("tap", tapLeftEventListener)

 	local function tapOfficeEventListener( event )
 		print("교무실을 클릭했습니다")
 		composer.gotoScene('ff3.office_in')
 	end 
 	office:addEventListener("tap", tapOfficeEventListener)
 	-------- 클릭후 멘트 ---------------------------------------------------------------

 	local manBath = display.newRect( display.contentWidth*0.76, display.contentHeight*0.6, 120, 250)
 	local womanBath = display.newRect( display.contentWidth*0.65, display.contentHeight*0.6, 105, 220)
	
	local Data2 = jsonParse("json/officeMent.json")

	local next2  = display.newImage(Data2[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local image2 = display.newImage(Data2[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local info2 = display.newText(Data2[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	info2:setFillColor(1)
	info2.size = 25
	
	local function tapEventListener( event )
 		print("문을 클릭했습니다")

		composer.showOverlay('ff1.locked')
 	end

 	local function tapNe2EventListener( event )
 		print("다음")
		next2:toBack()
		image2:toBack()
		info2:toBack()
 	end  
 	
 	office2:addEventListener("tap", tapEventListener)
 	next2:addEventListener("tap", tapNe2EventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
 	sceneGroup:insert(right)
 	sceneGroup:insert(left)
 	sceneGroup:insert(office)
 	sceneGroup:insert(office2)
 	sceneGroup:insert(manBath)
 	sceneGroup:insert(womanBath)
 	sceneGroup:insert( next2 )
 	sceneGroup:insert( image2 )
 	sceneGroup:insert( info2 )
 	sceneGroup:insert(inven_bg)
 	sceneGroup:insert(inventoryGroup)


 	manBath:toBack()
 	womanBath:toBack()
 	office:toBack()
 	office2:toBack()
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
		composer.removeScene("ff3.office")
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
