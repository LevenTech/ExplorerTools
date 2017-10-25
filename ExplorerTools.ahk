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
AlreadyPressed := 0
AlreadyPressedTab := 0
currentSort := 0
currentGroup := 0
commentsGrouper := 0



; FEATURE CONFIG
;-------------------------
QuickExtensionChange := 0   ;Turned OFF because I haven't gotten the window name right (affects too many renames)
QuickProgramFiles := 1
QuickIncrement := 1

; TRAY ICON CONFIGURATION
;-------------------------
Menu, Tray, Tip, ExplorerTools by LevenTech
Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools.ico, 1, 0
SetTimer, IconCheck, 1000

Menu, Tray, NoStandard
Menu, Tray, Add, Instructions, MyHelp
Menu, Tray, Add
Menu, Tray, Add, Enable Auto-Extension Change, DisableExtChg
Menu, Tray, Add, Disable Auto-Program Files Change, DisablePFChg
Menu, Tray, Add, Disable QuickIncrement Add-On, DisableQuickIncrement
Menu, Tray, Add, Download Files2Folder, DownloadF2F
Menu, Tray, Add
Menu, Tray, Default, Instructions 
Menu, Tray, Standard
Return

RefreshTrayTip() {
    Menu Tray, NoIcon
    Menu Tray, Icon
	Return
}
MyTrayTip(title, text, options=0) {
	RefreshTrayTip()
	TrayTip %title%, %text%, , %options% 
	RefreshTrayTip()
	Return
}


IconCheck:
	if WinActive("ahk_exe explorer.exe")
	{
		Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools_yellow.ico, 1, 0
		Return
	}
	Menu, Tray, Icon, %A_ScriptDir%\Icons\ExplorerTools.ico, 1, 0
Return

; MENU OPTIONS
;--------------
DownloadF2F:
	Run, http://skwire.dcmembers.com/wb/pages/software/files-2-folder.php
	Return
	
DisableExtChg:
	QuickExtensionChange = 0
	Menu, Tray, Delete, Disable Auto-Extension Change
	Menu, Tray, Insert, Download Files2Folder, Enable Auto-Extension Change, EnableExtChg
Return
	
EnableExtChg:
	QuickExtensionChange = 1
	Menu, Tray, Delete, Enable Auto-Extension Change
	Menu, Tray, Insert, Download Files2Folder, Disable Auto-Extension Change, DisableExtChg
Return
	
DisablePFChg:
	QuickProgramFiles = 0
	Menu, Tray, Delete, Disable Auto-Program Files Change
	Menu, Tray, Insert, Download Files2Folder, Enable Auto-Program Files Change, EnablePFChg
Return
	
EnablePFChg:
	QuickExtensionChange = 1
	Menu, Tray, Delete, Enable Auto-Program Files Change
	Menu, Tray, Insert, Download Files2Folder, Disable Auto-Program Files Change, DisablePFChg
Return

DisableQuickIncrement:
	QuickIncrement = 0
	Menu, Tray, Delete, Disable QuickIncrement Add-On
	Menu, Tray, Insert, Download Files2Folder, Enable QuickIncrement Add-On, EnableQuickIncrement
Return
	
EnableQuickIncrement:
	QuickIncrement = 1
	Menu, Tray, Delete, Enable QuickIncrement Add-On
	Menu, Tray, Insert, Download Files2Folder, Disable QuickIncrement Add-On, DisableQuickIncrement
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
	message = %message%`n
	if (QuickIncrement = 1) {
		message = %message%`n Quick Increment is ON
		message = %message%`n      (disable from the tray icon)
	} else {
		message = %message%`n Quick Increment is OFF
		message = %message%`n      (enable from the tray icon)
	}
	message = %message%`n
	message = %message%`n  -- HELP ---------------------------------------
	message = %message%`n  Ctrl + Alt/Shift + ?: `tOpen This Help Window
	message = %message%`n  -----------------------------------------------
	message = %message%`n
	message = %message%`n
	message = %message%`n  Win + Context: `t`tOpen Task Manager
	message = %message%`n  Ctrl + Win + [C/D/E/F]: `tOpen [C/D/E/F]: drive
	message = %message%`n
	message = %message%`n  Ctrl + Win + R: `t`tEmpty Recycle Bin
	message = %message%`n
	message = %message%`n  Ctrl + Win + Space: `tMake current window "Always on Top"
	message = %message%`n
	message = %message%`n  Ctrl + Win + H:`t`t Toggle "Hidden" Status for File or Folder
	message = %message%`n  Ctrl + Win + G:`t`t Toggle "Hidden" Status for Shortcut
	message = %message%`n
	message = %message%`n
	message = %message%`n  Alt + H:`t`t Toggle "Show Hidden Files"
	message = %message%`n  Alt + N:`t`t Toggle Navigation Pane
	message = %message%`n  Alt + P:`t`t Toggle Preview Pane
	message = %message%`n  Alt + D:`t`t Toggle Details Pane
	message = %message%`n
	message = %message%`n  Alt + V:`t`t Cycle View Mode
	message = %message%`n  Alt + S:`t`t Cycle 'Sort By'
	message = %message%`n  Alt + S:`t`t Cycle 'Group By'
	message = %message%`n
	message = %message%`n
	message = %message%`n  Press F4 twice: `t`tClose Window
	message = %message%`n  Press F3 twice: `t`tClose Tab
	message = %message%`n
	message = %message%`n
	message = %message%`n  FILE NAME COPY / PASTE TOOLS
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n  Ctrl + Shift + C: `tCopy filename to clipboard (no extension)
	message = %message%`n  Ctrl + Shift + X: `tCopy filename and delete file
	message = %message%`n  Ctrl + Shift + V: `tPaste clipboard into filename (no extension)
	message = %message%`n  Ctrl + Shift + S: `tPaste clipboard into filename and append ".en"
	message = %message%`n  Ctrl + Shift + X: `tPaste clipboard into filename and stay in the field
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n
	message = %message%`n  FILES2FOLDER (download add-on from tray icon)
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n  Ctrl + Shift + F: `tMove file to folder with same name
	message = %message%`n  Ctrl + Shift + G: `tMove files to folders with same names
	message = %message%`n -----------------------------------------------------------------------------
	MsgBox, , ExplorerTools by LevenTech, %message%
Return


; ONGOING BACKGROUND CODE
;-------------------------
MyLoop:
	While, 1
	{
		Sleep 500
		IfWinActive, Destination Folder Access Denied ahk_class OperationStatusWindow
		{
			if (QuickProgramFiles = 1) {
				send, {enter}
				Sleep, 100
				RefreshTraytip()
				TrayTip Auto-Confirmed, Change to Program Files Folder, 2, 16
				RefreshTraytip()
			} else {
				Return
			}
		}
		IfWinActive, Rename ahk_class #32770
		{
			if (QuickExtensionChange = 1) {
				send, y
				RefreshTraytip()
				TrayTip Auto-Confirmed, Change to File Extension, 2, 16
				RefreshTraytip()
			} else {
				Return
			}	
		}
	}
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


^#p::					; CHOOSE ICON FILE FOR Folder
Return					; TEMPORARILY DISABLED
	Sleep 500
	Send, {AppsKey}
	Send, r
	Sleep 500
	Send, ^+{Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
	Sleep 200
	Send, ^v
	Send, {Enter}
	Sleep 200
	Send, {Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
	TrayTip Icon File Chosen, %clipboard%, 16
Return

^#o::					; RESTORE ICON TO DEFAULT
Return					; TEMPORARILY DISABLED
	Send, {AppsKey}		
	Send, r
	Sleep 500
	Send, ^+{Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
	Sleep 200
	Send, !r
	Sleep 200
	Send, {Tab}
	Send, {Enter}
	TrayTip Icon File Restored, Now Using Default, 16
Return

^#+RButton::			; CHOOSE ICON FILE
Return					; TEMPORARILY DISABLED
	Sleep 500
	Send, {RButton}
	Send, {Up}
	Send, {Enter}
	Sleep 500
	Send, ^+{Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
	Sleep 200
	Send, ^v
	Send, {Enter}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
	Sleep 100
	Send, {Tab}
	Send, {Enter}
	TrayTip Icon Chosen, %clipboard%, 16
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
	TrayTip Always On Top, Toggled Window's AlwaysOnTop, , 16
Return




; FOLDER VIEW OPTIONS
;--------------------------------------------------------
#IfWinActive ahk_exe explorer.exe

#UseHook

!n:: Send {LAlt}vn{Enter}	; SHOW NAV PANE
!p:: Send {LAlt}vp			; SHOW PREVIEW PANE
!d:: Send {LAlt}vd			; SHOW DETAILS PANE

!h:: Send {LAlt}vhh			; SHOW HIDDEN ITEMS

+!h::						; MAKE ITEM HIDDEN
	Send, !vhs
	Sleep 500
	if WinActive("Confirm Attribute Changes")
		Send {Up}{Enter}
Return

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
	If (AlreadyPressed = 0)
	{
		AlreadyPressed := 1
		TrayTip Close Window?, Press F4 again, , 18
		SetTimer, CancelClose, -2000
		Return
	}
	RefreshTraytip()
	Send, !{F4}
	AlreadyPressed := 0
Return

CancelClose:
	If (AlreadyPressed = 0) {
		Return
	}
	AlreadyPressed := 0
	RefreshTraytip()
	Sleep 20
	TrayTip Cancelled, Not Closing Window, , 17
	Sleep 1000
	RefreshTraytip()
Return

F3::
	If (AlreadyPressedTab = 0)
	{
		AlreadyPressedTab := 1
		TrayTip Close Tab?, Press F3 again, , 18
		SetTimer, CancelCloseTab, -2000
		Return
	}
	RefreshTrayTip()
	Send, ^w
	AlreadyPressedTab := 0
Return

CancelCloseTab:
	If (AlreadyPressedTab = 0) {
		Return
	}
	AlreadyPressedTab := 0
	RefreshTrayTip()
	Sleep 20
	TrayTip Cancelled, Not Closing Tab, , 17
	Sleep 1000
	RefreshTrayTip()
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

	
; FILES2FOLDER AND FILENAME OPERATIONS
;----------------------------------------------
^+f:: ;MOVE TO FOLDER OF SAME NAME
	Send, {AppsKey}
	Sleep, 100
	Send, f
	Sleep, 100
	TrayTip Files2Folder, 1 file, , 16
	Sleep, 1500
	RefreshTrayTip()
Return

^+g:: ;MOVE MULTIPLE TO FOLDER OF SAME NAME
	Send, {AppsKey}
	Sleep, 100
	Send, f
	Sleep, 500
	Send, {Enter}
	Sleep, 100
	TrayTip Files2Folder, multiple files, , 16
	Sleep, 1500
	RefreshTrayTip()
Return

^+c:: ;COPY FILENAME
	Send, {F2}
	Sleep, 200
	Send, ^c
	Send, {Esc}
	Sleep, 100
	TrayTip Copied Filename, %clipboard%, , 16
Return
	
^+x:: ;COPY FILENAME, DELETE FILE
	Send, {F2}
	Sleep, 200
	Send, ^c
	Send, {Esc}
	Send, {Delete}
	Sleep, 100
	TrayTip Copied Filename, %clipboard%, , 16
Return	

^+v:: ;PASTE FILENAME
	Send, {F2}
	Sleep 200
	Send, ^v
	Send, {Enter}
	Sleep 100
	TrayTip Pasted Filename, %clipboard%, , 16
Return

^+b:: ;PASTE FILENAME AND STAY IN EDIT MODE
	Send, {F2}
	Sleep 200
	Send, ^v
	Sleep 100
	TrayTip Pasted Filename (stay), %clipboard%, , 17
Return	

^+s:: ;PASTE FILENAME AND APPEND ".EN"
	Send, {F2}
	Sleep, 200
	Send, ^v
	Send, .en{Enter}
	Sleep, 100
	TrayTip Pasted Subtitles, %clipboard%.en, , 17
Return
	
^+a:: ;PRE-PEND CLIPBOARD TO FILENAME
	Send, {F2}
	Sleep, 200
	Send, {Home}
	Send, ^v
	Send, {Enter}
	TrayTip Appended, %clipboard%, , 17
Return

^+q:: ;APPEND CLIPBOARD TO FILENAME
	Send, {F2}
	Sleep, 200
	Send, {End}
	Send, ^v
	Send, {Enter}
	TrayTip Appended, %clipboard%, , 17
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
		TrayTip Increment: +%IncVal%,Updated %NumCount% numbers, , 17
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
		TrayTip Numbers Cleared, Cleared %NumCount% numbers, , 17
	}
Return