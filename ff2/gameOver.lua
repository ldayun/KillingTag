-----------------------------------------------------------------------------------------
--
-- gameOver.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
 	local background = display.newImageRect("image/gameOver.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local retry = display.newImage("image/retry.png")
	retry.x, retry.y = display.contentWidth*0.4, display.contentHeight*0.85

	local function tapRetry( event )
	 	composer.gotoScene("prologue.prologue_2")
	end
	retry:addEventListener("tap", tapRetry)

	local home = display.newImage("image/home2.png")
	home.x, home.y = display.contentWidth*0.6, display.contentHeight*0.85

	local function tapHome( event )
		composer.gotoScene("prologue.prologue_1")
	end
	home:addEventListener("tap", tapHome)

	sceneGroup:insert(background)
	sceneGroup:insert(retry)
	sceneGroup:insert(home)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		playTimeText.alpha = 0
   		end_dialog.alpha = 0
   		end_dialogButton.alpha = 0
   		end_text.alpha = 0

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
		--타이머 제거 (한시간)
		timer.cancel("playTimeAttack")
		--인벤토리초기화
		for i = 1, #items do
			items[i]:removeSelf()
		end
		item_index = 0
		--flag 초기화
		count_flag = 1
		contentDelta = 0

		bg_on = 1
		se_on = 1

		--view1 대화 플래그
		view1_flag = 0

		cctv_flag = 0
		--빠루
		weapon_flag = 0
		weapon_index = 0
		weapon_click_flag = 0

		--체육준비실열쇠
		PE_key_flag = 0
		PE_key_index = 0
		PE_key_click_flag = 0

		--교문열쇠
		gate_key_flag = 0
		gate_key_index = 0
		gate_key_click_flag = 0

	--보건실열쇠
		healthKey_flag = 0
		healthKey_index = 0
		healthKey_click_flag = 0

		--붕대
		bandage_flag = 0
		bandage_index = 0
		bandage_click_flag = 0

	--키링
		keyring_flag = 0
		keyring_index = 0
		keyring_click_flag = 0

		--마이크
		mic_flag = 0
		mic_index = 0
		mic_click_flag = 0

		-- 쇠절단기
		cutter_flag = 0 
		cutter_index = 0 
		cutter_click_flag = 0 

		-- 금색열쇠
		goldkey_flag = 0
		goldkey_index = 0
		goldkey_click_flag = 0

		--시계
		clock_flag = 0
		clock_index = 0
		clock_click_flag = 0

		--다이어리
		diary_flag = 0
		diary_index = 0
		diary_click_flag = 0

		--가위
		scissors_flag = 0
		scissors_index = 0
		scissors_click_flag = 0

		getKeyring = 0
		getBandage = 0

		--방송실 열쇠
		mediaKey_flag = 0
		mediaKey_index = 0
		mediaKey_click_flag = 0
		
		--scene초기화
		--프롤로그
		composer.removeScene("prologue.afterError")
		composer.removeScene("prologue.error")
		composer.removeScene("no")
		composer.removeScene("prologue.prologue_1")
		composer.removeScene("prologue.prologue_2")
		composer.removeScene("prologue.prologue_3")
		composer.removeScene("prologue.prologue_school")
		--1층
		composer.removeScene("ff1.adm")
		composer.removeScene("ff1.cabinet")
		composer.removeScene("ff1.cabinet_get")
		composer.removeScene("ff1.cabinet_opened")
		composer.removeScene("ff1.cctv_af")
		composer.removeScene("ff1.cctv_bf")		
		composer.removeScene("ff1.cctv_off")
		composer.removeScene("ff1.cctv_on")
		composer.removeScene("ff1.Drawer.closeup")
		composer.removeScene("ff1.Drawer_inside")
		composer.removeScene("ff1.drawer_open")
		composer.removeScene("ff1.Drawer_password")
		composer.removeScene("ff1.drawer_zoom")
		composer.removeScene("ff1.gate")
		composer.removeScene("ff1.HealthKey")
		composer.removeScene("ff1.HealthRoom")		
		composer.removeScene("ff1.HealthRoom_inside")
		composer.removeScene("ff1.keyring_empty")
		composer.removeScene("ff1.keyring_zoomin")
		composer.removeScene("ff1.lock")-- Called when the scene is on screen and is about to move off screen
		composer.removeScene("ff1.locked")
		composer.removeScene("ff1.main")		
		composer.removeScene("ff1.MusicRoom")
		composer.removeScene("ff1.PE")
		composer.removeScene("ff1.teacherRoom")
		composer.removeScene("ff1.TeacherRoom_drawer")
		composer.removeScene("ff1.view1")
		composer.removeScene("ff1.view2")
		composer.removeScene("ff1.view3")
		composer.removeScene("ff1.view3_2")
		composer.removeScene("ff1.view4")
		composer.removeScene("ff1.view5")
		--2층
		composer.removeScene("ff2.artRoom")
		composer.removeScene("ff2.blackout")
		composer.removeScene("ff2.floor2")
		composer.removeScene("ff2.gameOver")
		composer.removeScene("ff2.heal_question")
		composer.removeScene("ff2.studio")
		--3층
		composer.removeScene("ff3.class")
		composer.removeScene("ff3.class2")
		composer.removeScene("ff3.class4")
		composer.removeScene("ff3.class4_in")
		composer.removeScene("ff3.office")
		composer.removeScene("ff3.office_desk")
		composer.removeScene("ff3.office_in")
		composer.removeScene("ff3.office_lock")
		composer.removeScene("ff3.office_note")
		composer.removeScene("ff3.office_note_open")
		composer.removeScene("ff3.office_noteNo")
		composer.removeScene("ff3.office_unlock")
		composer.removeScene("ff3.viewK")
		--4층
		composer.removeScene("ff4.123")
		composer.removeScene("ff4.5678")
		composer.removeScene("ff4.chat")
		composer.removeScene("ff4.chat2")
		composer.removeScene("ff4.class4")
		composer.removeScene("ff4.class8")
		composer.removeScene("ff4.floor4")
		composer.removeScene("ff4.item")
		composer.removeScene("ff4.notice")
		composer.removeScene("ff4.open")
		composer.removeScene("ff4.toilet")
		--5층
		composer.removeScene("ff5.bookShelf")
		composer.removeScene("ff5.cabinet")
		composer.removeScene("ff5.desk")
		composer.removeScene("ff5.drawer")
		composer.removeScene("ff5.F5_1")
		composer.removeScene("ff5.F5_2")
		composer.removeScene("ff5.F5_3")
		composer.removeScene("ff5.F5_4")
		composer.removeScene("ff5.F5_5")
		composer.removeScene("ff5.itemShelf")
		composer.removeScene("ff5.lab1")
		composer.removeScene("ff5.lib")
		composer.removeScene("ff5.popUp")
		composer.removeScene("ff5.preLab")

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