-----------------------------------------------------------------------------------------
--
-- office_unlock.lua    자물쇠로 잠겨져있는 장면 
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_office_lock.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local left = display.newImage("Image_K/left.png")
 	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

	local num1 = widget.newButton {
   		x =  display.contentWidth*0.37,
   		y = display.contentHeight*0.313,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num1.alpha = 0.5

	local num2 = widget.newButton {
   		x =  display.contentWidth*0.37,
   		y  = display.contentHeight*0.43,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num2.alpha = 0.5

	local num3 = widget.newButton {
   		x =  display.contentWidth*0.37,
   		y  = display.contentHeight*0.545,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num3.alpha = 0.5
	local num4 = widget.newButton {
   		x =  display.contentWidth*0.37,
   		y  = display.contentHeight*0.6552,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num4.alpha = 0.5
	local num5 = widget.newButton {
   		x =  display.contentWidth*0.37,
   		y  = display.contentHeight*0.772,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num5.alpha = 0.5

	local num6 = widget.newButton {
   		x =  display.contentWidth*0.608,
   		y = display.contentHeight*0.313,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num6.alpha = 0.5
	local num7 = widget.newButton {
   		x =  display.contentWidth*0.608,
   		y = display.contentHeight*0.43,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num7.alpha = 0.5
	local num8 = widget.newButton {
   		x =  display.contentWidth*0.608,
   		y = display.contentHeight*0.545 ,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num8.alpha = 0.5
	local num9 = widget.newButton {
   		x =  display.contentWidth*0.608,
   		y = display.contentHeight*0.6552,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num9.alpha = 0.5
	local num0 = widget.newButton {
   		x =  display.contentWidth*0.608,
   		y = display.contentHeight*0.772,
   		defaultFile = "Image_K/3rd_office_buttonN.jpg",
  		overFile =  "Image_K/3rd_office_buttonY.jpg",
	}
	num0.alpha = 0.5

	------ 화면전환 ------------------------------------------------------------
 	local function tapLeftEventListener( event )
 		print("왼쪽을 클릭했습니다")
 		composer.gotoScene('ff3.office_desk')
 	end 
 	left:addEventListener("tap", tapLeftEventListener)
 	-------- 자물쇠  ---------------------------------------------------------------
 	local count = 0
 	local check = 0
 	local wrong = 0
	local function tapPasswordEventListener( event )	
		if(count == 0 and event.target == num8) then
 			print("yes")
 		elseif(event.target ~= num8 and count == 0) then
 			check = 1
 		end

 		if(count == 1 and event.target == num5) then
 			print("wow")
 		elseif(event.target ~= num5 and count == 1) then
 			check = 1
 		end

 		if(count == 2 and event.target == num3)then
 			print("end")
 		elseif(event.target ~= num3 and count == 2)then
 			check = 1
 		end
 		
 		if(count == 2 and check == 0) then
 			scene_cnt = scene_cnt + 1
 			composer.gotoScene('ff3.office_lock')
 		elseif(count == 2 and check == 1)then
 			print("틀렸습니다")
 			wrong = 1
 		end

 		if(wrong == 1) then
 			count = 0
 			check = 0
 			wrong = 0
 		else
 			count = count + 1
 		end
 	end

	num1:addEventListener("tap", tapPasswordEventListener)
	num2:addEventListener("tap", tapPasswordEventListener)
	num3:addEventListener("tap", tapPasswordEventListener)
	num4:addEventListener("tap", tapPasswordEventListener)
	num5:addEventListener("tap", tapPasswordEventListener)
	num6:addEventListener("tap", tapPasswordEventListener)
	num7:addEventListener("tap", tapPasswordEventListener)
	num8:addEventListener("tap", tapPasswordEventListener)
	num9:addEventListener("tap", tapPasswordEventListener)
	num0:addEventListener("tap", tapPasswordEventListener)
	
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
	sceneGroup:insert(left)
 	sceneGroup:insert(num1)
 	sceneGroup:insert(num2)
 	sceneGroup:insert(num3)
 	sceneGroup:insert(num4)
 	sceneGroup:insert(num5)
 	sceneGroup:insert(num6)
 	sceneGroup:insert(num7)
 	sceneGroup:insert(num8)
 	sceneGroup:insert(num9)
 	sceneGroup:insert(num0)
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
