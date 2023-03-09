-----------------------------------------------------------------------------------------
--
-- epilogue.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--에필로그 음악 추가
	local backSound = audio.loadStream( "music/epilogue.mp3" )
	audio.play(backSound, {loops = 0})

	--에필로그 애니메이션
	local sheetOptions =
	{
		--3000px, height: 14592px
		width = 600,
		height = 304,
		numFrames = 240
	}

	local sheet_ep = graphics.newImageSheet( "image/mysheet.png", sheetOptions )
	
	local sequences_sheet = {
		-- consecutive frames sequence
		{
			name = "normalRun",
			start = 1,
			count = 240,
			time = 24000,
			loopCount = 1,
			loopDirection = "forward"
		}
	}
	local epilogue = display.newSprite( sheet_ep, sequences_sheet)
	epilogue:scale( display.contentWidth / 570, display.contentHeight / 310 )
	epilogue.x, epilogue.y = display.contentCenterX, display.contentCenterY
	
	--[[
	local function spriteListener( event )
		print( event.name, event.target, event.phase, event.target.sequence )
	end
	-- Add sprite listener
	runningCat:addEventListener( "sprite", spriteListener )

	local function spriteListener( event )

		local thisSprite = event.target  -- "event.target" references the sprite
		thisSprite:began()  -- play the new sequence
	end
	-- add the event listener to the sprite
	runningCat:addEventListener( "sprite", spriteListener )

	]]
	epilogue:play()

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