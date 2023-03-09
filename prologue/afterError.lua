-----------------------------------------------------------------------------------------
--
-- afterError.lua  / 초대 거절
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

	local join = display.newImage("image/P/join.png")
	join.x, join.y = display.contentWidth*0.5, display.contentHeight*0.4
	join.alpha = 0

	local yes = display.newImage("image/P/yes.png")
	yes.x, yes.y = display.contentWidth*0.42, display.contentHeight*0.5
	yes.alpha = 0

	--원래 no였지만 yes로 바뀜
	local no = display.newImage("image/P/yes.png")
	no.x, no.y = display.contentWidth*0.58, display.contentHeight*0.5
	no.alpha = 0





	--텍스트 바
	local textbar = display.newImageRect("image/P/textbar.png", display.contentWidth, display.contentHeight*0.2)
	textbar.x, textbar.y = display.contentWidth*0.45, display.contentHeight*0.87
	textbar.alpha = 1

	local text = display.newText("뭐야... 왜 이래?",display.contentWidth*0.15, display.contentHeight*0.85)
	text.size = 25
	text:setFillColor(1)
	text.alpha = 1

	--텍스트 바 안에 있는 다음 버튼
	local next_button = display.newImage("image/P/next.png")
	next_button.x, next_button.y = display.contentWidth*0.9, display.contentHeight*0.95
	next_button.alpha = 1

	--텍스트 바 안에 있는 다음 버튼
	local next_button2 = display.newImage("image/P/next.png")
	next_button2.x, next_button2.y = display.contentWidth*0.9, display.contentHeight*0.95
	next_button2.alpha = 0

	sceneGroup:insert(bg)
	sceneGroup:insert(bg1)
	sceneGroup:insert(join)
	sceneGroup:insert(yes)
	sceneGroup:insert(no)
	sceneGroup:insert(textbar)
	sceneGroup:insert(text)
	sceneGroup:insert(next_button)
	sceneGroup:insert(next_button2)

	local function tapBg1( event )
		textbar.alpha = 1
		text.alpha = 1
		next_button.alpha = 1
	end

	local function tapNext( event )

		bg.alpha = 0
		bg1.alpha = 1
		text.alpha = 0

		text = display.newText("뭐야... 왜 이래?",display.contentWidth*0.15, display.contentHeight*0.85)
		text.size = 25
		text.alpha = 1
		next_button.alpha = 0
		next_button2.alpha = 1
		join.alpha = 1
	end

	local function tapNext2( event )
		text.alpha = 0
		textbar.alpha = 0
		next_button2.alpha = 0
		join.alpha = 1
		yes.alpha = 1
		no.alpha = 1
	end

	local function tapYes( event )
		yes.alpha = 0
		no.alpha = 0
		join.alpha = 0

		composer.gotoScene("prologue.prologue_3")
	end



	next_button:addEventListener("tap", tapNext)
	next_button2:addEventListener("tap", tapNext2)
	yes:addEventListener("tap", tapYes)
	no:addEventListener("tap", tapYes)
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
