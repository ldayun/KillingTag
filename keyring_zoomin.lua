-----------------------------------------------------------------------------------------
--
-- view3.lua
-- 복도 세번째 뷰
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    local background = display.newImageRect("image/F1_keyring_zoomin.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local left = display.newImage("image/UI/left.png", display.contentWidth*0.03, display.contentHeight/2)
	
	local right = display.newImage("image/UI/right.png", display.contentWidth*0.85, display.contentHeight/2)

    -- 대사창
	local dialog = display.newImageRect("image/dialog.png", display.contentWidth * 0.9 , display.contentHeight * 0.6)
	dialog.x, dialog.y = display.contentCenterX * 0.9, display.contentHeight * 1.05
	-- 대사창 다음버튼
	local next = display.newImageRect("image/next.png", display.contentWidth * 0.044 , display.contentHeight * 0.03)
	next.x, next.y = display.contentCenterX * 1.66, display.contentHeight * 0.95
	
    local yes = display.newImageRect("image/yes.png", display.contentWidth * 0.026 , display.contentHeight * 0.03)
    yes.x, yes.y = display.contentCenterX * 1.50, display.contentHeight * 0.95
	yes.alpha = 0
    local no = display.newImageRect("image/no.png", display.contentWidth * 0.044 , display.contentHeight * 0.03)
    no.x, no.y = display.contentCenterX * 1.66, display.contentHeight * 0.95
	no.alpha = 0
 
    
    local Data = jsonParse("json/keyring.json")
	-- script
    local index = 1
	script =  display.newText("", 210, 590)

	script = display.newText( Data[index].script, 210, 590)
	script.size = 26
    print(getKeyring)
	--event-----------------------------------------------------------------
	function left:tap( event )
		composer.gotoScene("ff1.view3")
	
	end
	left:addEventListener("tap", left)

    function next:tap(event)
		print(getKeyring)
        display.remove(script.text)
        index = index + 1
		--index = index + 1
		if(index <= 2) then
			script.text = Data[index].script, 210, 590
			script.size = 26
            yes.alpha = 1
            no.alpha = 1
            next.alpha = 0
        else
			script.text = ""
			dialog.alpha = 0
			next.alpha = 0

		end
    end
    next:addEventListener("tap", next)

    function yes:tap(event)
		print("키링클릭")
		
        getKeyring = 1
		print(getKeyring)

		--print("획득")
		--inventory_index = inventory_index + 1
		items[item_index] = display.newImage(itemGroup, "image/item_Keyring.png")
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + item_index*130
		inventoryGroup:insert(items[item_index])
		keyring_index = item_index
		
		keyring_flag = 1
		item_index = item_index + 1

		dialog.alpha = 0
		next.alpha = 0

        composer.gotoScene("ff1.keyring_empty")
    end
    yes:addEventListener("tap", yes)

    function no:tap(event)
        getKeyring = 0
        script.text ="찝찝하네.. 두고가자.."
		index = index + 1
		no.alpha = 0
		yes.alpha = 0
		next.alpha = 1
    end
    no:addEventListener("tap", no)

	sceneGroup:insert(background)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
    sceneGroup:insert(dialog)
    sceneGroup:insert(next)
    sceneGroup:insert(yes)
    sceneGroup:insert(no)
    sceneGroup:insert(script)
	sceneGroup:insert(inven_bg)
	sceneGroup:insert(inventoryGroup)
	sceneGroup:insert(itemGroup)

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
		composer.removeScene("ff1.keyring_zoomin")
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
