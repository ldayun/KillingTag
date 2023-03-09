-----------------------------------------------------------------------------------------
--
-- office_note.lua   서랍속 노트가 있는 장면 -> 노트 읽어볼지 말지 선택지..
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Image_K/3rd_office_noteY.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local toNote = display.newRect( display.contentWidth*0.4, display.contentHeight*0.4, 400, 500 )
	local back = display.newImageRect("Image_K/note_back.png", display.contentWidth, display.contentHeight)
 	back.x, back.y = display.contentWidth/2, display.contentHeight/2
 	back.alpha = 0
 	local note = display.newImage("Image_K/note_close.png")
 	note.x, note.y = display.contentWidth*0.36, display.contentHeight/2
 	note.alpha = 0
 	local noteOp = display.newImage("Image_K/note_open.png")
 	noteOp.x, noteOp.y = display.contentWidth*0.36, display.contentHeight/2
 	noteOp.alpha = 0

 	-------- 클릭후 멘트 ---------------------------------------------------------------	
 	local Da = jsonParse("json/officeMent.json")

	local next2  = display.newImage(Da[5].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local ima2 = display.newImage(Da[5].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local inf2 = display.newText(Da[5].info, display.contentWidth*0.5, display.contentHeight*0.88)
	inf2:setFillColor(1)
	inf2.size = 25
	next2.alpha = 0
	ima2:toBack()
	inf2:toBack()

	local next  = display.newImage(Da[4].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local ima = display.newImage(Da[4].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local inf = display.newText(Da[4].info, display.contentWidth*0.5, display.contentHeight*0.88)
	inf:setFillColor(1)
	inf.size = 25

	local Data = jsonParse("json/select.json")
	local DataY = jsonParse("json/yes.json")
	local DataN = jsonParse("json/no.json")

	local yes  = display.newImage(Data[1].yes, display.contentWidth* 0.86, display.contentHeight*0.9)
	local no  = display.newImage(Data[1].no, display.contentWidth* 0.86, display.contentHeight*0.95)
	local image = display.newImage(Data[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local info = display.newText(Data[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	yes.alpha = 0
	no.alpha = 0
	image:toBack()
	info:toBack()

	local imageY = display.newImage(DataY[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local nextY  = display.newImage(DataY[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local infoY = display.newText(DataY[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	imageY:toBack()
	infoY:toBack()
	nextY.alpha = 0

	local nextN  = display.newImage(DataN[1].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local imageN = display.newImage(DataN[1].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local infoN = display.newText(DataN[1].info, display.contentWidth*0.5, display.contentHeight*0.88)
	nextN.alpha = 0
	imageN:toBack()
	infoN:toBack()
---------------------------------------------------------------------------------------------------
	------ 화면전환 ------------------------------------------------------------
	local function tapNe1EventListener( event )
 		print("다음")
	 	next.alpha = 0
	 	ima:toBack()
		inf:toBack()
	end 
 	local function tapNe2EventListener( event )
 		print("다음")
	 	next2.alpha = 1
		ima2:toFront()
		inf2:toFront()
	end 

 	local function tapTonoteEventListener( event )
 	 	print("풀린 자물쇠를 클릭했습니다")
 	 	next2.alpha = 0
		ima2:toBack()
		inf2:toBack()

 	 	back.alpha = 0.5
 	 	note.alpha = 1
 	 	info:setFillColor(1)
		info.size = 25
		toNote.alpha = 0
		yes.alpha = 1
		no.alpha = 1
		image:toFront()
		info:toFront()
 	end 

 	local function tapYesEventListener( event )
		print("다음")
		yes.alpha = 0
		no.alpha = 0
		image:toBack()
		info:toBack()
		noteOp.alpha = 1
		infoY:setFillColor(1)
		infoY.size = 25
		nextY.alpha = 1
		imageY:toFront()
		infoY:toFront()
		-- composer.gotoScene('office_noteNo')
 	end 

 	local function tapNoEventListener( event )
		print("다음")
		yes.alpha = 0
		no.alpha = 0
		image:toBack()
		info:toBack()
		infoN:setFillColor(1)
		infoN.size = 25
		nextN.alpha = 1
		imageN:toFront()
		infoN:toFront()
 	end 

	local function tapYeNextEventListener( event )
		nextY.alpha = 0
		imageY:toBack()
		infoY:toBack()
		composer.gotoScene('ff3.office_note_open')
	end
	local function tapNoNextEventListener( event )
		nextN.alpha = 0
		imageN:toBack()
		infoN:toBack()
		--item_note.alpha= 1
		--tem_note.x, item_note.y = display.contentWidth*0.928, display.contentHeight*0.1 + 130 * item_cnt
		--item_cnt = item_cnt + 1

		inventory_index = inventory_index + 1
	item_index = item_index + 1
	items[item_index] = display.newImage(itemGroup, "Image_K/note_inItem.png")
	items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
	diary_flag = 1
	inventoryGroup:insert(items[item_index])
	diary_index = item_index


		--boxGroup:insert(item_note)
		composer.gotoScene('ff3.office_noteNo')
	end

	next:addEventListener("tap", tapNe1EventListener)
	toNote:addEventListener("tap", tapNe2EventListener)
 	next2:addEventListener("tap", tapTonoteEventListener)
 	yes:addEventListener("tap", tapYesEventListener)
 	no:addEventListener("tap", tapNoEventListener)
 	nextY:addEventListener("tap", tapYeNextEventListener)
 	nextN:addEventListener("tap", tapNoNextEventListener)
------------------------------------------------------------------
	sceneGroup:insert(background) 
  	sceneGroup:insert(toNote)
  	sceneGroup:insert(back)
  	sceneGroup:insert(note)
  	sceneGroup:insert(noteOp)
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
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		timer.cancel("cctv_timer")
		composer.removeScene("ff3.office_note")
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
