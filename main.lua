-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"
local json = require "json"

index = 0
cctv_flag = 0
weapon_flag = 0
PE_key_flag = 1
click_flag = 0
healthKey_flag = 0
weapon_index = 0
healthKey_index = 0
music_q = 0

-- box = display.newImage("image/UI/box.png", display.contentWidth/2, display.contentHeight*0.865)
-- nextKey = display.newImage("image/UI/next.png", display.contentWidth*0.83, display.contentHeight*0.95)

inventoryGroup = display.newGroup()

inven_bg = display.newImage(inventoryGroup, "image/UI/inven_bg.png", display.contentWidth*0.945, display.contentHeight/2)
inven_bg.alpha = 0.5

inventory = {} 
inventory_index = 0

itemGroup = display.newGroup()
items = {}
item_index = 0

for i = 1, 9 do 
	inventory[i] = display.newImage(inventoryGroup, "image/UI/inventory.png")
	inventory[i].x, inventory[i].y = display.contentWidth*0.945, display.contentHeight*0.1 + (i-1)*130
	-- items[i] = display.newImage(itemGroup, "image/P.E/weapon.png")
	-- items[i].x, items[i].y = display.contentWidth*0.945, display.contentHeight*0.1 + (i-1)*130
end

function drag ( event )
	if( event.phase == "began" ) then
		display.getCurrentStage():setFocus( event.target )
		event.target.isFocus = true

		event.target.yStart = event.target.y

	elseif( event.phase == "moved" ) then
		if( event.target.isFocus ) then
			event.target.y = event.target.yStart + event.yDelta
		end
	elseif( event.phase == "ended" or event.phase == "cancelled") then
		if( event.target.isFocus ) then
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
			-- 드래그 끝났을 때
			if(event.target.y > 100) then
				event.target.y = 0
			end
			if(event.target.y < -600) then
				event.target.y = display.contentHeight*-0.65
			end
		else
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
			contentDelta = event.target.y
		end
		-- print(event.target.x, event.target.y)
	end
end
inventoryGroup:addEventListener("touch", drag)

function tapWeapon( event )
	-- body
	local position_x = event.target.x
	local position_y = event.target.y

	print(weapon_index)

	if (click_flag == 0 and event.target == inventory[weapon_index]) then
		print("빨갛게")
		click_flag = 1
		red = display.newImage(inventoryGroup, "image/UI/inven_click.png")
		red.x = position_x
		red.y = position_y
		items[item_index] = display.newImage(itemGroup, "image/P.E/weapon.png")
		items[item_index].x, items[item_index].y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
		inventoryGroup:insert(items[item_index])
		-- local content_weapon = display.newText("[ 살인마에게 위협을 줄 수 있는 무기 ]", display.contentWidth*0.13, display.contentHeight*0.8)
		-- content_weapon.size = 25
		-- content_weapon, content_weapon.y = display.contentWidth*0.13, display.contentHeight*0.8
	elseif (click_flag == 1 and event.target == inventory[weapon_index]) then
		print("원래대로")
		click_flag = 0
		red:removeSelf()

	end
	-- event.target.x, event.target.y = display.contentWidth*0.945, display.contentHeight*0.1 + (item_index-1)*130
end

for i = 1,9 do
	inventory[i]:addEventListener("tap", tapWeapon)
end


function jsonParse ( src )
	local filename = system.pathForFile( src )

	local data, pos, msg = json.decodeFile ( filename )

	if ( data ) then
		return data
	else
		print("WARNINGS: "..pos, msg)
		return nil
	end
end	


--json parsing
-- Data = jsonParse("json/text_hall.json")
-- if Data then
-- 	print(Data[1].dialog)
-- end

-- index = 0

-- function nextScript( event )
--  	index = index + 1
--  	if(index > #Data) then 
--  		box.alpha = 0
--  		nextKey_hall.alpha = 0
--  		content.alpha = 0
--  	end
--  	if (index <= #Data) then
--  		content.text = Data[index].content
--  	end
-- end
-- nextKey_hall:addEventListener("tap", nextScript)
-- nextScript()

inventoryGroup:toFront()


-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "ff1.view1" )
end

onFirstView()	-- invoke first tab button's onPress event manually
