-----------------------------------------------------------------------------------------
--
-- class8.lua (3-8반, 방송실 열쇠 획득 구역)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

    --배경 설정
    local background = display.newImageRect("image/3-8.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

   
    --왼쪽 이동 키
	local left = display.newImage("image/left.png")
	left.x, left.y = display.contentWidth*0.02, display.contentHeight*0.5


   --왼쪽 키 누르면 밖으로 이동(5678.lua로 이동~)
    function left:tap( event )
		composer.hideOverlay("ff1.HealthKey")
        composer.gotoScene("ff4.5678") -- 추가
		print("5678으로 이동")
    end
    left:addEventListener("tap", left)
    
	-- 대화창
	local dialog = display.newImageRect("image/dialog.png", display.contentWidth * 0.9 , display.contentHeight * 0.6)
	dialog.x, dialog.y = display.contentCenterX * 0.9, display.contentHeight * 1.05
	local next = display.newImageRect("image/next.png", display.contentWidth * 0.044 , display.contentHeight * 0.03)
	next.x, next.y = display.contentCenterX * 1.66, display.contentHeight * 0.95

	-- json parsing
	local Data = jsonParse("json/chat.json")
	local index = 1

	script =  display.newText("", 210, 590)
	script = display.newText(Data[index].detail, 210, 590)
	script.size = 26
	script:toFront()

	function next:tap(event)
		display.remove(script.text)
		index = index + 1
		if(index <= #Data) then
			script.text = Data[index].detail
		else
			script.text = ""
			next.alpha = 0
			dialog.alpha = 0
		end		
	end
	next:addEventListener("tap", next)

    --책상 클릭하면
    function backgroundTap ( event )
        if(event.x > 250 and event.x < 380 and event.y > 400 and event.y <430) then
            print("방송실 열쇠 획득")
			item_index = item_index + 1
            inventory_index = inventory_index + 1
            items[item_index] = display.newImage(itemGroup, "image/mediakey.png")
		    items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
            mediaKey_flag = 1
			inventoryGroup:insert(items[item_index])
			mediaKey_index = item_index

            --열쇠 찾으면 채팅창 이어서 띄우기 
			local Data2 = jsonParse("json/chat2.json")	
			local index = 1
			script =  display.newText("", 210, 590)
			script = display.newText(Data2[index].detail, 210, 590)
			script.size = 26
			next.alpha = 1
			dialog.alpha = 1
			script:toFront()

			function next:tap(event)
				display.remove(script.text)
				index = index + 1
				if(index <= #Data2) then
					script.text = Data2[index].detail
				else
					script.text = ""
					next.alpha = 0
					dialog.alpha = 0
				end		
			end
			next:addEventListener("tap", next)

        end
    end
    self.view:addEventListener("tap", backgroundTap)

   sceneGroup:insert(background)
   sceneGroup:insert(left)
   sceneGroup:insert(dialog)
   sceneGroup:insert(next)
   sceneGroup:insert(script)
   sceneGroup:insert(inven_bg)
   sceneGroup:insert(inventoryGroup)
   --sceneGroup:insert(cabinet)
   --cabinet:toBack()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
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
        composer.removeScene("ff4.class8")
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
