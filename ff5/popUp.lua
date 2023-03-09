-----------------------------------------------------------------------------------------
--
-- popUp.lua
-- 
--
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--
-- locked.lua
-- '문이 잠겨있음' 창
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	
	local num = composer.getVariable("num")
    
    if(num == 1) then
        text = display.newText("다른 책장을 확인하세요.", display.contentCenterX, 350)    
	elseif(num == 2) then
		text = display.newText("[그 신의 이름은 아브라삭스]", display.contentCenterX, 350)    
	elseif(num == 3) then
		text = display.newText("금색의 열쇠가 사용되었습니다.", display.contentCenterX, 350)
	elseif(num == 4) then
		text = display.newText("쇠절단기를 획득하였습니다.", display.contentCenterX, 350)
	elseif(num == 5) then
		text = display.newText("금색의 열쇠를 획득하였습니다.", display.contentCenterX, 350)
	elseif(num == 6) then
		text = display.newText("잠겨 있습니다.", display.contentCenterX, 350)
	elseif(num == 7) then
		text = display.newText("문이 잠겨있습니다.", display.contentCenterX, 350)
    end

	text.x, text.y = display.contentWidth/2, display.contentHeight*0.3
 	text.size = 33
 	text:setFillColor(0)
 	text.alpha = 1

 	local background = display.newRect(display.contentWidth/2, display.contentHeight*0.3, display.contentWidth/3, display.contentHeight*0.15, 20)
 	background.strokeWidth = 10
	background:setStrokeColor(0)
 	background:setFillColor(1)
 	background.alpha = 0.4

 	sceneGroup:insert(background)
 	sceneGroup:insert(text)
 	
 	function text:tap( event )
 		-- local timeAttack = composer.getVariable("timeAttack")
 		-- timer.resume(timeAttack)
 		composer.hideOverlay('ff1.locked')
 	end
 	text:addEventListener("tap", text)

 	sceneGroup:insert(background)
 	sceneGroup:insert(text)
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
		composer.removeScene("ff1.locked")
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

------------------------------------------------------------------------------------------
return scene