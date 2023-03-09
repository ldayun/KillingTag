-----------------------------------------------------------------------------------------
--
-- class4_in.lua     2학년 4반 교실 내부
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm


function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_in_class4.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local clock = display.newImage("Image_K/clock.png")
	clock.x, clock.y = display.contentWidth*0.685, display.contentHeight*0.68
	clock:scale(0.4, 0.4)

	local right = display.newImage("Image_K/right.png")
 	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5
	local div1 = display.newRect( display.contentWidth*0.23, display.contentHeight*0.65, 400, 300 )
	local div2 = display.newRect( display.contentWidth*0.54, display.contentHeight*0.65, 300, 300 )
	local div3 = display.newRect( display.contentWidth*0.8, display.contentHeight*0.65, 150, 300 )

	-- 추가
	-- 살인마 루트 캐비넷 오브젝트 
	local cabinet = display.newRect(365, 280, 50, 180)
	cabinet.alpha = 0.5

	-- 캐비넷 오브젝트 터치
	function cabinet:tap(event)
		if(getKeyring == 1) then
			composer.showOverlay("blackout")
		end
	end
	cabinet:addEventListener("tap", cabinet)

	------ 화면전환 ------------------------------------------------------------
 	local function tapBackEventListener( event )
 		print("복도를 클릭했습니다")
 		composer.gotoScene('ff3.class4')
 	end 
 	right:addEventListener("tap", tapBackEventListener)

 	---------멘트 ---------------------------------------------------------------
 	local index = 1
  	local Data = jsonParse("json/classMent.json")

	
	local image = display.newImage(Data[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local info = display.newText(Data[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	local next  = display.newImage(Data[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	info:setFillColor(1)
	info.size = 25

	local info2 = display.newText(Data[2].info, display.contentWidth*0.5, display.contentHeight*0.88)
	local image2 = display.newImage(Data[2].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local next2  = display.newImage(Data[2].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	image2:toBack()
	next2.alpha = 0
	info2:toBack()

	local info3 = display.newText(Data[3].info, display.contentWidth*0.5, display.contentHeight*0.88)
	local image3 = display.newImage(Data[3].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local next3  = display.newImage(Data[3].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	image3:toBack()
	next3.alpha = 0
	info3:toBack()

	local info4 = display.newText(Data[4].info,display.contentWidth*0.5, display.contentHeight*0.88)
	local image4 = display.newImage(Data[4].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local next4  = display.newImage(Data[4].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	image4:toBack()
	next4.alpha = 0
	info4:toBack()
	
	

-----------시계선택--------------------------------------------------------------------------------------------------------------------
	local clock2 = display.newImage("Image_K/clock.png")
	clock2.alpha = 0

 	local function tapClockEventListener( event )
 		print("시계를 클릭했습니다")
		playTimeText.alpha = 1
 		info3:setFillColor(1)
		info3.size = 25
		image3:toFront()
		next3.alpha = 1
 		info3:toFront()
 	end 

	local function tapNeEventListener( event )
		image:toBack()
		next.alpha = 0
		info:toBack()
 	end 

 	local function tapNe2EventListener( event ) 
 		print("다음")
		next3.alpha = 0
		image3:toBack()
		info3:toBack()
		info4:setFillColor(1)
		info4.size = 25
		image4:toFront()
		next4.alpha = 1
 		info4:toFront()
 	end 

 	local function tapNe3EventListener( event ) ---- 멘트와 그림 다 뒤로..
 		image4:toBack()
		next4.alpha = 0
 		info4:toBack()
 		clock.alpha = 0
 		-- item_clock.alpha = 1
 		-- item_clock.x, item_clock.y = display.contentWidth*0.948, display.contentHeight*0.1 + 130 * item_cnt
 		-- item_cnt = item_cnt + 1

 		clock_index = clock_index + 1
		item_index = item_index + 1
		items[item_index] = display.newImage(itemGroup, "Image_K/clock.png")
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		clock_flag = 1
		inventoryGroup:insert(items[item_index])
		clock_index = item_index
 	end

 	local function tapDivEventListener( event ) -----교실 분단 선택시 나오는 멘트
		next2.alpha = 1
		image2:toFront()
		info2:toFront()
		info2:setFillColor(1)
		info2.size = 25
 	end 
 	
 	local function tapDivNeEventListener( event )
		image2:toBack()
		next2.alpha = 0
		info2:toBack()
 	end 

 	clock:addEventListener("tap", tapClockEventListener)
 	next:addEventListener("tap", tapNeEventListener)
 	next2:addEventListener("tap", tapDivNeEventListener)
 	next3:addEventListener("tap", tapNe2EventListener)
 	next4:addEventListener("tap", tapNe3EventListener)
 	div1:addEventListener("tap", tapDivEventListener)
 	div2:addEventListener("tap", tapDivEventListener)
 	div3:addEventListener("tap", tapDivEventListener)
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
 	sceneGroup:insert(clock)
  	sceneGroup:insert(right)
  	sceneGroup:insert(div1)
  	sceneGroup:insert(div2)
  	sceneGroup:insert(div3)
	sceneGroup:insert(cabinet)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
  	-- sceneGroup:insert(next2)
  	-- sceneGroup:insert(image2)
  	-- sceneGroup:insert(info2)
  	-- sceneGroup:insert(info3)

	
	div1:toBack()
	div2:toBack()
	div3:toBack()
	cabinet:toBack()
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
		composer.removeScene("ff3.class4_in")
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

