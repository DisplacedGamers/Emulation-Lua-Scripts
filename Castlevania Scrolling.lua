

  bgColor = 0x402060FF
  green = 0x8000FF00
  red = 0x80FF0000
  white = 0x80FFFFFF
  fgColor = 0x10FFFFFF
  purple = 0x80BF40BF
  yellow = 0xFFFF00
  fullGreen = 0x00FF00
  fullRed = 0xFF0000
  fullPurple = 0xBF40BF
  
blockColor = green
tileRefreshColor = purple
tileRefreshColorText = fullPurple

function drawTileBoxes()

  cameraXPositionUpd = emu.readWord(0x2E,cpuDebug)
  getLeftTile = emu.read(0x36,cpuDebug)
  getRightTile = emu.read(0x35,cpuDebug)
  useDirectionTile = ""
  scrollDirection = emu.read(0x4B,cpuDebug)
  directionLetter = ""
  if scrollDirection == 0 then
     blockCounter = emu.read(0x30,cpuDebug)
     directionLetter = "R"
     useDirectionTile = getRightTile
  elseif scrollDirection == 1 then
     blockCounter = emu.read(0x31,cpuDebug)
     directionLetter = "L"
     useDirectionTile = getLeftTile
  end

  if blockCounter > 0 and blockCounter < 7 then
    i = blockCounter
    blockYPos = (i * 32)
    blockHeight = 32
    if i == 1 then -- Special Case (short block)
      blockYPos = 32 + 16
      blockHeight = 16
    end
    blockXPos = 256-32
    if scrollDirection == 1 then
      blockXPos = 0
    end
    if true then
      emu.drawRectangle(blockXPos, blockYPos, 32, blockHeight, tileRefreshColor, true, 40,1)
      emu.drawRectangle(blockXPos, blockYPos, 32, blockHeight, white, false, 40,1)
      emu.drawString(blockXPos+4, blockYPos+4,blockCounter,0xFFFFFF,0x000000,40,1)
    else
      emu.drawRectangle(blockXPos, blockYPos, 32, blockHeight, white, true, 16,1)
      emu.drawRectangle(blockXPos, blockYPos, 32, blockHeight, white, false, 16,1)
      emu.drawString(blockXPos+4, blockYPos+4,blockCounter,0xFFFFFF,0x000000,16,1)
    end
  end
  if blockCounter == 6 then
    if blockColor == green then
      blockColor = red
    else
      blockColor = green
    end
  end  
  if blockCounter > 0 and blockCounter < 7 then
     emu.log(useDirectionTile .. " - " .. directionLetter .. blockCounter .. "  (XPos: " .. cameraXPositionUpd .. ")")
  end
  
end

function printInfo()
  --Get the emulation state
  state = emu.getState()
  XOffset = 50
  L1 = 8
  L2 = 8 + (9*1)
  L3 = 8 + (9*2)
  
  cameraXPosition = emu.readWord(0x2E,cpuDebug)
  tileRefreshCutoff = emu.read(0x3B,cpuDebug)
  if tileRefreshCutoff == 0 then
    tileRefreshCutoffStr = "A"
    tileRefreshColor = purple
    tileRefreshColorText = fullPurple
  elseif tileRefreshCutoff == 32 then
    tileRefreshCutoffStr = "B"
    tileRefreshColor = green
    tileRefreshColorText = fullGreen
  end

  leftmostTile = emu.read(0x36,cpuDebug)
  rightmostTile = emu.read(0x35,cpuDebug)
  TileMap1Address = emu.readWord(0x37,cpuDebug)
  TileMap2Address = emu.readWord(0x39,cpuDebug)
  blockCounter = emu.read(0x30,cpuDebug)
  frameCounter = emu.read(0x1A,cpuDebug)

  printText = true
  showBookend = true
  showBlockCounter = true
  showTileRefresh = true
  if printText then
    emu.drawRectangle(0, 0, 256, 48, 0x000000, true, 1,1)
    emu.drawRectangle(XOffset+4, 4, 100, 34, bgColor, true, 1,1)
    emu.drawRectangle(XOffset+4, 4, 100, 34, fgColor, false, 1,1)
    emu.drawString(XOffset+8, L1, "Camera XPos: " .. cameraXPosition, 0xFFFFFF, 0xFF000000, 1,1)
    if showBlockCounter then
       emu.drawString(XOffset+8, L2, "Block Counter: " .. blockCounter, 0xFFFFFF, 0xFF000000, 1,1)
    end
    if showTileRefresh then
       if true then
          emu.drawString(XOffset+8, L3, "Tile Refresh: " .. tileRefreshCutoffStr, tileRefreshColorText, 0xFF000000, 1,1)
       else
          emu.drawString(XOffset+8, L3, "Tile Refresh: " .. tileRefreshCutoff, 0xFFFFFF, 0xFF000000, 1,1)
       end
    end

    if showBookend then
      emu.drawString(16, L1, "Left", 0xFFFFFF, 0xFF000000, 1,1)
      emu.drawString(8, L2, "Bookend: ", 0xFFFFFF, 0xFF000000, 1,1)
      emu.drawString(20, L3+4, leftmostTile, 0xFFFFFF, 0x000000, 1,1)

      emu.drawString(200+16, L1, "Right", 0xFFFFFF, 0xFF000000, 1,1)
      emu.drawString(200+8, L2, "Bookend: ", 0xFFFFFF, 0xFF000000, 1,1)
      emu.drawString(220, L3+4, rightmostTile, 0xFFFFFF, 0x000000, 1,1)
    end
  end
  
  showFrameCounter = false
  frameCounterXOffset = 108
  if showFrameCounter then
    emu.drawRectangle(XOffset+frameCounterXOffset, 4, 46, 34, bgColor, true, 1,1)
    emu.drawRectangle(XOffset+frameCounterXOffset, 4, 46, 34, fgColor, false, 1,1)
    emu.drawString(XOffset+frameCounterXOffset+4, L1, "Frame", 0xFFFFFF, 0xFF000000, 1,1)
    emu.drawString(XOffset+frameCounterXOffset+4, L2, "Counter:", 0xFFFFFF, 0xFF000000, 1,1)
    emu.drawString(XOffset+frameCounterXOffset+12, L3, frameCounter, 0xFFFFFF, 0xFF000000, 1,1)
  end

end

--Register some code (printInfo function) that will be run at the end of each frame
emu.addEventCallback(printInfo, emu.eventType.endFrame)

doDrawTileBoxes = true
if doDrawTileBoxes then
   emu.addMemoryCallback(drawTileBoxes, emu.memCallbackType.cpuExec, 0xF67A)
end
