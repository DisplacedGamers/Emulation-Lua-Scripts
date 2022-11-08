# Emulation-Lua-Scripts
Scripts used during production of Displaced Gamers videos - https://www.youtube.com/c/DisplacedGamers

Lua is the language used for scripting in several emulators. This includes Mesen - the emulator used during video production for DG.

Scripts are used to illustrate values, draw hitboxes, etc. during emulation of the current game being featured.

These scripts are built as a means to an end. Why write a nice loop when you can just copy and paste the same thing ten times? With one segment of video complete, why not hack up what was written for it and adapt it for the next segment?

This is not good code. These scripts are best described as "after math aftermath."

Nevertheless, perhaps they can be adapted and improved in order to be used as a proper learning tool.

A few notes:
1: Most of these were written under the final release of Mesen - version 0.9.9 from early 2020. I do not feel that the lua engine is as feature-heavy as it could be? Perhaps FCEUX offers more on this front. As of this readme, I have yet to try Mesen-X.

2: Even with bank switch checking/direct ROM addressing, etc., I couldn't get the script to address the proper place in the ROM when I wanted to reference a LUT. I don't *think* it is a syntax issue on my part, so I copied and pasted large chunks of the ROM into the script and separated the values with commas in order to load them up.

3: Some scripts from previous videos are straight-up missing. I think I saved over a script for a previous video while working on a new one at various times.

4: Please don't ask about obtaining ROMs.

5: Note that there are sometimes different revisions of a game out there. The U.S. cartridge version of the Legend of Zelda has multiple ROM versions, for example. I guess we could say that lua scripts may have a ROM version dependency.

I would love to hear from any of you that modify these scripts or use them to help develop new scripts of your own.

Thank you to everyone that has ever reversed a game and shared their findings on the web.
