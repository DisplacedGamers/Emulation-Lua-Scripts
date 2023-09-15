-- Strider scripts used for environmental collision hitboxes, triangle jump checks, jump log reporting to the console
-- Displaced Gamers videos: 
--    The Garbage Sprites in Strider (NES) - https://youtu.be/01aBYq91KnA
--    The Physics Nightmare and Bizarre Jumping of Strider (NES) - https://youtu.be/dbYQOon4z84
-- Released: September 15, 2023
--
-- Notes: This thing is a mess - just like all DG scripts. This is cutting room floor stuff for a video... not good code.

    bgColor = 0x302060FF
    fgColor = 0x30FFFFFF
function printInfo()
  --Get the emulation state
  state = emu.getState()

jumpFrameTimer = emu.read(0x527,cpuDebug,false)
lastControllerJumpAction = emu.read(0x56D,cpuDebug,false)
lastControllerJumpActionStr = ""
if lastControllerJumpAction == 128 then
  lastControllerJumpActionStr = "A"
elseif lastControllerJumpAction == 130 then
  lastControllerJumpActionStr = "Left+A"
elseif lastControllerJumpAction == 129 then
  lastControllerJumpActionStr = "Right+A"
elseif lastControllerJumpAction == 2 then
  lastControllerJumpActionStr = "Triangle Left"
elseif lastControllerJumpAction == 1 then
  lastControllerJumpActionStr = "Triangle Right"
else
  lastControllerJumpActionStr = lastControllerJumpAction
end

direction = emu.read(0x51B,cpuDebug,false)
directionStr = ""
if direction == 1 then
  directionStr = "Right"
elseif direction == 2 then
  directionStr = "Left"
end

mainYVelo = emu.read(0x515,cpuDebug,false)
FallYVelo = emu.read(0x54E,cpuDebug,false)
jumpTimer = emu.read(0x527,cpuDebug,false)

blueBoxStartXPos = 35
blueBoxYPos = 190
blueBoxWidth = 128

  emu.drawRectangle(blueBoxStartXPos, blueBoxYPos, blueBoxWidth, 45, bgColor, true, 1)
  emu.drawRectangle(blueBoxStartXPos, blueBoxYPos, blueBoxWidth, 45, fgColor, false, 1)
  emu.drawString(blueBoxStartXPos+4, blueBoxYPos+2+(9*0), " lastJump: " .. lastControllerJumpActionStr, 0xFFFFFF, 0xFF000000)
  emu.drawString(blueBoxStartXPos+4, blueBoxYPos+2+(9*1), "jumpTimer: " .. jumpTimer, 0xFFFFFF, 0xFF000000)
  emu.drawString(blueBoxStartXPos+4, blueBoxYPos+2+(9*2), " direction: " .. directionStr, 0xFFFFFF, 0xFF000000)
 -- emu.drawString(12, 131, "$54E: " .. FallYVelo , 0xFFFFFF, 0xFF000000)
-- Frame  
 -- emu.drawRectangle(68, 218, 64, 12, bgColor, true, 1)
 -- emu.drawRectangle(68, 218, 64, 12, fgColor, false, 1)
  emu.drawString(blueBoxStartXPos+4, 220, "   frame: " .. state.ppu.frameCount - 1780000, 0xFFFFFF, 0xFF000000)
  
-- Enemy positions

xCameraOffset = 0
cameraXPos = emu.read(0x53B,cpuDebug,false)
if cameraXPos < 0x80 then
  xCameraOffset = cameraXPos
else
  xCameraOffset = cameraXPos - 256
end
  enemy1XPos = emu.read(0x208,cpuDebug,false)
  enemy1YPos = emu.read(0x20B,cpuDebug,false)
  enemy2XPos = emu.read(0x248,cpuDebug,false)
  enemy2YPos = emu.read(0x24B,cpuDebug,false)
  enemy3XPos = emu.read(0x288,cpuDebug,false)
  enemy3YPos = emu.read(0x28B,cpuDebug,false)
  if false then
  emu.drawRectangle(enemy1XPos-xCameraOffset, enemy1YPos, 1, 1, 0xFF0000, false, 1)
  emu.drawRectangle(enemy2XPos-xCameraOffset, enemy2YPos, 1, 1, 0xFF0000, false, 1)
  emu.drawRectangle(enemy3XPos-xCameraOffset, enemy3YPos, 1, 1, 0xFF0000, false, 1)
  end

  striderX = emu.read(0x508,cpuDebug,false)
  striderY = emu.read(0x50B,cpuDebug,false)
end

function printJumpInfo()
  --Get the emulation state
  state = emu.getState()

jumpTimer = emu.read(0x527,cpuDebug,false)

jblueBoxYPos = 80
jblueBoxWidth = 75
jframeCountBoxX = 160 -- default: 8

  emu.drawRectangle(jframeCountBoxX, jblueBoxYPos, jblueBoxWidth, 20, bgColor, true, 1)
  emu.drawRectangle(jframeCountBoxX, jblueBoxYPos, jblueBoxWidth, 20, fgColor, false, 1)

  emu.drawString(jframeCountBoxX+4, jblueBoxYPos+2+(9*0), "jumpTimer: " .. jumpTimer, 0xFFFFFF, 0xFF000000)



end

function showBox()
  boxX = emu.read(0x508,cpuDebug,false)
  boxY = emu.read(0x50B,cpuDebug,false)
  frontCollide = emu.read(0x553,cpuDebug,false)
  emu.drawRectangle(boxX-1, boxY-1, 3, 3, 0xFF0000, false, 1)
  emu.drawRectangle(boxX, boxY, 1, 1, 0xFFFFFF, false, 1)
  frontCollideStr = ""
  if frontCollide ~= 0 then
    --frontCollideStr = " collision!"
  end
  --emu.log(boxX .. "," .. boxY .. frontCollideStr)
end

function showBoxSingle()
  boxX = emu.read(0x508,cpuDebug,false)
  boxY = emu.read(0x50B,cpuDebug,false)
  tempState = emu.getState()
  if tempState.cart.selectedPrgPages[0] == 1 then
    emu.drawRectangle(boxX-1, boxY-1, 3, 3, 0x20A0FF, false, 10)
    emu.drawRectangle(boxX, boxY, 1, 1, 0xFFFFFF, false, 10)
  end
end

function superHeelCheck()
  -- Add new box for heel kick
  tempHeelState = emu.getState()
  heelKickIndex = heelKickIndex + 1
  heelBoxTimer = 100
  heelColor[heelKickIndex-1] = 0xFF0000
  if tempHeelState.cpu.a ~= 0 then
    heelColor[heelKickIndex-1] = 0x00FF00
  end
  heelBoxX[heelKickIndex-1] = emu.read(0x508,cpuDebug,false)
  heelBoxY[heelKickIndex-1] = emu.read(0x50B,cpuDebug,false)
  heelBoxYCameraInt[heelKickIndex-1] = emu.read(0x53E,cpuDebug,false)
  heelBoxYCameraPage[heelKickIndex-1] = emu.read(0x53F,cpuDebug,false)
  --emu.drawRectangle(boxX-2, boxY-2, 5, 5, 0x00FF00, true, 200)
  --emu.drawRectangle(boxX, boxY, 1, 1, 0x000000, true, 200)
end

function drawSuperHeelKicks()
    xCameraOffset = 0
    cameraXPos = emu.read(0x53B,cpuDebug,false)
    cameraYPos = emu.read(0x53E,cpuDebug,false)
    cameraYPage = emu.read(0x53F,cpuDebug,false)
    if cameraXPos < 0x80 then
      xCameraOffset = cameraXPos
    else
      xCameraOffset = cameraXPos - 256
    end  
   if heelBoxTimer > 0 then
     for i = 0, heelKickIndex-1 do -- Camera Paging and Int offsets for X&Y not fully implemented 
       yCameraOffset = ((heelBoxYCameraInt[i] - cameraYPos) + (((heelBoxYCameraPage[i] - cameraYPage) * 240)))
       emu.drawRectangle(heelBoxX[i]-2-xCameraOffset+32, heelBoxY[i]-2+yCameraOffset, 5, 5, heelColor[i], true, 1)
       emu.drawRectangle(heelBoxX[i]-xCameraOffset+32, heelBoxY[i]+yCameraOffset, 1, 1, 0x000000, true, 1)
     end
     heelBoxTimer = heelBoxTimer - 1
   else
     heelKickIndex = 0
   end
end

function reportJump()
  cameraX = emu.read(0x53B,cpuDebug,false)
  cameraY = emu.read(0x53E,cpuDebug,false)
  lastStriderXInt = emu.read(0x508,cpuDebug,false)
  lastStriderXFrac = emu.read(0x507,cpuDebug,false)
  lastStriderXStr = lastStriderXInt + (lastStriderXFrac / 256)
  lastStriderYInt = emu.read(0x50B,cpuDebug,false)
  lastStriderYFrac = emu.read(0x50A,cpuDebug,false)
  lastStriderYStr = lastStriderYInt + (lastStriderYFrac / 256)
  --lastJumpFrame = emu.read(0x527,cpuDebug,false)
  lastFrameRendered = emu.read(0x04B,cpuDebug,false)
  lastFrameAcknowledged = emu.read(0x04C,cpuDebug,false)
  appliedVeloStr = appliedVeloInt + (appliedVeloFrac / 256)
  if appliedVeloInt >= 127 then
    appliedVeloStr = ((256 - appliedVeloInt) * -1) + (appliedVeloFrac / 256)
  end
  
  
--  logFrames = "" .. "F:[" .. lastFrameRendered .. "/" .. lastFrameAcknowledged .."]  "
  logFrames = "" .. "F:[" .. lastFrameAcknowledged .."]  "
  cameraFrames = ""-- "  Camera:(" .. cameraX .. "," .. cameraY .. ") "
  if lastJumpFrame ~= 0 or fallYVeloInt ~= 0 or fallYVeloFrac ~= 0 then
     emu.log("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
     emu.log(logFrames .. "   End Frame Strider X:" .. lastStriderXStr .. "   Y:" .. lastStriderYStr .. cameraFrames .. 
     "      JumpFrame:" .. lastJumpFrame 
    -- .. " (" .. offsetStr .. ")"
     .. "  LookUp YVelo: " .. appliedVeloStr)
     if useGravityCompensationStr ~= "" then -- Gravity Compensated
        emu.log(useGravityCompensationStr)
     end
     if useprocessingSkippedStr ~= "" then -- Physics bypassed report
        emu.log(useprocessingSkippedStr)
     end
     if fallVeloUsedStr ~= "" then -- Report fall velo
        emu.log(fallVeloUsedStr)
     end
     if false and useRptStr ~= "" then -- Extra report stuff
        emu.log(useRptStr)
     end
     lastJumpFrame = emu.read(0x527,cpuDebug,false) -- Override hack
  end
  useGravityCompensationStr = ""
  useprocessingSkippedStr = ""
  useRptStr = ""
  fallVeloUsedStr = ""
  offsetStr = "N/A"
  appliedVeloInt = 0
  appliedVeloFrac = 0
  fallYVeloInt = 0
  fallYVeloFrac = 0
  
end

function setProcessingSkipped()
  tempState = emu.getState()
  if tempState.cart.selectedPrgPages[0] == 1 then
     useprocessingSkippedStr = "   *** Some physics were bypassed. ***"
  end
end

function getCurrentJump()
  lastJumpFrame = emu.read(0x527,cpuDebug,false)
  appliedVeloInt = emu.read(0x515,cpuDebug,false)
  appliedVeloFrac = emu.read(0x514,cpuDebug,false)
  --  fallVelo = emu.read(0x54E,cpuDebug,false)
end

function getCurrentJumpVeloOffset()
  offsetStr = "N/A"
  tempState = emu.getState()
  if tempState.cart.selectedPrgPages[0] == 1 then
     offsetStr = "" .. tempState.cpu.y
  end  
end

function getCurrentFall()
  fallYVeloInt = emu.read(0x54E,cpuDebug,false)
  fallYVeloFrac = emu.read(0x54D,cpuDebug,false)
  tempAppliedVeloInt = emu.read(0x515,cpuDebug,false)
  tempAppliedVeloFrac = emu.read(0x514,cpuDebug,false)
  fallVeloUsedStr = fallYVeloInt + (fallYVeloFrac / 256)
  if fallYVeloInt >= 127 then
    fallVeloUsedStr = ((256 - fallYVeloInt) * -1) + (fallYVeloFrac / 256)
  end
  tempAppliedVeloStr = tempAppliedVeloInt + (tempAppliedVeloFrac / 256)
  if tempAppliedVeloInt >= 127 then
    tempAppliedVeloStr = ((256 - tempAppliedVeloInt) * -1) + (tempAppliedVeloFrac / 256)
  end
  fallVeloUsedStr = "           Using Fall Velo: " .. fallVeloUsedStr .. " with applied velo of: " .. tempAppliedVeloStr
end

function getCurrentwithGravity()
  appliedVelowGravityInt = emu.read(0x515,cpuDebug,false)
  appliedVelowGravityFrac = emu.read(0x514,cpuDebug,false)
  appliedVelowGravityStr = appliedVelowGravityInt + (appliedVelowGravityFrac / 256)
  if appliedVelowGravityInt >= 127 then
    appliedVelowGravityStr = ((256 - appliedVelowGravityInt) * -1) + (appliedVelowGravityFrac / 256)
  end
  --appliedVelowGravityStr = appliedVelowGravityStr .. " " .. appliedVelowGravityFrac
  useGravityCompensationStr = "           w/ Gravity Compensation of +1.5: " .. appliedVelowGravityStr
end


function reportEnvMoments()
  tempState = emu.getState()
  if tempState.cart.selectedPrgPages[0] == 1 then -- Bank 1 stuff
    if tempState.cpu.pc == 0x9397 and tempState.cpu.a ~= 0 then
      useRptStr = useRptStr .. "\n             - Strider front toe collision. Potential jump stop."
    elseif tempState.cpu.pc == 0x93B1 then
      useRptStr = useRptStr .. "\n             - Erase Fall Velocity. Check Heel and Lower Ground Center"
    elseif tempState.cpu.pc == 0x93BE then
      useRptStr = useRptStr .. "\n             - Heel and Lower Ground Center = No Collision. Clear jump frames. Stop lateral movement."
    end
  end
end

if false then -- blue box
   emu.addEventCallback(printInfo, emu.eventType.endFrame);
end

if false then -- jump counter close-up
   emu.addEventCallback(printJumpInfo, emu.eventType.endFrame);
end 
 
if true then -- illustrate collision boxes
-- All targets
emu.addMemoryCallback(showBox, emu.memCallbackType.cpuExec, 0xDF96) -- Front inside env check function

--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x93EB) -- Just top front -> 553
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x8FA2) -- Lower Ground Center -> 54C
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0xA174) -- ALSO Lower Ground Center -> 54C
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x9397) -- Front Toe -> 55A
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x8AD6) -- Front Heel 6px -> 55E
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0xA18F) -- Lower Ground Far Front -> 562
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x8F4D) -- Front Shin during Jump -> 50D
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x8AD6) -- Front Heel Check for $500 = $88?? -> 55E
--emu.addMemoryCallback(showBoxSingle, emu.memCallbackType.cpuExec, 0x8842) -- Wall ejection logic check
end

if true then -- show heel kicks
  emu.addMemoryCallback(superHeelCheck, emu.memCallbackType.cpuExec, 0x9829) -- Super Heel Check
  emu.addEventCallback(drawSuperHeelKicks, emu.eventType.endFrame);
end

--emu.addMemoryCallback(showBox, emu.memCallbackType.cpuExec, 0x9824) -- Just top front
--emu.addMemoryCallback(showBox, emu.memCallbackType.cpuExec, 0xE00E) --All points


-- Report right wall collision
if false then
   emu.addMemoryCallback(reportEnvMoments, emu.memCallbackType.cpuExec, 0x9397) -- Toe jump stop
   emu.addMemoryCallback(reportEnvMoments, emu.memCallbackType.cpuExec, 0x93B1) -- Collide with wall during jump
   emu.addMemoryCallback(reportEnvMoments, emu.memCallbackType.cpuExec, 0x93BE) -- Collide with wall during jump
end

--Jump Velo Logger
lastJumpFrame = 0
appliedVeloInt = 0
appliedVeloFrac = 0
fallYVeloInt = 0
fallYVeloFrac = 0
lastStriderY = 0
lastStriderX = 0
useGravityCompensationStr = ""
useprocessingSkippedStr = ""
useRptStr = ""
offsetStr = "N/A"

-- Heel kick stuff for Triangle Jump
heelKickIndex = 0
heelBoxTimer = 0
heelBoxX = {}
heelBoxY = {}
heelColor = {}
heelBoxYCameraInt = {}
heelBoxYCameraPage = {}

if false then -- illustrate jumping quirks
--emu.addEventCallback(reportJump, emu.eventType.endFrame)
emu.addMemoryCallback(reportJump, emu.memCallbackType.cpuExec, 0xC169)
--emu.addMemoryCallback(getCurrentJump, emu.memCallbackType.cpuExec, 0x9A44)
--emu.addMemoryCallback(getCurrentJump, emu.memCallbackType.cpuExec, 0x9007)
emu.addMemoryCallback(getCurrentJump, emu.memCallbackType.cpuExec, 0x994B)
emu.addMemoryCallback(getCurrentJumpVeloOffset, emu.memCallbackType.cpuExec, 0x9924)
emu.addMemoryCallback(getCurrentwithGravity, emu.memCallbackType.cpuExec, 0x9007)
emu.addMemoryCallback(getCurrentFall, emu.memCallbackType.cpuExec, 0x9129)
emu.addMemoryCallback(setProcessingSkipped, emu.memCallbackType.cpuExec, 0x83BD)
end

-- Notes
-- Running into a wall during a jump will clear the frame count and X Velo @ $93BE, Bank $01.
-- <Temp note>: This MIGHT be triggered by a low, off-body collision point.

function showTriangleJumpCheck()
  lastFrameRendered = emu.read(0x04B,cpuDebug,false)
  tempState = emu.getState()
  if tempState.cart.selectedPrgPages[0] == 1 then -- Bank 1 stuff
     emu.log(lastFrameRendered .. "  Triangle Jump Check")
  end
end

--emu.addMemoryCallback(showTriangleJumpCheck, emu.memCallbackType.cpuExec, 0x97D3)

