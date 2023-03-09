-----------------------------------------------------------------------------------------
--
-- error.lua  / 초대 거절
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image/P/message.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local bg1 = display.newImageRect("image/P/message.png", display.contentWidth, display.contentHeight)
	bg1.x, bg1.y = display.contentWidth/2, display.contentHeight/2
	bg1.alpha = 0

	local bg2 = display.newImageRect("image/P/message.png", display.contentWidth, display.contentHeight)
	bg2.x, bg2.y = display.contentWidth/2, display.contentHeight/2
	bg2.alpha = 0

	local bg3 = display.newImageRect("image/P/message.png", display.contentWidth, display.contentHeight)
	bg3.x, bg3.y = display.contentWidth/2, display.contentHeight/2
	bg3.alpha = 0

	local message = display.newImage("image/P/schoolMessage.png")
	message.x, message.y = display.contentWidth*0.5, display.contentHeight*0.5

	local message1 = display.newImage("image/P/schoolMessage.png")
	message1.x, message1.y = display.contentWidth*0.3, display.contentHeight*0.4
	message1.alpha = 0

	local message2 = display.newImage("image/P/schoolMessage.png")
	message2.x, message2.y = display.contentWidth*0.6, display.contentHeight*0.3
	message2.alpha = 0

	local message3 = display.newImage("image/P/schoolMessage.png")
	message3.x, message3.y = display.contentWidth*0.65, display.contentHeight*0.6
	message3.alpha = 0

	local message4 = display.newImage("image/P/schoolMessage.png")
	message4.x, message4.y = display.contentWidth*0.4, display.contentHeight*0.7
	message4.alpha = 0

	local message5 = display.newImage("image/P/schoolMessage.png")
	message5.x, message5.y = display.contentWidth*0.7, display.contentHeight*0.4
	message5.alpha = 0

	local message6 = display.newImage("image/P/schoolMessage.png")
	message6.x, message6.y = display.contentWidth*0.28, display.contentHeight*0.55
	message6.alpha = 0

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(bg2)
	sceneGroup:insert(bg3)
	sceneGroup:insert(message)
	sceneGroup:insert(message1)
	sceneGroup:insert(message2)
	sceneGroup:insert(message3)
	sceneGroup:insert(message4)
	sceneGroup:insert(message5)
	sceneGroup:insert(message6)


	local messageSound = audio.loadStream( "music/message.mp3" )
	local messageSound1 = audio.loadStream( "music/message_1.mp3" )
	audio.play(messageSound, {loops = 0})

	local function tapBg( event )
		audio.play(messageSound1, {loops = 0})
		bg.alpha = 0
		bg1.alpha = 1
		message1.alpha = 1
		message2.alpha = 1
	end

	local function tapBg1( event )
		audio.play(messageSound1, {loops = 0})
		bg1.alpha = 0
		bg2.alpha = 1
		message3.alpha = 1
		message4.alpha = 1
	end

	local function tapBg2( event )
		audio.play(messageSound1, {loops = 0})
		bg2.alpha = 0
		bg3.alpha = 1
		message5.alpha = 1
		message6.alpha = 1
	end

	local function tapBg3( event )
		print("마지막 터치")
		composer.gotoScene("prologue.afterError")
	end

	bg:addEventListener("tap", tapBg)
	bg1:addEventListener("tap", tapBg1)
	bg2:addEventListener("tap", tapBg2)
	bg3:addEventListener("tap", tapBg3)

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