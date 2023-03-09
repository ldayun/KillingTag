-----------------------------------------------------------------------------------------
--
-- lock.lua
-- 캐비닛 비밀번호 맞추기
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local counter, timeAttack_adm

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view
	
	--display

	local background = display.newImageRect("image/P.E/lock.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--방향키	
	local back = display.newImage("image/UI/left.png", display.contentWidth*0.04, display.contentHeight*0.5)

	--설정
	local setting = display.newImage("image/UI/setting.png", display.contentWidth*0.04, display.contentHeight*0.06)
	--버튼

	local btnGroup = display.newGroup()
	local btn = {}
	local Xposition = {}
	local Yposition = {}

	for i = 1, 12 do
		btn[i] = display.newImage(btnGroup, "image/P.E/button/btn["..i.."].jpg")
		if ( i >= 1 and i <= 3 ) then
			btn[i].x, btn[i].y = display.contentWidth*0.3+i*128, display.contentHeight*0.23
			Xposition[i] = btn[i].x
			Yposition[i] = btn[i].y
		elseif ( i >= 4 and i <= 6) then
			btn[i].x, btn[i].y = i*128, display.contentHeight*0.404
			Xposition[i] = btn[i].x
			Yposition[i] = btn[i].y
		elseif ( i>= 7 and i <= 9) then
			btn[i].x, btn[i].y = i*128 - 384, display.contentHeight*0.58
			Xposition[i] = btn[i].x
			Yposition[i] = btn[i].y
		else
			btn[i].x, btn[i].y = i*128-768, display.contentHeight*0.76
			Xposition[i] = btn[i].x
			Yposition[i] = btn[i].y
		end
	end
	btnGroup.x = btnGroup.x + 5

	-- --인벤토리
	-- local inven_bg= display.newImage("image/UI/inven_bg.png", display.contentWidth*0.945, display.contentHeight/2)
	-- inven_bg.alpha = 0.5

	-- local inventoryGroup = display.newGroup()
	-- local inventory = {} 

	-- for i = 1, 9 do 
	-- 	inventory[i] = display.newImage(inventoryGroup, "image/UI/inventory.png")
	-- 	inventory[i].x, inventory[i].y = display.contentWidth*0.945, display.contentHeight*0.1 + (i-1)*130
	-- end

	local clickGroup = display.newGroup()
	local click = {}

	local answerGroup = {}
	local answer = {}
	
	for i = 1, 12 do
		click[i] = display.newImage(clickGroup, "image/P.E/button/btn["..i.."]_clicked.jpg")
		click[i].alpha = 0
	end

	--json 불러오기
	local Data = jsonParse("json/locker.json")
	if Data then
		print(Data[1].dialog)
	end

	--json 적용하기

	----------------------------------event
	function back:tap( event )
		print("축소하고 캐비닛 전체 보기")
		composer.gotoScene("ff1.cabinet")
	end
	back:addEventListener("tap", back)

	local index = 0

	function btn_click( event )
		-- body
		local xStart = event.target.x
		local yStart = event.target.y


		local c = event.target
		c.alpha = 0

		if (c == btn[1]) then
			click[1].alpha = 1
			click[1].x, click[1].y = Xposition[1] + 5, Yposition[1]

			index = index + 1
			answer[index] = 1
			print(index)
			print(answer[index])
		elseif (c == btn[2]) then
			click[2].alpha = 1
			click[2].x, click[2].y = Xposition[2] + 5, Yposition[2]

			index = index + 1
			answer[index] = 2
			print(index)
			print(answer[index])
		elseif (c == btn[3]) then
			click[3].alpha = 1
			click[3].x, click[3].y =  Xposition[3] + 5, Yposition[3]

			index = index + 1
			answer[index] = 3
			print(index)
			print(answer[index])
		elseif (c == btn[4]) then
			click[4].alpha = 1
			click[4].x, click[4].y =  Xposition[4] + 5, Yposition[4]

			index = index + 1
			answer[index] = 4
			print(index)
			print(answer[index])
		elseif (c == btn[5]) then
			click[5].alpha = 1
			click[5].x, click[5].y =  Xposition[5] + 5, Yposition[5]

			index = index + 1
			answer[index] = 5
			print(index)
			print(answer[index])
		elseif (c == btn[6]) then
			click[6].alpha = 1
			click[6].x, click[6].y =  Xposition[6] + 5, Yposition[6]

			index = index + 1
			answer[index] = 6
			print(index)
			print(answer[index])
		elseif (c == btn[7]) then
			click[7].alpha = 1
			click[7].x, click[7].y =  Xposition[7] + 5, Yposition[7]

			index = index + 1
			answer[index] = 7
			print(index)
			print(answer[index])
		elseif (c == btn[8]) then
			click[8].alpha = 1
			click[8].x, click[8].y =  Xposition[8] + 5, Yposition[8]

			index = index + 1
			answer[index] = 8
			print(index)
			print(answer[index])
		elseif (c == btn[9]) then
			click[9].alpha = 1
			click[9].x, click[9].y =  Xposition[9] + 5, Yposition[9]

			index = index + 1
			answer[index] = 9
			print(index)
			print(answer[index])
		elseif (c == btn[10]) then
			click[10].alpha = 1
			click[10].x, click[10].y =  Xposition[10] + 5, Yposition[10]

			index = index + 1
			answer[index] = 10
			print(index)
			print(answer[index])
		elseif (c == btn[11]) then
			click[11].alpha = 1
			click[11].x, click[11].y =  Xposition[11] + 5, Yposition[11]

			index = index + 1
			answer[index] = 11
			print(index)
			print(answer[index])
		elseif (c == btn[12]) then
			click[12].alpha = 1
			click[12].x, click[12].y =  Xposition[12] + 5, Yposition[12]

			index = index + 1
			answer[index] = 12
			print(index)
			print(answer[index])
		end
		if (answer[1] == 1 and answer[2] == 5 and answer[3] == 6 and answer[4] == 4) then
			print("정답")
			print(weapon_flag)
			if (weapon_flag == 1) then
				print("이미옴")
				composer.gotoScene("ff1.cabinet_get")
			else
				print("처음맞춤")
				composer.gotoScene("ff1.cabinet_opened")
			end
		end
	end
	for i = 1, 12 do
		btn[i]:addEventListener("tap", btn_click)
	end

	function backToOriginal( event )
		-- body
		local xStart = event.target.x
		local yStart = event.target.y


		local c = event.target
		c.alpha = 0

		if (c == click[1]) then
			btn[1].alpha = 1
			btn[1].x, btn[1].y = Xposition[1], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[2]) then
			btn[2].alpha = 1
			btn[2].x, btn[2].y = Xposition[2], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[3]) then
			btn[3].alpha = 1
			btn[3].x, btn[3].y = Xposition[3], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[4]) then
			btn[4].alpha = 1
			btn[4].x, btn[4].y = Xposition[4], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[5]) then
			btn[5].alpha = 1
			btn[5].x, btn[5].y = Xposition[5], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[6]) then
			btn[6].alpha = 1
			btn[6].x, btn[6].y = Xposition[6], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[7]) then
			btn[7].alpha = 1
			btn[7].x, btn[7].y = Xposition[7], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[8]) then
			btn[8].alpha = 1
			btn[8].x, btn[8].y = Xposition[8], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[9]) then
			btn[9].alpha = 1
			btn[9].x, btn[9].y = Xposition[9], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[10]) then
			btn[10].alpha = 1
			btn[10].x, btn[10].y = Xposition[10], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[11]) then
			btn[11].alpha = 1
			btn[11].x, btn[11].y = Xposition[11], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		elseif (c == click[12]) then
			btn[12].alpha = 1
			btn[12].x, btn[12].y = Xposition[12], yStart

			answer[index] = nil
			index = index - 1

			print(index)
			print(answer[index])
		end
	end

	for i = 1, 12 do
		click[i]:addEventListener("tap", backToOriginal)
	end


	
	sceneGroup:insert(background)
	sceneGroup:insert(setting)
	sceneGroup:insert(back)
	-- sceneGroup:insert(box)
	-- sceneGroup:insert(nextKey)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	sceneGroup:insert(btnGroup)
	sceneGroup:insert(clickGroup)

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
		composer.removeScene("ff1.lock")
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