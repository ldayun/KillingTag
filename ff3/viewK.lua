-----------------------------------------------------------------------------------------
--
-- stair.lua  3층 계단
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
item_cnt = 0
boxGroup = display.newGroup()
itemBox = {}
item_clock = display.newImage("Image_K/clock.png")
item_clock.alpha = 0
item_note =  display.newImage("Image_K/note_inItem.png")
item_note.alpha = 0
bg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
bg:setFillColor(0, 0.5)
bg:toBack()
scene_cnt = 0
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	
	---------- 이미지 배치 ---------------------------------------------
	local background = display.newImageRect("Image_K/3rd_hall_stair.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local up = display.newImage("Image_K/up.png")
 	up.x, up.y =  display.contentWidth*0.45, display.contentHeight*0.2

 	local down = display.newImage("Image_K/down.png")
 	down.x, down.y = display.contentWidth*0.6, display.contentHeight*0.7
 	
 	local right = display.newImage("Image_K/right.png")
 	right.x, right.y = display.contentWidth*0.86, display.contentHeight*0.5

 	local left = display.newImage("Image_K/left.png")
 	left.x, left.y = display.contentWidth*0.04, display.contentHeight*0.5

 -- 	local itemBlank = display.newImage("Image_K/itemBlank.png")
 -- 	itemBlank.alpha = 0.35
	-- itemBlank.x, itemBlank.y = display.contentWidth*0.95, display.contentHeight*0.5

 -- 	for i = 0, 8 do
	--  	itemBox[i] = display.newImage(boxGroup, "Image_K/itemBox.png")
	-- 	itemBox[i].x, itemBox[i].y = display.contentWidth*0.948, display.contentHeight*0.1 + 130 * i
	-- end

	--- 인벤토리 위 아래로 드래그 -----------------------------------
-- 	function drag ( event )
--    		if( event.phase == "began" ) then
--      	 	display.getCurrentStage():setFocus( event.target )
--       		event.target.isFocus = true

--       		event.target.yStart = event.target.y

--    		elseif( event.phase == "moved" ) then
--       		if( event.target.isFocus ) then
--          		event.target.y = event.target.yStart + event.yDelta
--       		end
--    		elseif( event.phase == "ended" or event.phase == "cancelled") then
--          		display.getCurrentStage():setFocus( nil )
--          		event.target.isFocus = false
--          		-- 드래그 끝났을 때
         	
--          			if(event.target.y > 100) then
--             			event.target.y = 0
--          			end
--          			if(event.target.y < -600) then
--             			event.target.y = display.contentHeight*-0.65
--          			end
--       			else
--          			display.getCurrentStage():setFocus( nil )
--          			event.target.isFocus = false
      			
--    		end
-- 	end
-- 	boxGroup:addEventListener("touch", drag)
-- --------------선택시 색 변경----------------------------------------------------------------------------------------
-- 	local flag  = 0
-- 	function touchItem( event ) 
-- 		for i = 0, 8 do
-- 			if(event.target == itemBox[i] and flag == 0) then
-- 				print(i .."번째 ")
-- 				red_item = display.newImage(boxGroup, "Image_K/itemSelect.png")
-- 				red_item.x, red_item.y = display.contentWidth*0.948, display.contentHeight*0.1 + 130 * i
-- 				red_item.alpha = 0.5
-- 				flag = 1
-- 			elseif (flag == 1 and event.target == itemBox[i]) then
-- 				flag = 0
-- 				red_item:removeSelf()
-- 			end
			
-- 		end
-- 	end
-- 	for i = 0, 8 do
-- 		itemBox[i]:addEventListener("touch", touchItem)
-- 	end
	----------------- 인벤토리 선택 -----------------------------------
	-- local noteData = jsonParse("json/itemMent.json")
	-- local noteNext  = display.newImage(noteData[2].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local noteImage = display.newImage(noteData[2].image, display.contentWidth*0.5, display.contentHeight*0.9)
	-- local noteInfo = display.newText(noteData[2].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- noteNext.alpha = 0
	-- noteImage:toBack()
	-- noteInfo:toBack()

	-- local DataS = jsonParse("json/select.json")
	-- local DataY = jsonParse("json/yes.json")
	-- local DataN = jsonParse("json/no.json")

	-- local yes  = display.newImage(DataS[1].yes, display.contentWidth* 0.86, display.contentHeight*0.9)
	-- local no  = display.newImage(DataS[1].no, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local imageS = display.newImage(DataS[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	-- local infoS = display.newText(DataS[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- yes.alpha = 0
	-- no.alpha = 0
	-- imageS:toBack()
	-- infoS:toBack()

	-- local imageY = display.newImage(DataY[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	-- local nextY  = display.newImage(DataY[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local infoY = display.newText(DataY[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- imageY:toBack()
	-- infoY:toBack()
	-- nextY.alpha = 0

	-- local imageY2= display.newImage(DataY[2].image, display.contentWidth*0.5, display.contentHeight*0.9)
	-- local nextY2   = display.newImage(DataY[2].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local infoY2 = display.newText(DataY[2].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- imageY2:toBack()
	-- infoY2:toBack()
	-- nextY2.alpha = 0

	-- local imageY3 = display.newImage(DataY[3].image, display.contentWidth*0.5, display.contentHeight*0.9)
	-- local nextY3  = display.newImage(DataY[3].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local infoY3 = display.newText(DataY[3].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- imageY3:toBack()
	-- infoY3:toBack()
	-- nextY3.alpha = 0

	-- local nextN  = display.newImage(DataN[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local imageN = display.newImage(DataN[1].image,display.contentWidth*0.5, display.contentHeight*0.9)
	-- local infoN = display.newText(DataN[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- nextN.alpha = 0
	-- imageN:toBack()
	-- infoN:toBack()
	-- local note = display.newImage("Image_K/note_inside.png")
	-- note.alpha = 0

	-- local function tapItemNoteEventListener( event )
	-- 	noteInfo:setFillColor(1)
	-- 	noteInfo.size = 25
	-- 	noteNext.alpha = 1
	-- 	noteImage:toFront()
	-- 	noteInfo:toFront()
 -- 		-- bg:toFront()
 -- 		-- note:toFront()
 -- 		-- note.x, note.y = display.contentWidth*0.5, display.contentHeight/2
 -- 	end 
 -- 	--items[diary_index]:addEventListener("tap", tapItemNoteEventListener)

 -- 	local function tapItemNoteNextEventListener( event )
 -- 		noteInfo:toBack()
 -- 		noteNext.alpha = 0
 -- 		infoS:setFillColor(1)
	-- 	infoS.size = 25
 -- 		infoS:toFront()
 -- 		yes.alpha = 1
	-- 	no.alpha = 1

 -- 	end
 -- 	noteNext:addEventListener("tap", tapItemNoteNextEventListener)

 -- 	local function tapYesEventListener( event )
	-- 	print("다음")
	-- 	yes.alpha = 0
	-- 	no.alpha = 0
	-- 	noteImage:toBack()
	-- 	infoS:toBack()
	-- 	--noteOp.alpha = 1
	-- 	infoY:setFillColor(1)
	-- 	infoY.size = 25
	-- 	nextY.alpha = 1
	-- 	imageY:toFront()
	-- 	infoY:toFront()
	-- 	-- composer.gotoScene('office_noteNo')
 -- 	end 
 -- 	yes:addEventListener("tap", tapYesEventListener)

 -- 	local function tapYesNeEventListener( event )
 -- 		nextY.alpha = 0
	-- 	imageY:toBack()
	-- 	infoY:toBack()
 -- 		bg:toFront()
 -- 		note.alpha = 1
 -- 		note.x, note.y = display.contentWidth*0.5, display.contentHeight/2
 -- 	end
 -- 	nextY:addEventListener("tap", tapYesNeEventListener)

 -- 	local function tapNoEventListener( event )
	-- 	print("다음")
	-- 	yes.alpha = 0
	-- 	no.alpha = 0
	-- 	noteImage:toBack()
	-- 	infoS:toBack()
	-- 	infoN:setFillColor(1)
	-- 	infoN.size = 25
	-- 	nextN.alpha = 1
	-- 	imageN:toFront()
	-- 	infoN:toFront()
 -- 	end 
 -- 	no:addEventListener("tap", tapNoEventListener)

 -- 	local function tapNoteBack1EventListener( event )
 -- 		infoY2:setFillColor(1)
	-- 	infoY2.size = 25
 -- 		imageY2:toFront()
	-- 	infoY2:toFront()
	-- 	nextY2.alpha = 1
 -- 	end
 -- 	note:addEventListener("tap", tapNoteBack1EventListener)

 -- 	local function tapNoteBack2EventListener( event )
 -- 		imageY2:toBack()
	-- 	infoY2:toBack()
	-- 	nextY2.alpha = 0
 -- 		infoY3:setFillColor(1)
	-- 	infoY3.size = 25
 -- 		imageY3:toFront()
	-- 	infoY3:toFront()
	-- 	nextY3.alpha = 1
 -- 	end
 -- 	nextY2:addEventListener("tap", tapNoteBack2EventListener)
 -- 	local function tapNoteBack3EventListener( event )
 -- 		imageY3:toBack()
	-- 	infoY3:toBack()
	-- 	nextY3.alpha = 0
 -- 		bg:toBack()
 -- 		note.alpha = 0
 -- 	end
 -- 	nextY3:addEventListener("tap", tapNoteBack3EventListener)

 -- 	local function tapNoNeEventListener( event )
	-- 	print("다음")
	-- 	nextN.alpha = 0
	-- 	imageN:toBack()
	-- 	infoN:toBack()
 -- 	end 
 -- 	nextN:addEventListener("tap", tapNoNeEventListener)

 	------------------시계 인벤토리 선택---------------------------------------------------------------------------------------------
	-- local clData = jsonParse("json/itemMent.json")
	-- local clNext  = display.newImage(clData[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	-- local clImage = display.newImage(clData[1].image, display.contentWidth*0.4, display.contentHeight*0.85)
	-- local clInfo = display.newText(clData[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	-- clNext.alpha = 0
	-- clImage:toBack()
	-- clInfo:toBack()
 	
 -- 	local function tapItemClockEventListener( event )
 -- 		clNext.alpha = 1
 -- 		clInfo:setFillColor(1)
	-- 	clInfo.size = 25
	-- 	clImage:toFront()
	-- 	clInfo:toFront()
 -- 	end 

 -- 	local function tapClNeEventListener( event )
	-- 	clNext.alpha = 0
	-- 	clImage:toBack()
	-- 	clInfo:toBack()
 -- 	end 
 -- 	clNext:addEventListener("tap", tapClNeEventListener)
 -- 	item_clock:addEventListener("tap", tapItemClockEventListener)

	------ 화면전환 ------------------------------------------------------------
	local function tapRightEventListener( event )
 		print("오른쪽을 클릭했습니다")
 		composer.gotoScene('ff3.office')
 	end 
 	right:addEventListener("tap", tapRightEventListener)

 	local function tapLeftEventListener( event )
 		print("왼쪽을 클릭했습니다")
 		composer.gotoScene('ff3.class4')
 	end 
 	left:addEventListener("tap", tapLeftEventListener)

	local function tapUpEventListener( event )
 		print("위쪽을 클릭했습니다")
 		composer.gotoScene('ff4.floor4')
 	end 
 	up:addEventListener("tap", tapUpEventListener)

	local function tapDownEventListener( event )
 		print("아래쪽을 클릭했습니다")
 		composer.gotoScene('ff2.floor2')
 	end 
 	down:addEventListener("tap", tapDownEventListener)

 	-------- 클릭후 멘트 ---------------------------------------------------------------

 	local manBath = display.newRect( display.contentWidth*0.25, display.contentHeight*0.6, 150, 250)
 	local womanBath = display.newRect( display.contentWidth*0.05, display.contentHeight*0.7, 150, 170)
	
	local function tapEventListener( event )
 		print("문을 클릭했습니다")

		composer.showOverlay('ff1.locked')
 	end

 	
 	manBath:addEventListener("tap", tapEventListener)
 	womanBath:addEventListener("tap", tapEventListener)
 
--------------------------------------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
 	sceneGroup:insert(up)
 	sceneGroup:insert(down)
 	sceneGroup:insert(right)
 	sceneGroup:insert(left)
 	-- sceneGroup:insert(itemBlank)
 	-- sceneGroup:insert(boxGroup)
 	--sceneGroup:insert(inven_bg)
	--sceneGroup:insert(inventoryGroup)
 	sceneGroup:insert(manBath)
 	sceneGroup:insert(womanBath)
 	sceneGroup:insert(inven_bg)
 	sceneGroup:insert(inventoryGroup)

 	manBath:toBack()
 	womanBath:toBack()
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
		composer.removeScene("ff3.viewK")
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