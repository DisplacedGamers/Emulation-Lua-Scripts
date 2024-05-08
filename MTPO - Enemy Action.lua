-- Mike Tyson's Punch-Out!! 
-- Displaced Gamers videos: 
--    How do Boxers Work in Mike Tyson's Punch-Out!!? - https://youtu.be/tlKW723EOMA
--
-- Script Released: May 8, 2024
--
-- Notes: Usual cutting room floor work. Incomplete. Decent time was spent on labeling the actions.
--        Fairly accurate but could always use more testing.
--        Comment out MemoryCallbacks at bottom to suppress the various monitors.
--        Also check for various "if true/false" statements in code for showing/hiding features.

  bgColor = 0x00000000
  fgColor = 0x00FF4040
opponentPrefix = "                                                                                                "
opponentPrefix = "               "


  XChg = 54
  YChg = 60
  defDuration = 1
function printInfo()
  state = emu.getState()
  enemyROMStart = emu.readWord(0x3B,cpuDebug)
  enemyFightPatternTimer = emu.read(0x39,cpuDebug)
  enemyFightPattern = emu.read(0x38,cpuDebug)
  enemyFightPatternNext = emu.read(0x3A,cpuDebug)
  opponentHealth = emu.read(0x398,cpuDebug)
  opponentBaseX = emu.read(0xB0,cpuDebug)
  opponentBaseY = emu.read(0xB1,cpuDebug)

  if false then
    emu.drawRectangle(0, 0, 256, 22, bgColor, true, 1)
    --emu.drawRectangle(0, 0, 256, 22, fgColor, false, 1)
    --emu.drawString(12, 12, "ROM: " .. enemyROMStart, 0xFFFFFF, 0xFF000000, 1)
    --emu.drawString(12, 21, "Pattern: " ..enemyFightPattern .. " " .. enemyFightPatternTimer, 0xFFFFFF, 0xFF000000, 1)
    --emu.drawString(12, 30, "Next: " .. enemyFightPatternNext, 0xFFFFFF, 0xFF000000, 1)
    emu.drawString(161, 12, opponentHealth, 0xFFFFFF, 0x00000000, 1)
  end

    if true then -- Fight Defense Boxes  
      oppDefUR = emu.read(0xB6,cpuDebug)
      oppDefUL = emu.read(0xB7,cpuDebug)
      oppDefLR = emu.read(0xB8,cpuDebug)
      oppDefLL = emu.read(0xB9,cpuDebug)
      oppBaseX = 126 --emu.read(0xB0,cpuDebug)
      oppBaseY = 184 --emu.read(0xB1,cpuDebug)
      -- Upper Left:
      emu.drawRectangle(oppBaseX-XChg-2, oppBaseY-YChg-2, 20, 12, 0x00000000, true, defDuration)
      emu.drawString(oppBaseX-XChg, oppBaseY-YChg, oppDefUL, 0xFFFFFF, 0x00000000, defDuration)
      -- Upper Right:
      emu.drawRectangle(oppBaseX+XChg-2, oppBaseY-YChg-2, 20, 12, 0x00000000, true, defDuration)
      emu.drawString(oppBaseX+XChg, oppBaseY-YChg, oppDefUR, 0xFFFFFF, 0x00000000, defDuration)
      -- Lower Left:
      emu.drawRectangle(oppBaseX-XChg-2, oppBaseY-2, 20, 12, 0x00000000, true, defDuration)
      emu.drawString(oppBaseX-XChg, oppBaseY, oppDefLL, 0xFFFFFF, 0x00000000, defDuration)
      -- Lower Right:
      emu.drawRectangle(oppBaseX+XChg-2, oppBaseY-2, 20, 12, 0x00000000, true, defDuration)
      emu.drawString(oppBaseX+XChg, oppBaseY, oppDefLR, 0xFFFFFF, 0x00000000, defDuration)
   end
    
    fSX = 8
    fSY = 50
   if false then --- Fight Sequence
      emu.drawRectangle(4, 50, 92, 75, 0x00202020, true, 1)
      emu.drawRectangle(4, 50, 92, 75, 0x008060FF, false, 1)
      opp37 = emu.read(0x37,cpuDebug)
      opp90 = emu.read(0x90,cpuDebug)
      opp90Hex = decimalToHex(opp90)
      opp91 = emu.read(0x91,cpuDebug)
      opp91Hex = decimalToHex(opp91)
      opp92 = emu.read(0x92,cpuDebug)
      opp93 = emu.read(0x93,cpuDebug)
      opp96 = emu.read(0x96,cpuDebug)

      opp94 = emu.read(0x94,cpuDebug)
      opp94Hex = decimalToHex(opp94)
      opp95 = emu.read(0x95,cpuDebug)
      opp95Hex = decimalToHex(opp95)


      opp39 = emu.read(0x39,cpuDebug)
      
      opp3B = emu.read(0x3B,cpuDebug)
      opp3BHex = decimalToHex(opp3B)
      opp3C = emu.read(0x3C,cpuDebug)
      opp3CHex = decimalToHex(opp3C)
      
      opp31 = emu.read(0x31,cpuDebug)
      opp31Hex = decimalToHex(opp31)
      opp32 = emu.read(0x32,cpuDebug)
      opp32Hex = decimalToHex(opp32)

      opp311 = emu.read(0x311,cpuDebug)
      
     emu.drawString(fSX, fSY+(4+(0*12)), "State:", 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX+40, fSY+(4+(0*12)), "$" .. opp90Hex, 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX, fSY+(4+(1*12)), "Status:", 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX+40, fSY+(4+(1*12)), "$" .. opp91Hex, 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX, fSY+(4+(2*12)), "Table: ", 0xFFFFFF, 0xFFFFFFFF, defDuration)
     emu.drawString(fSX+40, fSY+(4+(2*12)), "$" .. opp95Hex .. opp94Hex, 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX, fSY+(4+(3*12)), "Timer:", 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX+40, fSY+(4+(3*12)), opp92, 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX, fSY+(4+(4*12)), "Index:", 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX+40, fSY+(4+(4*12)), opp93, 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX, fSY+(4+(5*12)), "Repeat:", 0xFFFFFF, 0xFFFFFFFF, defDuration) 
     emu.drawString(fSX+40, fSY+(4+(5*12)), opp96, 0xFFFFFF, 0xFFFFFFFF, defDuration) 

  --emu.drawString(fSX, fSY+(2+(0*12)), "Enemy Act Timer: " .. opp311, 0xFFFFFF, 0x90000000, defDuration)
   --emu.drawString(fSX, fSY+(2+(2*12)), "$37: " .. opp37, 0xFFFFFF, 0x90000000, defDuration)
   --emu.drawString(fSX, fSY+(2+(3*12)), "Action/Punch: " .. opp90, 0xFFFFFF, 0x90000000, defDuration)
   --emu.drawString(fSX, fSY+(2+(4*12)), " PTimer: " .. opp39, 0xFFFFFF, 0x90000000, defDuration)
  -- emu.drawString(fSX, fSY+(2+(5*12)), "Table: $" .. opp3CHex .. opp3BHex, 0xFFFFFF, 0x90000000, defDuration)
   --emu.drawString(fSX, fSY+(2+(6*12)), "Phase: $" .. opp32Hex .. opp31Hex, 0xFFFFFF, 0x90000000, defDuration)
   
   end 
    
    
    
end

function opponentLog()
  currentTbl = emu.getState()
  logStateActionStr = ""
  logStateAction = currentTbl.cpu.a
  logStateActionHex = "$" .. decimalToHex(logStateAction)
  if logStateAction >= 0x01 and logStateAction <= 0xF then
    logStateActionStr = "Set State Timer, Animation Base Index"
  elseif logStateAction >= 0x10 and logStateAction <= 0x1F then
    logStateActionStr = "Set State Timer, Animation Base Index with Opp Base XY Sprite Change"
  elseif logStateAction >= 0x20 and logStateAction <= 0x2F then
    logStateActionStr = "Set State Timer with Opponent Base Sprite XY Change"
  elseif logStateAction >= 0x30 and logStateAction <= 0x3F then
    logStateActionStr = "RNG Roll"
  elseif logStateAction >= 0x40 and logStateAction <= 0x4F then
    logStateActionStr = "Mirror Opponent Sprites with New Sprites"
  elseif logStateAction >= 0x50 and logStateAction <= 0x5F then
    logStateActionStr = "Mirror Opponent Sprites"
  elseif logStateAction >= 0x60 and logStateAction <= 0x6F then
    logStateActionStr = "Set State Timer, Opponent X,Y Offset, and Animation Flag"
  elseif logStateAction >= 0x70 and logStateAction <= 0x7F then
    logStateActionStr = "Set State Timer, Animation Segment and Timer, Opponent X,Y Offset, and Animation Flag"
  elseif logStateAction >= 0x90 and logStateAction <= 0x9F then
    logStateActionStr = "Update Array of Values in RAM"
  elseif logStateAction >= 0xA0 and logStateAction <= 0xAF then
    logStateActionStr = "Opponent is moving (ex: Getting up) - Handle Opponent XY for Frame"
  elseif logStateAction == 0x80 then
    logStateActionStr = "Set Opponent State Timer"
  elseif logStateAction == 0xE0 then
    logStateActionStr = "Change State Table ROM Location"
  elseif logStateAction == 0xE1 then
    logStateActionStr = "Restore Previous State Table ROM Location"
  elseif logStateAction == 0xE4 then
    logStateActionStr = "Copy Variable State Timer to Opponent State Timer"
  elseif logStateAction == 0xE5 then
    logStateActionStr = "Clear Opponent Punching Flag"
  elseif logStateAction == 0xE6 then
    logStateActionStr = "PPULoad0 clear bit 5"
  elseif logStateAction == 0xE7 then
    logStateActionStr = "PPULoad0 set bit 5"
  elseif logStateAction == 0xE8 then
    logStateActionStr = "Word Value Check from State Table"
  elseif logStateAction == 0xE9 then
    logStateActionStr = "Round Timer Toggle (On/Off/Halt)"
  elseif logStateAction == 0xEC then
    logStateActionStr = "Sound Engine (EC)"
  elseif logStateAction == 0xF0 then
    logStateActionStr = "Opponent Punch Status Check"
  elseif logStateAction == 0xF1 then
    logStateActionStr = "Change State Table ROM Location"
  elseif logStateAction == 0xF2 then
    logStateActionStr = "Zero Page Value Check"
  elseif logStateAction == 0xF3 then
    logStateActionStr = "Decrement Repeat Counter $96"
  elseif logStateAction == 0xF4 then
    logStateActionStr = "Set Opponent Current State = #$81"
  elseif logStateAction == 0xF5 then
    logStateActionStr = "Set Repeat Counter $96"
  elseif logStateAction == 0xF6 then
    logStateActionStr = "Set Opponent Punch Side and Damage"
  elseif logStateAction == 0xF7 then
    logStateActionStr = "Setup Opponent Defense"
  elseif logStateAction == 0xF8 then
    logStateActionStr = "Increment Mac Index twice and Set State Timer = 1"
  elseif logStateAction == 0xF9 then
    logStateActionStr = "Start Opponent Action"
  elseif logStateAction == 0xFA then
    logStateActionStr = "Write to Address/Value from State Table"
  elseif logStateAction == 0xFB then
    logStateActionStr = "Save Special Timer Value $585 into Combo Timer"
  elseif logStateAction == 0xFC then
    logStateActionStr = "Combo Timer Check"
  elseif logStateAction == 0xFE then
    logStateActionStr = "Set Opponent State Status to #$82"
  elseif logStateAction == 0xFF then
    logStateActionStr = "Decrement Opponent State Index and set Opp. State Status to #$83"
  else
    logStateActionStr = "---------------------------------------------------------------- Unknown State Command: " .. decimalToHex(logStateAction)
  end
  
  if logStateActionStr ~= "" then
     emu.log(opponentPrefix .. logStateActionStr .. " [" .. logStateActionHex .. "]")
  end
end

function compareValue()
  currentTbl = emu.getState()
  valueCheck = currentTbl.cpu.a
  valueCheckHex = decimalToHex(valueCheck)
  addressCheck = emu.readWord(0xE0,cpuDebug)
  --addressCheckHex = "$" .. decimalToHex(addressCheck)
  addressCheckHex = getRAMLabel(addressCheck)
  PRGBanks = currentTbl.cart.selectedPrgPages
  usePreFix = opponentPrefix
  if PRGBanks[0] ~= 0x08 then
    if currentTbl.cpu.pc == 33796 then
      usePreFix = ""
    end
    emu.log(usePreFix  .. "      " .. addressCheckHex .. " == $" .. valueCheckHex .. " ?")
  end
  
end

function getRAMLabel(useAddress)
  if useAddress == 0x01 then
    RAMLabel = "Opponent_ID_1"
  elseif useAddress == 0x03 then
    RAMLabel = "FightOffset_3"
  elseif useAddress == 0x04 then
    RAMLabel = "Fight_Init_4"
  elseif useAddress == 0x05 then
    RAMLabel = "KnockdownStatus_5"
  elseif useAddress == 0x06 then
    RAMLabel = "Current_Round_6"
  elseif useAddress == 0x1B then
    RAMLabel = "SprtBkgUpdt_1B"
  elseif useAddress == 0x46 then
    RAMLabel = "SpecialCrowdGraphics_46"
  elseif useAddress == 0x4A then
    RAMLabel = "ComboTimer_4A"
  elseif useAddress == 0x4B then
    RAMLabel = "ComboCountDown_4B"
  elseif useAddress == 0x50 then
    RAMLabel = "MacCurState_50"
  elseif useAddress == 0x76 then
    RAMLabel = "MacDefense1_76"
  elseif useAddress == 0x90 then
    RAMLabel = "OppCurState_90"
  elseif useAddress == 0x96 then
    RAMLabel = "OppStRepeatCntr_96"
  elseif useAddress == 0x9C then
    RAMLabel = "OppOutlineTimer_9C"
  elseif useAddress == 0xBB then
    RAMLabel = "GameStatus_BB"
  elseif useAddress == 0xBC then
    RAMLabel = "MacCanPunch_BC"
  elseif useAddress == 0xBD then
    RAMLabel = "OppLastPunchSts_BD"
  elseif useAddress == 0xD0 then
    RAMLabel = "Joy1ButtonPresses_D0"
  elseif useAddress == 0x343 then
    RAMLabel = "IncStars_343"
  elseif useAddress == 0x398 then
    RAMLabel = "Opp_Health_398"
  else
    RAMLabel = "$" .. decimalToHex(useAddress)
  end
  return RAMLabel
end

function writeValue()
  currentTbl = emu.getState()
  valueWrite = currentTbl.cpu.a
  valueWriteHex = decimalToHex(valueWrite)
  addressWrite = emu.readWord(0xE0,cpuDebug)
  --addressWriteHex = "$" .. decimalToHex(addressWrite)
  -- Replace RAM address with label if known
  addressWriteHex = getRAMLabel(addressWrite)
  emu.log(opponentPrefix .. "      Set: " .. addressWriteHex .. " = $" .. valueWriteHex)
end

function writeRepeat()
  currentTbl = emu.getState()
  repeatValue = currentTbl.cpu.a  
  repeatValueHex = decimalToHex(repeatValue)
  emu.log(opponentPrefix .. "      Repeat set to " .. repeatValue)
end

function writeOpponentAction()
  currentTbl = emu.getState()
  oppActionValue = currentTbl.cpu.a  
  oppActionValueHex = decimalToHex(oppActionValue)
  emu.log(opponentPrefix .. "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
  emu.log(opponentPrefix .. "=-=-         Opponent Action: $" .. oppActionValueHex)
  emu.log(opponentPrefix .. "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end

function MacLog()
  currentTbl = emu.getState()
  logStateActionStr = ""
  logStateAction = currentTbl.cpu.a
  PRGBanks = currentTbl.cart.selectedPrgPages
  logStateActionHex = decimalToHex(logStateAction)
  if PRGBanks[0] == 0x0B then
     if logStateAction == 0xE3 then
       logStateActionStr = "Zero Page Value Check"
     elseif logStateAction >= 0x01 and logStateAction <= 0xF then
       logStateActionStr = "Set State Timer, Animation Base Index, set $60 to #$80"
     elseif logStateAction >= 0x10 and logStateAction <= 0x1F then
       logStateActionStr = "Set State Timer, Animation Base Index and $15"
     elseif logStateAction >= 0x20 and logStateAction <= 0x2F then
       logStateActionStr = "Set State Timer, $15, and (RNG thing)"
     elseif logStateAction >= 0x30 and logStateAction <= 0x3F then
       logStateActionStr = "Mac RNG, perhaps"
     elseif logStateAction == 0x80 then
       logStateActionStr = "Load/Save State Timer from Tbl, Inc Index"
     elseif logStateAction == 0xE5 then
       logStateActionStr = "Set $99 Flag, Save Punch Type (to $74)"
     elseif logStateAction == 0xEC then
       logStateActionStr = "Sound Engine"
     elseif logStateAction == 0xF0 then
       logStateActionStr = "Unknown $F0"
     elseif logStateAction == 0xF2 then
       logStateActionStr = "Flip Mac State Status High Bit"
     elseif logStateAction == 0xF6 then
       logStateActionStr = "Set Mac Punch Damage (and more)"
     elseif logStateAction == 0xFC then
       logStateActionStr = "Mac Palette Stuff (Punch/Can't Punch)"
     elseif logStateAction == 0xFD then
       logStateActionStr = "Load/Save value from Mac State Table to $59"
     elseif logStateAction == 0xFF then
       logStateActionStr = "Dec Mac State Index, State Status to #$83"
     else
       --logStateActionStr = "Mac ($" .. logStateActionHex .. ")"
     end
     if logStateActionStr ~= "" then
        emu.log(logStateActionStr)
     end
  end
end 

function decimalToHex(num)
    if num == 0 then
        return '0'
    end
    local neg = false
    if num < 0 then
        neg = true
        num = num * -1
    end
    local hexstr = "0123456789ABCDEF"
    local result = ""
    while num > 0 do
        n = num % 16
        result = string.sub(hexstr, n + 1, n + 1) .. result
        num = math.floor(num / 16)
    end
    if neg then
        result = '-' .. result
    end
    return result
end

function writeOpponentDefense()
  oppDefUR = emu.read(0xB6,cpuDebug)
  oppDefUL = emu.read(0xB7,cpuDebug)
  oppDefLR = emu.read(0xB8,cpuDebug)
  oppDefLL = emu.read(0xB9,cpuDebug)
  emu.log(opponentPrefix .. "      Defense - Upper Left: " .. oppDefUL .. " Upper Right: " .. oppDefUR .. " Lower Left: " .. oppDefLL .. " Lower Right: " .. oppDefLR)
end

function writeMacPunchDmg()
  --macPunchDmg = emu.read(0x75,cpuDebug)
  macPunchDmg = emu.getState().cpu.a
  emu.drawRectangle(118, 216, 20, 12, 0x00000000, true, 60)
  emu.drawString(120, 218, macPunchDmg, 0xFFFFFF, 0x00000000, 60)
end

tPreStr = "     "

function TysonPhase()
  TysonCommand = emu.getState().cpu.a
  currY = emu.getState().cpu.y
  TysonCommandHex = decimalToHex(TysonCommand)
  oppActBLB = emu.read(0x3B,cpuDebug)
  oppActBLB = oppActBLB + currY
  oppActBLBHex = decimalToHex(oppActBLB)
  oppActBHB = emu.read(0x3C,cpuDebug)
  oppActBHBHex = decimalToHex(oppActBHB)
  TysonCommandText = ""
  if TysonCommand > 0 and TysonCommand <= 0x0F then
    TysonCommandText = "Punch"
  elseif TysonCommand == 0x81 then
    TysonCommandText = "Timer RNG A/B"
  elseif TysonCommand >= 0x10 and TysonCommand <= 0x1E then
    TysonCommandText = "Index RNG"
  elseif TysonCommand == 0x1F then
    TysonCommandText = "Forced Index Change"
  end
  emu.log(tPreStr .. "-----------")
  emu.log(TysonCommandText .. " [ Cmd: $" .. TysonCommandHex .. ", Addr: $" .. oppActBHBHex .. oppActBLBHex ..", Index: " .. currY .. "]")
end

function TysonPunch()
  fightPatternTimer = emu.read(0x39,cpuDebug)

  currY = emu.getState().cpu.y
  oppActBLB = emu.read(0x3B,cpuDebug)
  oppActBLB = oppActBLB + currY
  oppActBLBHex = decimalToHex(oppActBLB)
  oppActBHB = emu.read(0x3C,cpuDebug)
  oppActBHBHex = decimalToHex(oppActBHB)

  punchType = emu.getState().cpu.a
  if punchType == 0x97 then
    punchTypeStr = "Left Side Uppercut"
  elseif punchType == 0x9D then
    punchTypeStr = "Right Side Uppercut"
  end
  useAddr = " [Addr: $" .. oppActBHBHex .. oppActBLBHex .. "]"
  emu.log(tPreStr .. "-----------")
  emu.log(tPreStr .. "--  " .. punchTypeStr .. useAddr .. ", Timer set to: " .. fightPatternTimer)
  --emu.log(tPreStr .. "-----------")
end

function TysonTimerRNG()
  newTysonTimer = emu.getState().cpu.a
  currY = emu.getState().cpu.y
  oppActBLB = emu.read(0x3B,cpuDebug)
  oppActBLB = oppActBLB + currY
  oppActBLBHex = decimalToHex(oppActBLB)
  oppActBHB = emu.read(0x3C,cpuDebug)
  oppActBHBHex = decimalToHex(oppActBHB)
  
  emu.log(tPreStr .. "-----------")
  emu.log(tPreStr .. "--  Timer now: " .. newTysonTimer .. " [Addr: $" .. oppActBHBHex .. oppActBLBHex .. "]")
  --emu.log(tPreStr .. "-----------")
end

function indexJump()
  newIndex = emu.getState().cpu.a
  oppActBLB = emu.read(0x3B,cpuDebug)
  oppActBLB = oppActBLB + newIndex
  oppActBLBHex = decimalToHex(oppActBLB)
  oppActBHB = emu.read(0x3C,cpuDebug)
  oppActBHBHex = decimalToHex(oppActBHB)

  emu.log(tPreStr .. "-----------")
  emu.log(tPreStr .. "-- ***** Index Change! ***** Now: " .. newIndex .. " [Addr: $" .. oppActBHBHex .. oppActBLBHex .. "]")
  
end


function printInfo2()
  state = emu.getState()

  opp39 = emu.read(0x39,cpuDebug)
   emu.drawRectangle(50, 50, 150, 22, 0x100000FF, true, 1)    
  emu.drawRectangle(50, 50, 150, 22, 0x00FFFFFF, false, 1)
  emu.drawString(84, 57, " Phase Timer: " .. opp39, 0xFFFFFF, 0xFF000000, defDuration)
   
end


emu.addEventCallback(printInfo, emu.eventType.endFrame)
emu.addMemoryCallback(opponentLog, emu.memCallbackType.cpuExec, 0xC554)
emu.addMemoryCallback(compareValue, emu.memCallbackType.cpuExec, 0xC794)
emu.addMemoryCallback(writeValue, emu.memCallbackType.cpuExec, 0xC801)
emu.addMemoryCallback(writeRepeat, emu.memCallbackType.cpuExec, 0xC7BD)
emu.addMemoryCallback(writeOpponentAction, emu.memCallbackType.cpuExec, 0xB1C7)

-- Mac Stuff:
emu.addMemoryCallback(MacLog, emu.memCallbackType.cpuExec, 0x8330)
emu.addMemoryCallback(compareValue, emu.memCallbackType.cpuExec, 0x8404)

-- Defense and Punch Stuff:
emu.addMemoryCallback(writeOpponentDefense, emu.memCallbackType.cpuExec, 0xC7DF)
emu.addMemoryCallback(writeMacPunchDmg, emu.memCallbackType.cpuExec, 0x84FF)

-- Tyson Phase watchers
emu.addMemoryCallback(TysonPhase, emu.memCallbackType.cpuExec, 0xB1A9)
emu.addMemoryCallback(TysonPunch, emu.memCallbackType.cpuExec, 0xB1C7)
emu.addMemoryCallback(TysonTimerRNG, emu.memCallbackType.cpuExec, 0xB208)
emu.addMemoryCallback(indexJump, emu.memCallbackType.cpuExec, 0xB1D6)


emu.log("")
