-----------------------------------------------------------------------------------------
--
-- office_note_open.lua    교무실 서랍 노트 열어보는 선택지
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
 	back.alpha = 0.5
 	local note = display.newImage("Image_K/note_inside.png")
 	note.x, note.y = display.contentWidth*0.5, display.contentHeight/2

 	-------- 클릭후 멘트 ---------------------------------------------------------------	
	local DataY = jsonParse("json/yes.json")

	local imageY = display.newImage(DataY[2].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local nextY  = display.newImage(DataY[2].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local infoY = display.newText(DataY[2].info, display.contentWidth*0.5, display.contentHeight*0.88)
	imageY:toBack()
	infoY:toBack()
	nextY.alpha = 0

	local imageY2 = display.newImage(DataY[3].image, display.contentWidth*0.5, display.contentHeight*0.9)
	local nextY2  = display.newImage(DataY[3].next, display.contentWidth* 0.86, display.contentHeight*0.95)
	local infoY2 = display.newText(DataY[3].info, display.contentWidth*0.5, display.contentHeight*0.88)
	imageY2:toBack()
	infoY2:toBack()
	nextY2.alpha = 0
---------------------------------------------------------------------------------------------------	
	------ 화면전환 ------------------------------------------------------------

 	local function tapNoteEventListener( event )
 	 	print("노트를 클릭했습니다")
 	 	infoY:setFillColor(1)
		infoY.size = 25
		imageY:toFront()
		infoY:toFront()
		nextY.alpha = 1
 	end 

	local function tapNextEventListener( event )
		imageY:toBack()
		infoY:toBack()
		nextY.alpha = 0

		infoY2:setFillColor(1)
		infoY2.size = 25
		imageY2:toFront()
		infoY2:toFront()
		nextY2.alpha = 1
	end
	local function tapNext2EventListener( event )
		imageY2:toBack()
		infoY2:toBack()
		nextY2.alpha = 0
		--item_note.alpha = 1
		--item_note.x, item_note.y = display.contentWidth*0.928, display.contentHeight*0.1 + 130 * item_cnt
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

	note:addEventListener("tap", tapNoteEventListener)
	nextY:addEventListener("tap", tapNextEventListener)
	nextY2:addEventListener("tap", tapNext2EventListener)
------------------------------------------------------------------
	sceneGroup:insert(background)
  	sceneGroup:insert(toNote)
  	sceneGroup:insert(back)
  	sceneGroup:insert(note)
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
		composer.removeScene("ff3.office_note_open")
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
