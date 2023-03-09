-----------------------------------------------------------------------------------------
--
-- heal_question.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- badEnding sound
local sound_badEnding = audio.loadStream( "music/bad_ending.m4a" )

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0)
	background.alpha = 0.8

	local heal = display.newImage("image/heal.png")
	heal.x, heal.y = display.contentWidth*0.5, display.contentHeight*0.5

	local yes = display.newImage("image/yes.png")
	yes.x, yes.y = display.contentWidth*0.4, display.contentHeight*0.55

	local function tapYes( event )
		composer.hideOverlay("ff2.heal.question")
	end
	yes:addEventListener("tap", tapYes)

	local no = display.newImage("image/no.png")
	no.x, no.y = display.contentWidth*0.6, display.contentHeight*0.55

	local function tapNo( event )
		composer.hideOverlay("ff2.heal.question")

		-- 1시간짜리 타이머 제거
		--timer.cancel(timeAttack)

		-- 기존 음악들 제거
		audio.stop(back_sound)

		-- badEnding sound play
		audio.play(sound_badEnding, {loops = 0})

		composer.gotoScene("ff2.gameOver")
	end
	no:addEventListener("tap", tapNo)

	sceneGroup:insert(background)
	sceneGroup:insert(heal)
	sceneGroup:insert(yes)
	sceneGroup:insert(no)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
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