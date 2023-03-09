-----------------------------------------------------------------------------------------
--
-- view3.lua
-- 복도 세번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    local background = display.newImageRect("image/empty.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local left = display.newImage("image/UI/left.png", display.contentWidth*0.03, display.contentHeight/2)
	
	local right = display.newImage("image/UI/right.png", display.contentWidth*0.85, display.contentHeight/2)
    -- 대사창
    --local dialog = display.newImageRect("image/dialog.png", display.contentWidth * 0.9 , display.contentHeight * 0.6)
    --dialog.x, dialog.y = display.contentCenterX * 0.9, display.contentHeight * 1.05
     -- 대사창 다음버튼
    --local next = display.newImageRect("image/next.png", display.contentWidth * 0.044 , display.contentHeight * 0.03)
    --next.x, next.y = display.contentCenterX * 1.66, display.contentHeight * 0.95
 
    local Data = jsonParse("json/keyring.json")
	-- script
    local index = 1
	-- script =  display.newText("", 210, 590)

	-- script = display.newText( Data[index].script, 210, 590)
	-- script.size = 26
    
   -- function next:tap(event)
		--print(getKeyring)
        --display.remove(script.text)
		--index = index + 1
		--if(index <= #Data) then
		--	script.text = Data[index].script, 210, 590
		--	script.size = 26
        --else
            --dialog.alpha = 0
            --next.alpha = 0
            --script.alpha = 0
		--end
    --end
    --next:addEventListener("tap", next)

	function left:tap( event )
        print("3 이동")
        if(getKeyring == 1) then
            composer.gotoScene("ff1.view3_2")
        else
		    composer.gotoScene("ff1.view3")
        end
	end
	left:addEventListener("tap", left)


	sceneGroup:insert(background)
    --sceneGroup:insert(next)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
    --sceneGroup:insert(dialog)
    --sceneGroup:insert(next)
    --sceneGroup:insert(script)
    
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)


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

	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene("ff1.keyring_empty")
		inventoryGroup.y = 0
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
