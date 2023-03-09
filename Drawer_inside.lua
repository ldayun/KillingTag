-----------------------------------------------------------------------------------------
--
-- Drawer_inside.lua  1층 교무실
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/TR/Drawer_inside.jpg", display.contentWidth*0.9, display.contentHeight)
	bg.x, bg.y = display.contentWidth*0.45, display.contentHeight/2

	local bg1 = display.newImageRect("ff1/image2/TR/Drawer_inside2.jpg", display.contentWidth*0.9, display.contentHeight)
	bg1.x, bg1.y = display.contentWidth*0.45, display.contentHeight/2
	bg1.alpha = 0


	--텍스트 바
	local textbar = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)
	textbar.alpha = 0

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 0

	local text = display.newText("아싸 체육준비실 열쇠!\n체육준비실에는 뭐라도 있겠지..!", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 0

	--뒤로 가는 버튼
	local back = display.newImage("ff1/image2/back.png")
	back.x, back.y = display.contentWidth*0.5, display.contentHeight*0.94
	back.alpha = 1



	--체육준비실 키 임시 오브젝트
	local key = display.newRect(display.contentWidth*0.28, display.contentHeight*0.47, 255, 140)
	key.alpha = 0.01

	if(item_physical_key == 1) then
		bg.alpha = 0
		bg1.alpha = 1
		key.alpha = 0
	end



	--찾았다 이후의 다음 누름
	local function tapNext( event )
		textbar.alpha = 0
		text.alpha = 0
		next_button.alpha = 0
		bg.alpha = 0
		bg1. alpha = 1
		back.alpha = 1
	end

	local function tapKey( event )
		key.alpha = 0
		item_physical_key = 1
		-- item[4] = display.newImage(content, "ff1/image2/TR/physical_key.png")
		-- item[4].x, item[4].y = display.contentWidth*0.948, display.contentHeight*(0.1 + 0.175 * ( 4 - 1))
		
		print("획득")
		inventory_index = inventory_index + 1
		item_index = item_index + 1
		-- inventory[inventory_index] = display.newImage(inventoryGroup, "image/P.E/weapon.png")
		-- inventory[inventory_index].x, inventory[inventory_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (inventory_index-1)*130
		-- print(inventory_index)
		items[item_index] = display.newImage(itemGroup, "ff1/image2/TR/physical_key.png")
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		PE_key_flag = 1
		inventoryGroup:insert(items[item_index])
		PE_key_index = item_index
		
		text.alpha = 1
		textbar.alpha = 1
		next_button.alpha = 1
		back.alpha = 0
	end

	local function tapBack( event )
		composer.gotoScene("ff1.teacherRoom")
	end


	next_button:addEventListener("tap", tapNext)
	key:addEventListener("tap", tapKey)
	back:addEventListener("tap", tapBack)

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(back)
	sceneGroup:insert(textbar)
	sceneGroup:insert(next_button)
	sceneGroup:insert(text)
	sceneGroup:insert(key)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
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

				-- 기존 음악들 제거
				audio.pause( backSound )

				-- badEnding sound play
				audio.play(sound_badEnding, {loops = 0})

				composer.gotoScene("ff2.gameOver")
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