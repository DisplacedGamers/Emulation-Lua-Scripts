-- Castlevania Critical Hit with the Whip
-- Displaced Gamers video: https://youtu.be/hfIka7Z73Zw
-- Released: November 4th, 2022
--
-- Notes: Might be some leftover code for drawing hitboxes. It is likely incomplete.


function whipBox()
  if false then
  tempWhipLength = emu.read(0x73,cpuDebug)
  tempWhipHeight = emu.read(0x74,cpuDebug)
  tempWhipXPos = emu.read(0x68,cpuDebug)
  tempWhipYPos = emu.read(0x69,cpuDebug)

  theTable = emu.getState()
  objXPos = emu.read(0x38C + theTable.cpu.x,cpuDebug)
  objYPos = emu.read(0x354 + theTable.cpu.x,cpuDebug)
  xDiff = objXPos - tempWhipXPos
  if xDiff < 0 then
    xDiff = (xDiff * -1) + 1
  end
  yDiff = objYPos - tempWhipYPos
  if yDiff < 0 then
    yDiff = (yDiff * -1) + 1
  end

  variousWidth = emu.read(0x4C,cpuDebug)
  variousHeight = emu.read(0x4D,cpuDebug)
  
  emu.log("xCheck: " .. xDiff .. " < " .. variousWidth)
  emu.log("yCheck: " .. yDiff .. " < " .. variousHeight)
  
  -- Whip Pos
  emu.drawRectangle(tempWhipXPos-1, tempWhipYPos-1, 3, 3, green, true, 120,1)
  emu.drawRectangle(tempWhipXPos, tempWhipYPos, 1, 1, red, true, 120,1)
  emu.drawRectangle(tempWhipXPos-tempWhipLength, tempWhipYPos-tempWhipHeight, (2*tempWhipLength)+1, (2*tempWhipHeight)+1, yellow, false, 120,1)
  -- Object Pos
  emu.drawRectangle(objXPos-1, objYPos-1, 3, 3, green, true, 120,1)
  emu.drawRectangle(objXPos, objYPos, 1, 1, red, true, 120,1)
  
  emu.drawString(objXPos-60, objYPos - 50, "( X: " .. xDiff .. " < " .. variousWidth .. " )" , 0xFFFFFF, 0x80000000, 120,1)
  emu.drawString(objXPos-60, objYPos - 41, "( Y: " .. yDiff .. " < " .. variousHeight .. " )" , 0xFFFFFF, 0x80000000, 120,1)
  end
end

function printInfo()
  --Get the emulation state
  state = emu.getState()
    bgColor = 0x102060FF
    fgColor = 0x30FFFFFF
    green = 0x3000FF00
    red = 0x30FF0000
    yellow = 0x30FFFF00
  
  --cameraXPos = emu.read(0x4F,cpuDebug)
  --cameraYPos = emu.readWord(0x51,cpuDebug)
-- 553 (In Air Attack)
-- 
  
  whipLength = emu.read(0x73,cpuDebug)
  whipHeight = emu.read(0x74,cpuDebug)
  whipTimer = emu.read(0x568,cpuDebug)
  whipLevel = emu.read(0x70,cpuDebug)
  inAirAttack = emu.read(0x54C,cpuDebug)
  
  fivesixty = emu.read(0x560,cpuDebug)
  sevenA = emu.read(0x7A,cpuDebug)
  fourseventythree = emu.read(0x473,cpuDebug)
  fiftysixF = emu.read(0x56F,cpuDebug)
  fourtyeightF = emu.read(0x48F,cpuDebug)
  genericTimer5 = emu.read(0x553,cpuDebug)
  whipDamageFrameFlag = emu.read(0x5C,cpuDebug)

  draculaHealth = emu.read(0x1A9,cpuDebug)
  whipXPos = emu.read(0x68,cpuDebug)
  whipYPos = emu.read(0x69,cpuDebug)
  simonMirrored = emu.read(0x450,cpuDebug)
  woundedTimer = emu.read(0x5B,cpuDebug)
  
  simonStatus = emu.read(0x434,cpuDebug)
  simonStatusStr = ""
  if simonStatus == 1 then
    simonStatusStr = "Standing Whip"
  elseif simonStatus == 2 then
    simonStatusStr = "Ducking Whip"
  elseif simonStatus == 3 then
    simonStatusStr = "Jumping Whip"
  elseif simonStatus == 0x81 then
    simonStatusStr = "Standing Subweapon"
  elseif simonStatus == 0x83 then
    simonStatusStr = "Jumping Subweapon"
  elseif simonStatus ~= 0 then
    simonStatusStr = "" .. simonStatus
  end

  simonState = emu.read(0x46C,cpuDebug)
  simonStateStr = ""
  if simonState == 0 then
    simonStateStr = "Walking"
  elseif simonState == 1 then
    simonStateStr = "Jumping/Air Attack"
  elseif simonState == 2 then
    simonStateStr = "Ground Attack"
  elseif simonState == 3 then
    simonStateStr = "Ducking"
  elseif simonState == 4 then
    simonStateStr = "Climbing Stairs"
  elseif simonState == 5 then
    simonStateStr = "Knocked Back "
    if inAirAttack ~= 255 then
      simonStateStr = simonStateStr .. " " .. inAirAttack
    end
  elseif simonState == 6 then
    simonStateStr = "Approach Stairs"
  elseif simonState == 7 then
    simonStateStr = "Dropping"
  elseif simonState == 8 then
    simonStateStr = "Dead"
  elseif simonState == 9 then
    simonStateStr = "Stunned "
    if inAirAttack ~= 255 then
      simonStateStr = simonStateStr .. " " .. inAirAttack
    end
  elseif simonState ~= 0 then
    simonStateStr = "" .. simonState
  end


HoriOffset = 2  
VertOffset = 54
VLineDist = 9
V1 = VertOffset 
V2 = VertOffset + (1 * VLineDist)
V3 = VertOffset + (2 * VLineDist)
V4 = VertOffset + (3 * VLineDist)
V5 = VertOffset + (4 * VLineDist)
V6 = VertOffset + (5 * VLineDist)


emu.drawRectangle(HoriOffset, VertOffset-4, 170, 60, bgColor, true, 1)
emu.drawRectangle(HoriOffset, VertOffset-4, 170, 60, fgColor, false, 1)
  
  emu.drawString(8, V2, "Whip[L" .. whipLevel .. "] "  .. whipXPos .. "," .. whipYPos, 0xFFFFFF, 0xFF000000, 1)
  for i=1, whipTimer do
    useWhipTimerColor = green
    if i == 0x11 then
      useWhipTimerColor = red
    end
    emu.drawRectangle(8+(4*(i-1)),V1,4,7,useWhipTimerColor,true,1)
  end
  if whipDamageFrameFlag == 0 then
     emu.drawString(88, V2, "*", red, 0xFF000000, 1)
  end

  -- Draw whip box
  if whipLength ~= 0 and whipHeight ~= 0 and whipXPos ~= 0 and whipYPos ~= 0 and false then
      useWhipXPos = whipXPos
    if simonMirrored == 0 then
      useWhipXPos = whipXPos - whipLength
    end
    emu.drawRectangle(useWhipXPos,whipYPos,whipLength,whipHeight,red,false,1)
  end

  --emu.drawString(12, 21, "560: " .. fivesixty .. " 7A: " .. sevenA .. " State: " .. fourseventythree, 0xFFFFFF, 0xFF000000, 1)
  --emu.drawString(12, 30, "56F: " .. fiftysixF .. " 48F: " .. fourtyeightF .. " Timer: " .. genericTimer5, 0xFFFFFF, 0xFF000000, 1)
  --emu.drawString(12, 39, "5C: " .. fiveC , 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(8, V3, " L:" .. whipLength .. " H:" .. whipHeight, 0xFFFFFF, 0xFF000000, 1)
  
  emu.drawString(8, V4, "Simon Action: ", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(74, V4, simonStateStr , 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(8, V5, "Simon Attack: ", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(74, V5, simonStatusStr , 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(8, V6, "Timer1: " .. inAirAttack , 0xFFFFFF, 0xFF000000, 1)
  if woundedTimer ~= 0 then
     emu.drawString(74, V3, "* Recovering * " .. woundedTimer, yellow, 0xFF000000, 1)
  end

  emu.drawString(72, V6, "Dracula Health: " .. draculaHealth , 0xFFFFFF, 0xFF000000, 1)
  --emu.drawString(12, 21, "Height: " .. whipHeight , 0xFFFFFF, 0xFF000000, 1)
  


end

--Register some code (printInfo function) that will be run at the end of each frame
emu.addEventCallback(printInfo, emu.eventType.endFrame)
--emu.addMemoryCallback(whipBox, emu.memCallbackType.cpuExec, 0xE53E)
emu.addMemoryCallback(whipBox, emu.memCallbackType.cpuExec, 0xE512)
