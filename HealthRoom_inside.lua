-----------------------------------------------------------------------------------------
--
-- Healthroom_inside.lua  보건실 안
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("ff1/image2/Health/HealthRoom.jpg", display.contentWidth*0.9, display.contentHeight)
	bg.x, bg.y = display.contentWidth*0.45, display.contentHeight/2

	local bg1 = display.newImageRect("ff1/image2/Health/MedicineChest.jpg", display.contentWidth*0.9, display.contentHeight)
	bg1.x, bg1.y = display.contentWidth*0.45, display.contentHeight/2
	bg1.alpha = 0


	--복도로 가는 버튼
	local back = display.newImage("ff1/image2/back.png")
	back.x, back.y = display.contentWidth*0.5, display.contentHeight*0.94
	back.alpha = 1


	local Chest1 = display.newImage("ff1/image2/chest_1.png")
	Chest1.x,Chest1.y = display.contentWidth*0.47, display.contentHeight/2
	Chest1.alpha=0

	local Chest2 = display.newImage("ff1/image2/chest_2.png")
	Chest2.x,Chest2.y = display.contentWidth*0.47, display.contentHeight/2
	Chest2.alpha=0

	local Chest3 = display.newImage("ff1/image2/chest_3.png")
	Chest3.x,Chest3.y = display.contentWidth*0.47, display.contentHeight/2
	Chest3.alpha=0



	--약 선반 터치를 위한 임시 오브젝트
	local medicineChest = display.newRect(display.contentWidth*0.83, display.contentHeight*0.57, 150, 450)
	medicineChest.alpha = 0.01

	--약장을 열기 위한 임시 오브젝트
	local open= display.newRect(display.contentWidth*0.46, display.contentHeight*0.5, 500, 660)
	open.alpha = 0

	--약장을 닫기 위한 임시 오브젝트
	local close= display.newRect(display.contentWidth*0.46, display.contentHeight*0.5, 500, 660)
	close.alpha = 0

	--보건실로 다시 가기 위한 임시 오브젝트
	local goBack= display.newRect(display.contentWidth*0.46, display.contentHeight*0.5, 500, 660)
	goBack.alpha = 0

	--붕대 터치를 위한 임시 오브젝트
	local bandage = display.newRect(display.contentWidth*0.42, display.contentHeight*0.37, 60, 80)
	bandage.alpha = 0


	--텍스트 바
	local textbar = display.newImage("ff1/image2/textbar.png", display.contentWidth/2, display.contentHeight*0.9)
	textbar.alpha = 0

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("ff1/image2/next.png")
	next_button.x, next_button.y = display.contentWidth*0.86, display.contentHeight*0.95
	next_button.alpha = 0

	local text = display.newText("혹시 모르니까 챙겨두자..", display.contentWidth*0.5, display.contentHeight*0.88)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 0

	--처음 약장 터치
	local function tapChest( event )
		bg.alpha = 0
		bg1.alpha = 1
		medicineChest.alpha = 0
		open.alpha =0.01
		back.alpha = 0
		print("약장 터치됨")
	end

	--약장 열리기
	local function tapOpen( event )
		open.alpha = 0
		Chest1.alpha = 1
		bandage.alpha = 0.01
		print("약장 열림")
	end

	--밴드 챙기기
	local function tapBandage( event )
		print("붕대터치")
		textbar.alpha = 1
		text.alpha = 1
		next_button.alpha = 1
		getBandage = 1
		bandage_flag = 1
	end


	--텍스트창 넘기기
	local function tapNext( event )
		textbar.alpha = 0
		text.alpha = 0
		next_button.alpha = 0

		Chest1.alpha = 0
		Chest2.alpha = 1
		bandage.alpha = 0
		close.alpha =0.01

		--인벤토리에 붕대모양 표시
		--item_bandage = 1
		--item[2] = display.newImage(content, "ff1/image2/bandage.png")
		--item[2].x, item[2].y = display.contentWidth*0.948, display.contentHeight*(0.1 + 0.175 * ( 2 - 1))
		--print("붕대 챙김")
		print("획득")
		inventory_index = inventory_index + 1
		item_index = item_index + 1
		-- inventory[inventory_index] = display.newImage(inventoryGroup, "image/P.E/weapon.png")
		-- inventory[inventory_index].x, inventory[inventory_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (inventory_index-1)*130
		-- print(inventory_index)
		items[item_index] = display.newImage(itemGroup, "image/bandage.png")
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		bandage_flag = 1
		inventoryGroup:insert(items[item_index])
		bandage_index = item_index
	end


	--약장 닫기
	local function tapClose( event )
		close.alpha = 0
		goBack.alpha = 0.01
		Chest3.alpha = 1
		Chest2.alpha = 0
		print("약장 닫힘")
		back.alpha = 1
	end

	--원래창으로
	local function tapRoom( event )
		Chest3.alpha = 0
		bg1.alpha = 0
		bg.alpha = 1
		goBack.alpha = 0
	end





	--복도로 가기
	local function tapBack( event )
		back.alpha = 0
		composer.gotoScene("ff1.view2")
	end

	medicineChest:addEventListener("tap", tapChest)
	open:addEventListener("tap", tapOpen)
	bandage:addEventListener("tap", tapBandage)
	close:addEventListener("tap", tapClose)
	back:addEventListener("tap", tapBack)
	goBack:addEventListener("tap", tapRoom)
	next_button:addEventListener("tap", tapNext)

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(medicineChest)
	sceneGroup:insert(open)
	sceneGroup:insert(bandage)
	sceneGroup:insert(close)
	sceneGroup:insert(goBack)
	sceneGroup:insert(next_button)
	sceneGroup:insert(back)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		----------------------------------행정실 사망 루트
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
		composer.removeScene("Healthroom_inside")
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