-----------------------------------------------------------------------------------------
--
-- chat.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- CONTENT
	local chatbox =  display.newImage("image/dialog.png")
	--display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight
	chatbox.x , chatbox.y = display.contentWidth*0.5, display.contentHeight*0.9
	chatbox.alpha = 1

	local next = display.newImage("image/dialog_next.png")
	next.x , next.y = display.contentWidth*0.86, display.contentHeight*0.95
	next.alpha = 1


	--안에 들어갈 대사
	local content = display.newText("솰라솰라 불라불라", display.contentWidth*0.5, display.contentHeight*0.88)
	content:setFillColor(1)
	content.size = 25

	-- json에서 정보 읽기
	
	local Data = jsonParse( "json/chat.json" )
	if Data then
		print(Data[1].detail)
	end

	-- json에서 읽은 정보 적용하기

	local index = 0

	local function nextScript( event )
		index = index + 1
		if(index > #Data) then 
			composer.gotoScene("ff4.class8") 
			return
		end
		content.text = Data[index].detail
	end
	next:addEventListener("tap", nextScript)

	nextScript()

	sceneGroup:insert(chatbox)
	sceneGroup:insert(next)
	sceneGroup:insert(content)



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
		composer.removeScene("ff4.chat")
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
