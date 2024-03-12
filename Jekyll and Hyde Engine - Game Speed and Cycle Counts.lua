-- Jekyll and Hyde script used for Cycle Counts/Frames between updates, game speed as a percentage
-- Displaced Gamers videos: 
--    Reprogramming Dr. Jekyll and Mr. Hyde (NES) - https://youtu.be/Gkl3Av55Yaw
--    The Wacky Frame Rate and Game Engine of Dr. Jekyll and Mr. Hyde (NES) - https://youtu.be/nZg1X5kucjc
-- Script Released: March 12, 2024
--
-- Notes: This thing is a mess - just like all DG scripts. This is cutting room floor stuff for a video... not good code.
  bgColor = 0x002060FF
  fgColor = 0x30FFFFFF
  bombRangeRed = 0x80FF4040
  bombRangeGreen = 0x9040FF40
  
  white = 0xFFFFFF
  grey = 0x808080
  red = 0xFF1010
  green = 0x10FF10
  
  solidGreen = 0x0000FF00
  currentCycleIndex = 1
  prevCycleCount = 0
  avgCycleAry= {}
  totalAvgCycles = 0
  avgCycles = 0
  
  avgCycleDenom = 10
  
  -- "Base" frame rate - 4.125
  
function round(number, decimals)
    local power = 10^decimals
    if power > 0 then
       return math.floor(number * power) / power
    else
       return 1
    end
end
  
function calcCycleAvg()
  totalAvgCycles = 0
  for i = 1, avgCycleDenom do
    if avgCycleAry[i] then
       totalAvgCycles = totalAvgCycles + avgCycleAry[i]
    end
  end
  avgCycles = totalAvgCycles / avgCycleDenom
end  
  
function updateCycleStuff()
    avgCycleAry[currentCycleIndex] = state.cpu.cycleCount - prevCycleCount
    if prevCycleCount == 0 then
      avgCycleAry[currentCycleIndex] = 0
    end 
    prevCycleCount = state.cpu.cycleCount
    currentCycleIndex = currentCycleIndex + 1
    if currentCycleIndex > avgCycleDenom then
       currentCycleIndex = 1
    end
    calcCycleAvg()
end

  
function printInfo()
  state = emu.getState()

  actionStack = emu.read(0x98,cpuDebug,false)
  testC = state.cpu.cycleCount
  t389 = emu.read(0x389,cpuDebug,false)


  HUDCoordXPos = 55
  

  
  if true then -- top box sprite coordinates
    --emu.drawRectangle(8, 8, 128, 36, bgColor, true, 1)
    --emu.drawRectangle(8, 8, 128, 36, fgColor, false, 1)
  -- Larger box
    emu.drawRectangle(8, 8, 248, 36, bgColor, true, 1)
    emu.drawRectangle(8, 8, 248, 36, fgColor, false, 1)
    framesBetweenUpdates = round(avgCycles / 29780.5,2)
    gameSpeed = round(4.125 / framesBetweenUpdates,2)
    
    -- Intro version
    if false then
       emu.drawString(12, 12, "The Number: " .. actionStack, 0xFFFFFF, 0xFF000000, 1)
    else
       emu.drawString(12, 12, "Stall Time Banks: " .. actionStack, 0xFFFFFF, 0xFF000000, 1)
       emu.drawString(12, 23, "Cycles between updates: " .. round(avgCycles,2), 0xFFFFFF, 0xFF000000, 1)
       emu.drawString(12, 34, "Frames between updates: " .. framesBetweenUpdates, 0xFFFFFF, 0xFF000000, 1)
       emu.drawString(210, 24, (gameSpeed * 100) .. "%", 0xFFFFFF, 0xFF000000, 1)
       --emu.drawString(12, 23, "Counter of Mercy: " .. t389, 0xFFFFFF, 0xFF000000, 1)
    end
  end
end

emu.addEventCallback(printInfo, emu.eventType.endFrame)

emu.addMemoryCallback(updateCycleStuff, emu.memCallbackType.cpuExec, 0xC758)