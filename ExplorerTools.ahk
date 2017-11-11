#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-----------------------------------|
;                                   |
; ExplorerTools by LevenTech        
;                                   
; Version 2.1 (10-13-17)			
;                                   
; Included Add-Ons:                 
;  - VideoFolderIcons				
;  - QuickIncrement					
;                                   
; Optional Add-Ons:                 
;  - Files2Folder                   |
;-----------------------------------|


; VAR INITIALIZE
;-----------------------
pressedF3 := 0
pressedF4 := 0
currentSort := 0
currentGroup := 0
commentsGrouper := 0


; FEATURE CONFIG
;-------------------------
QuickExtensionChange := 1   ;Turned OFF because I haven't gotten the window name right (affects too many renames)
QuickProgramFiles := 1
QuickIncrement := 1

; TRAY ICON CONFIGURATION
;-------------------------
Menu, Tray, Tip, ExplorerTools by LevenTech
Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools.ico, 1, 0

Menu, Tray, NoStandard
Menu, Tray, Add, How to use ExplorerTools, MyHelp
Menu, Tray, Add, Disable Auto-Extension Change, ToggleExtChg
Menu, Tray, Add, Disable Auto-Program Files Change, TogglePFChg
Menu, Tray, Add
Menu, Tray, Default, How to use ExplorerTools 
Menu, Tray, Standard

SetTimer, RepeatedFunction, 2000	; Handles Icon Check and Confirm Dialogs

Return
;=============================================
;          END OF INITIAL RUN
;=============================================

RefreshTrayTip() {
    Menu Tray, NoIcon
    Menu Tray, Icon
	Return
}
MyTrayTip(title, text, options=0) {
	RefreshTrayTip()
	TrayTip %title%, %text%, , %options%
	Sleep 500
	RefreshTrayTip()
	Return
}



; TOGGLE FEATURES (MENU OPTIONS)
;------------------------------------------

ToggleExtChg:
	if QuickExtensionChange = 0
	{
		QuickExtensionChange = 1
		Menu, Tray, Rename, Enable Auto-Extension Change, Disable Auto-Extension Change
		Return
	} else {
		QuickExtensionChange = 0
		Menu, Tray, Rename, Disable Auto-Extension Change, Enable Auto-Extension Change
	}
Return

TogglePFChg:
	if QuickProgramFiles = 0
	{
		QuickProgramFiles = 1
		Menu, Tray, Rename, Enable Auto-Program Files Change, Disable Auto-Program Files Change
		Return
	} else {
		QuickProgramFiles = 0
		Menu, Tray, Rename, Disable Auto-Program Files Change, Enable Auto-Program Files Change
	}
Return



; HELP TEXT
;-----------
MyHelp: 
+^/::
!^/::
	message = 
	if (QuickExtensionChange = 1) {
		message = %message%`n File extension changes are AUTOMATIC
		message = %message%`n      (enable the prompt from the tray icon)
	} else {
		message = %message%`n File extension changes are CONFIRMED
		message = %message%`n      (disable the prompt from the tray icon)
	}

	message = %message%`n
	if (QuickProgramFiles = 1) {
		message = %message%`n Program Files changes are AUTOMATIC
		message = %message%`n      (enable the prompt from the tray icon)
	} else {
		message = %message%`n Program Files changes are CONFIRMED
		message = %message%`n      (disable the prompt from the tray icon)
	}
 
	message = %message%`n`n
	message = %message%`n  -- HELP ---------------------------------------
	message = %message%`n  Ctrl + Alt/Shift + ?: `t Open This Help Window
 
	message = %message%`n`n
	message = %message%`n  -- WINDOWS TOOLS ---------------------------------------
	message = %message%`n  Win + Context: `t`t Open Task Manager
	message = %message%`n  Ctrl + Win + [C/D/E/F]: `t Open [C/D/E/F]: drive
	message = %message%`n
	message = %message%`n  Ctrl + Win + R: `t`t Empty Recycle Bin
	message = %message%`n
	message = %message%`n  Ctrl + Win + Space: `t Make current window "Always on Top"
	message = %message%`n
	message = %message%`n  Press F4 twice: `t`t Close Window
	message = %message%`n  Press F3 twice: `t`t Close Tab

	message = %message%`n`n
	message = %message%`n  -- FOLDER OPTIONS ---------------------------------------
	message = %message%`n  Alt + H:`t`t Toggle "Show Hidden Files"
	message = %message%`n  Alt + N:`t`t Toggle Navigation Pane
	message = %message%`n  Alt + P:`t`t Toggle Preview Pane
	message = %message%`n  Alt + D:`t`t Toggle Details Pane
	message = %message%`n
	message = %message%`n  Alt + V:`t`t Cycle View Mode
	message = %message%`n  Alt + S:`t`t Cycle 'Sort By' `t(Name >> Type >> Date Created)
	message = %message%`n  Alt + S:`t`t Cycle 'Group By' `t(Type >> Tags >> Comments)

	message = %message%`n`n
	message = %message%`n  FILE MANIPULATION
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n  Ctrl + Shift + C: `tCopy filename to clipboard (no extension)
	message = %message%`n  Ctrl + Shift + X: `tCopy filename and delete file
	message = %message%`n  Ctrl + Shift + V: `tPaste clipboard into filename (no extension)
	message = %message%`n  Ctrl + Shift + S: `tPaste clipboard into filename and append ".en"
	message = %message%`n  Ctrl + Shift + X: `tPaste clipboard into filename and stay in the field
	message = %message%`n
	message = %message%`n  Ctrl + Shift + H: `tMake file hidden (or unhide)
	message = %message%`n
	message = %message%`n  Ctrl + Win + = : `tAdd [clipboard] to Comments Field (only for shortcuts)
	message = %message%`n  Ctrl + Win + ] : `tUse [clipboard] as file that represent folder contents
	message = %message%`n  Ctrl + Win + \ : `tUse [clipboard] as icon for folder
	message = %message%`n
	message = %message%`n
		message = %message%`n  QUICK-INCREMENT:
	message = %message%`n  Ctrl + Shift + [0-9]: `tAdd [0-9] to each integer in selected text
	message = %message%`n -----------------------------------------------------------------------------

	MsgBox, , ExplorerTools by LevenTech, %message%
Return


; ONGOING BACKGROUND CODE
;-------------------------
RepeatedFunction:
	IfWinActive, Destination Folder Access Denied ahk_class OperationStatusWindow
	{
		if (QuickProgramFiles = 1) {
			send, {enter}
			MyTrayTip("Auto-Confirmed","Change to Program Files Folder",16)
		}
	}
	IfWinActive, Rename ahk_class #32770
	{
		if (QuickExtensionChange = 1) {
			send, y
			MyTrayTip("Auto-Confirmed","Change to File Extension",16)
		}
	}
	Goto, IconCheck
Return

IconCheck:
	if (WinActive("ahk_exe explorer.exe") AND WinActive("ahk_class CabinetWClass"))
	{
		Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools_yellow.ico, 1, 0
		Return
	}
	Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools.ico, 1, 0
Return



#NumPad1::
#NumPad2::
#NumPad3::
#NumPad4::
#NumPad5::
#NumPad6::
#NumPad7::
#NumPad8::
#NumPad9::
^NumPad1::
^NumPad2::
^NumPad3::
^NumPad4::
^NumPad5::
^NumPad6::
^NumPad7::
^NumPad8::
^NumPad9::
!^NumPad1::
!^NumPad2::
!^NumPad3::
!^NumPad4::
!^NumPad5::
!^NumPad6::
!^NumPad7::
!^NumPad8::
!^NumPad9::
	if (GetKeyState("NumLock", "T"))
	{
		MsgBox, 4, ,NumLock is ON. Turn it OFF?, 3
		IfMsgBox, No
			Return
		IfMsgBox, Timeout
			Return
		SetNumLockState , Off
	}
Return

^+#f::
	pasteFileName = 1
^+f::					; CHOOSE ICON FILE TO REPRESENT FOLDER
	Send, {AppsKey}r	
	Sleep 500
	Send, ^+{Tab}
	Send, !f
	Send, {Enter}
	Sleep 200
	if (pasteFileName = 1)
	{
		Send, ^v
		Send, {Enter}
		Send, {Enter}
		MyTrayTip("Icon File Chosen",clipboard,16)
	}
	pasteFileName = 0
Return

^+!i::
	restoreIcon = 1
	GoTo, doIconChange
	Return
^+#i::
	pasteIcon = 1
doIconChange:
^+i::					; CHOOSE ICON TO REPLACE FOLDER ICON
	Send, {AppsKey}r
	Sleep 500
	Send, ^+{Tab}
	Send, !i
	Sleep 500
	if (pasteIcon = 1)
	{
		Send, ^v
		Send, {Enter}
		Send, {Enter}
		Send, {Tab}
		Send, {Enter}
		MyTrayTip("Icon Chosen",clipboard,16)
	}
	if (restoreIcon = 1)
	{
		Send, !r
		Send, {Enter}
		MyTrayTip("Icon Restored","Icon Restored",16)
	}
	pasteIcon = 0
	restoreIcon = 0
Return

; PASTE CLIPBOARD INTO COMMENTS FIELD
~=::									; = with NUMLOCK and CAPSLOCK on
	if (NOT GetKeyState("Numlock","T")) OR (NOT GetKeyState("Capslock","T"))
		Return
^#=::									; Ctrl+Win+=
	Send {AppsKey}r
	Sleep 400
	Send !o
	Send ^v
	Send {Enter}
Return





; ACTUAL HOTKEYS AND SHORTCUTS
;------------------------------

^RButton::
	Send, {RButton}e
Return





; BASIC WINDOWS FEATURES (TASKMGR, RECYCLE BIN, ALWAYS ON TOP)
;------------------------------------------------------------------
^#r::
	Run, EmptyRecycleBin.exe
Return
	
^AppsKey::
^!AppsKey::
#AppsKey::
	Run, taskmgr
Return

#SPACE::
	Winset, Alwaysontop, , A
	MyTrayTip("Always On Top","Toggled Window's AlwaysOnTop",16)
Return




; FOLDER VIEW OPTIONS
;--------------------------------------------------------
#IfWinActive ahk_exe explorer.exe

#UseHook

!n:: Send {LAlt}vn{Enter}	; SHOW NAV PANE
!p:: Send {LAlt}vp			; SHOW PREVIEW PANE
!d:: Send {LAlt}vd			; SHOW DETAILS PANE

!h:: Send {LAlt}vhh			; SHOW HIDDEN ITEMS

!v::						; CYCLE VIEW
	Send {Alt}
	Send 05
	Send {Tab}
	Return

!s:: 						; CYCLE SORT
	currentSort++
	
	if (currentSort = 4) {
		currentSort := 1
	}
	
	if (currentSort = 1) {
		Send {Alt}vo{Enter}
		title = Sorting by NAME
	}
	if (currentSort = 2) {
		Send {Alt}vo{Down}{Down}{Enter}
		title = Sorting by TYPE
	}
	if (currentSort = 3) {
		Send {Alt}vo{Down}{Down}{Down}{Down}{Enter}
		title = Sorting by DATE
	}
	MyTrayTip(title,"(Alt+S)")
Return

+!s:: 						; CHANGE SORT DIRECTION
	if (currentSort = 1) {
		Send {Alt}vo{Enter}
	}
	if (currentSort = 2) {
		Send {Alt}vo{Down}{Down}{Enter}
	}
	if (currentSort = 3) {
		Send {Alt}vo{Down}{Down}{Down}{Down}{Enter}
	}
	MyTrayTip("Sort Direction Changed","(Shift+Alt+S)")
Return


!g:: 						; CYCLE GROUPING
	currentGroup++
	
	if (currentGroup = 5)
		currentGroup := 1
	
	if (currentGroup = 1) {
		Send {Alt}vg{Down}{Down}{Enter}
		Message = Grouping by TYPE
	}
	if (currentGroup = 2) {
		Send {Alt}vg{Down}{Down}{Down}{Down}{Down}{Down}{Enter}
		Message = Grouping by TAGS
	}
	if (currentGroup = 3) {
		Message = 
		if (commentsGrouper = 0) {
			Send {Alt}vg{Up}{Enter}
			Send comm
			Send !s{Enter}
			commentsGrouper = 1;
			Message = (enabled)
			Sleep 500
		}
		Send {Alt}vg{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}
		Message = %Message% Grouping by COMMENTS
	}	
	if (currentGroup = 4) {
		;Send {Alt}vg{Enter}
		;Sleep 300
		Send {Alt}vg{Up}{Up}{Up}{Up}{Enter}
		Message = NOT Grouping
	}	
	MyTrayTip(Message,"(Alt+G)")
Return

#UseHook Off

#IfWinActive
----------------------------------------------------------

	
; CLOSE WINDOWS AND TABS WITH F4/F3 DOUBLE-PRESS
;----------------------------------------------------
F4::
	If (pressedF4 = 0)
	{
		pressedF4 := 1
		SetTimer, WindowLoop, -50
		Return
	}
	Send, !{F4}
	pressedF4 := 0
	GoTo, IconCheck
Return

WindowLoop:
		Loop 3
		{
			If (pressedF4 = 0)
				Break
			Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools_black.ico, 1, 0
			Sleep, 250
			If (pressedF4 = 0)
				Break
			GoSub, IconCheck
			Sleep, 250
		}
		Loop 4
		{
			If (pressedF4 = 0)
				Break
			Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools_black.ico, 1, 0
			Sleep, 100
			If (pressedF4 = 0)
				Break
			GoSub, IconCheck
			Sleep, 100
		}		
		pressedF4 := 0
Return

F3::
	If (pressedF3 = 0)
	{
		pressedF3 := 1
		SetTimer TabLoop, -50
		Return
	}
	Send, ^w
	pressedF3 := 0
	GoTo, IconCheck
Return

TabLoop:
		Loop 3
		{
			If (pressedF3 = 0)
				Break
			Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools_black.ico, 1, 0
			Sleep, 250
			If (pressedF3 = 0)
				Break
			GoSub, IconCheck
			Sleep, 250
		}
		Loop 4
		{
			If (pressedF3 = 0)
				Break
			Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools_black.ico, 1, 0
			Sleep, 100
			If (pressedF3 = 0)
				Break
			GoSub, IconCheck
			Sleep, 100
		}		
		pressedF3 := 0
Return



; OPEN DRIVES
;----------------------------------------------
^#c:: OpenDrive("C")
^#d:: OpenDrive("D")
^#e:: OpenDrive("E")
^#f:: OpenDrive("F")
^#g:: OpenDrive("G")

OpenDrive(drive)
{
	explorerpath:= "explorer /e," . drive . ":\"
	Run, %explorerpath%
	WinWaitActive, %drive%
	WinMaximize, %drive%
}

	
; FILENAME OPERATIONS
;----------------------------------------------

^+h::						; MAKE ITEM HIDDEN
	Send, !vhs
	Sleep 500
	if WinActive("Confirm Attribute Changes")
		Send {Up}{Enter}
Return

^+c:: 						;COPY FILENAME
	Send, {F2}
	Sleep, 200
	Send, ^c
	Send, {Esc}
	Sleep, 100
	MyTrayTip("Copied Filename","%clipboard%",16)
Return
	
^+x:: 						;COPY FILENAME, DELETE FILE
	Send, {F2}
	Sleep, 200
	Send, ^c
	Send, {Esc}
	Send, {Delete}
	Sleep, 100
	MyTrayTip("Copied Filename","%clipboard%",16)
Return	

^+v:: 						;PASTE FILENAME
	Send, {F2}
	Sleep 200
	Send, ^v
	Send, {Enter}
	Sleep 100
	MyTrayTip("Pasted Filename","%clipboard%",16)
Return

^+b:: 						;PASTE FILENAME AND STAY IN EDIT MODE
	Send, {F2}
	Sleep 200
	Send, ^v
	Sleep 100
	MyTrayTip("Pasted Filename (stay)","%clipboard%",17)
Return	

^+s:: 						;PASTE FILENAME AND APPEND ".EN"
	Send, {F2}
	Sleep, 200
	Send, ^v
	Send, .en{Enter}
	Sleep, 100
	MyTrayTip("Pasted Subtitles","%clipboard%.en",17)
Return
	
^+a:: 						;PRE-PEND CLIPBOARD TO FILENAME
	Send, {F2}
	Sleep, 200
	Send, {Home}
	Send, ^v
	Send, {Enter}
	MyTrayTip("Appended","%clipboard%",17)
Return

^+q::						 ;APPEND CLIPBOARD TO FILENAME
	Send, {F2}
	Sleep, 200
	Send, {End}
	Send, ^v
	Send, {Enter}
	MyTrayTip("Appended","%clipboard%",17)
Return	
	


;-----------------------------------|
; QuickIncrement by LevenTech       |
;-----------------------------------|
	
^+1::
	IncVal := 1
	Goto, DoIt
^+2::
	IncVal := 2
	Goto, DoIt
^+3::
	IncVal := 3
	Goto, DoIt
^+4::
	IncVal := 4
	Goto, DoIt
^+5::
	IncVal := 5
	Goto, DoIt
^+6::
	IncVal := 6
	Goto, DoIt
^+7::
	IncVal := 7
	Goto, DoIt
^+8::
	IncVal := 8
	Goto, DoIt
^+9::
	IncVal := 9
	Goto, DoIt

MarkupNumbers(str)
{
	Loop, 10 {
		ThisNumber :=  A_Index-1
		StringReplace, str, str, %ThisNumber%, &&%ThisNumber%$$, All
	}
	StringReplace, str, str, $$&&, , All
	return str
}
	
DoIt:
	if QuickIncrement=0 
	{
		Return
	}
	Send ^c
	OldVal = %clipboard%
	NewVal := MarkupNumbers(OldVal)
	RegexReplace(NewVal,"&&","&&",NumCount)
	NextIncVal := IncVal
	Loop, 100 {
		ThisNumber :=  A_Index-1
		StringReplace, NewVal, NewVal, &&%ThisNumber%$$, %NextIncVal%, All
		NextIncVal+=1
	}
	StringReplace, NewVal, NewVal, &&, , All
	StringReplace, NewVal, NewVal, $$, , All
	If (OldVal != NewVal)
	{
		clipboard = %NewVal%
		Send ^v
		MyTrayTip("Increment: +%IncVal%","Updated %NumCount% numbers",17)
	}
Return


^+0::
	Send ^c
	OldVal = %clipboard%
	NewVal := MarkupNumbers(OldVal)
	RegexReplace(NewVal,"&&","&&",NumCount)
	Loop, 100 {
		ThisChar :=  A_Index-1
		StringReplace, NewVal, NewVal, &&%ThisChar%$$, , All
	}
	StringReplace, NewVal, NewVal, &&, , All
	StringReplace, NewVal, NewVal, $$, , All
	If (OldVal != NewVal)
	{
		clipboard = %NewVal%
		Send ^v
		MyTrayTip("Numbers Cleared","Cleared %NumCount% numbers",17)
	}
Return