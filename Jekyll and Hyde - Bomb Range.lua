-- Jekyll and Hyde script used for Bomb collision box, coordinates, safety colors
-- Displaced Gamers videos: 
--    Reprogramming Dr. Jekyll and Mr. Hyde (NES) - https://youtu.be/Gkl3Av55Yaw
--    The Wacky Frame Rate and Game Engine of Dr. Jekyll and Mr. Hyde (NES) - https://youtu.be/nZg1X5kucjc
-- Script Released: March 12, 2024
--
-- Notes: This thing is a mess - just like all DG scripts. This is cutting room floor stuff for a video... not good code.

  bgColor = 0x102060FF
  fgColor = 0x30FFFFFF
  bombRangeRed = 0x80FF4040
  bombRangeGreen = 0x9040FF40
  
  white = 0xFFFFFF
  grey = 0x808080
  red = 0xFF1010
  green = 0x10FF10
  
  solidGreen = 0x0000FF00

function printInfo()
  state = emu.getState()

-- Original:
  bombLeftDistance = 60
  bombRightDistance = 50
  bombYRange = 48

-- Override:
--  bombLeftDistance = 30
--  bombRightDistance = 25

  
  bombXPos = emu.read(0x773,cpuDebug,false)
  bombYPos = emu.read(0x770,cpuDebug,false)
  shoulderXPos = emu.read(0x72B,cpuDebug,false)
  shoulderYPos = emu.read(0x728,cpuDebug,false)
  chestXPos = emu.read(0x72F,cpuDebug,false)
  chestYPos = emu.read(0x72C,cpuDebug,false)
  
  bombXPosLeft = bombXPos - bombLeftDistance
  bombXPosRight = bombXPos + bombRightDistance
  bombYPosTop = bombYPos - bombYRange
  bombYPosBottom = bombYPos + bombYRange

  HUDCoordXPos = 55
  
-- Font Colors
  bombColor = white
  shoulderXColor = white
  shoulderYColor = white
  chestXColor = white
  if bombYPos == 0xF0 then
    bombColor = grey
  else -- Set colors based on bomb range
    if shoulderXPos <= bombXPosLeft then
      shoulderXColor = green
    else
      shoulderXColor = red
    end
    if shoulderYPos <= bombYPosTop or shoulderYPos > bombYPosBottom then
      shoulderYColor = green
    else
      shoulderYColor = red
    end
    if chestXPos > bombXPosRight then
      chestXColor = green
    else
      chestXColor = red
    end
  end
  bombRangeColor = bombRangeRed
  if shoulderXColor == green or shoulderYColor == green or chestXColor == green then
     bombRangeColor = bombRangeGreen
  end
  
if true then -- top box sprite coordinates
  emu.drawRectangle(8, 8, 128, 36, bgColor, true, 1)
  emu.drawRectangle(8, 8, 128, 36, fgColor, false, 1)
  
  -- Labels and Commas
  emu.drawString(12, 12, "Bomb:", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(12, 20, "Shoulder:", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(12, 28, "Chest:", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(HUDCoordXPos+18, 12, ",", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(HUDCoordXPos+18, 20, ",", 0xFFFFFF, 0xFF000000, 1)
  emu.drawString(HUDCoordXPos+18, 28, ",", 0xFFFFFF, 0xFF000000, 1)

  -- Coordinates
  emu.drawString(HUDCoordXPos, 12, bombXPos, bombColor, 0xFF000000, 1)
  emu.drawString(HUDCoordXPos+22, 12, bombYPos, bombColor, 0xFF000000, 1)

  emu.drawString(HUDCoordXPos, 20, shoulderXPos, shoulderXColor, 0xFF000000, 1)
  emu.drawString(HUDCoordXPos+22, 20, shoulderYPos, shoulderYColor, 0xFF000000, 1)

  emu.drawString(HUDCoordXPos, 28, chestXPos, chestXColor, 0xFF000000, 1)
  emu.drawString(HUDCoordXPos+22, 28, chestYPos, white, 0xFF000000, 1)
end
  if bombYPos ~= 0xF0 then
     emu.drawRectangle(bombXPosLeft+1, bombYPosTop+1, bombLeftDistance+bombRightDistance, bombYPosTop+bombYPosBottom, bombRangeColor, true, 1)
     --emu.drawLine(bombXPos+1, bombYPos+1, shoulderXPos, shoulderYPos+1, solidGreen, true, 1)     
  end

end

emu.addEventCallback(printInfo, emu.eventType.endFrame)