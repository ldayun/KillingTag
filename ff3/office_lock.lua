-----------------------------------------------------------------------------------------
--
-- office_in.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local cnt = 0
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_office_unlock.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local toNote = display.newRect( display.contentWidth*0.5, display.contentHeight*0.5, 400, 400 )

	local num1 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.37, display.contentHeight*0.313 )
	num1.alpha = 0.5
	local num2 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.37, display.contentHeight*0.43 )
	num2.alpha = 0.5
	local num3 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.37, display.contentHeight*0.545 )
	num3.alpha = 0.5
	local num4 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.37, display.contentHeight*0.6552 )
	num4.alpha = 0.5
	local num5 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.37, display.contentHeight*0.772 )
	num5.alpha = 0.5
	local num6 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.608, display.contentHeight*0.313 )
	num6.alpha = 0.5
	local num7 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.608, display.contentHeight*0.43 )
	num7.alpha = 0.5
	local num8 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.608, display.contentHeight*0.545 )
	num8.alpha = 0.5
	local num9 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.608, display.contentHeight*0.6552 )
	num9.alpha = 0.5
	local num0 = display.newImage( "Image_K/3rd_office_buttonN.jpg", display.contentWidth*0.608, display.contentHeight*0.772 )
	num0.alpha = 0.5

	------ 화면전환 ------------------------------------------------------------

 	local function tapTonoteEventListener( event )
 	 	print("풀린 자물쇠를 클릭했습니다")	
		cnt = cnt + 1

		if(cnt > 1)then
			composer.gotoScene('ff3.office_noteNo')
		else
			composer.gotoScene('ff3.office_note')
		end
 	end 
 	toNote:addEventListener("tap", tapTonoteEventListener)
 	-------- 클릭후 멘트 ---------------------------------------------------------------

 -- 	local computer = display.newRect( display.contentWidth*0.85, display.contentHeight*0.65, 100, 150)
 -- 	local classFourB = display.newRect( display.contentWidth*0.56, display.contentHeight*0.55, 100, 200)
 	

	--next:toBack()
	--image:toBack()
	--info:toBack()
	
	-- local function tapEventListener( event )
 -- 		print("문을 클릭했습니다")
	-- 	if( Data ) then
	-- 		print( Data[1].next )
	-- 		print( Data[1].info )
	-- 		print( Data[1].back )
	-- 	end

	-- 	info:setFillColor(1)
	-- 	info.size = 30

	-- 	next:toFront()
	-- 	image:toFront()
	-- 	info:toFront()
 -- 	end

 -- 	local function tapNeEventListener( event )
 -- 		print("다음")
	-- 	next:toBack()
	-- 	image:toBack()
	-- 	info:toBack()
 -- 	end 
 	
 -- 	computer:addEventListener("tap", tapEventListener)
 -- 	classFourB:addEventListener("tap", tapEventListener)
 -- 	next:addEventListener("tap", tapNeEventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
  	sceneGroup:insert(toNote)
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
 	sceneGroup:insert(inven_bg)
 	sceneGroup:insert(inventoryGroup)


	toNote:toBack()

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
		--composer.gotoScene('office_note')
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		timer.cancel("cctv_timer")
		composer.removeScene("ff3.office_lock")
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
