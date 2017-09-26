#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-----------------------------------|
;                                   |
; ExplorerTools by LevenTech        |
;                                   |
; Version 1.7 (9-25-17)             |
;                                   |
; Optional Add-Ons:                 |
;  - Files2Folder                   |
;-----------------------------------|


; FEATURE CONFIG
;----------------
QuickExtensionChange := 1
QuickProgramFiles := 1
AlreadyPressed := 0
AlreadyPressedTab := 0

; TRAY ICON CONFIGURATION
;-------------------------
Menu, Tray, Tip, ExplorerTools by LevenTech
Menu, Tray, Icon, ExplorerTools.ico, 1, 0

Menu, Tray, NoStandard
Menu, Tray, Add, Instructions, MyHelp
Menu, Tray, Add, Disable Auto-Extension Change, DisableExtChg
Menu, Tray, Add, Disable Auto-Program Files Change, DisablePFChg
Menu, Tray, Add, Download Files2Folder, DownloadF2F
Menu, Tray, Add
Menu, Tray, Add, Edit Script, EditScript
Menu, Tray, Add, Exit Script to Recompile, ReloadScript
Menu, Tray, Default, Instructions 
Menu, Tray, Standard

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}


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
	message = %message%`n
	message = %message%`n  Ctrl + Alt/Shift + ?: `tOpen This Help Window
	message = %message%`n
	message = %message%`n
	message = %message%`n  WINDOWS TOOLS
	message = %message%`n -------------------------------------------------------
	message = %message%`n  Win + Context: `tOpen Task Manager
	message = %message%`n  Ctrl + Win + R: `tEmpty Recycle Bin
	message = %message%`n  Press F4 twice: `tClose Window
	message = %message%`n  Press F3 twice: `tClose Tab
	message = %message%`n -------------------------------------------------------
	message = %message%`n
	message = %message%`n  LOCATION SHORTCUTS
	message = %message%`n -------------------------------------------------------
	message = %message%`n  Win + C: `tOpen C:\ drive
	message = %message%`n  Win + D: `tOpen D:\ drive
	message = %message%`n  Win + E: `tOpen E:\ drive
	message = %message%`n  Win + F: `tOpen F:\ drive
	message = %message%`n -------------------------------------------------------
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
		;TrayTip Checking, Checking, 1, 16
		;Sleep, 1000
		;HideTrayTip()
		IfWinActive, Destination Folder Access Denied ahk_class OperationStatusWindow
		{
			if (QuickProgramFiles = 1) {
				send, {enter}
				Sleep, 100
				TrayTip Auto-Confirmed, Change to Program Files Folder, 2, 16
				Sleep, 2000
				HideTrayTip()
			} else {
				Return
			}
		}
		IfWinActive, Rename ahk_class #32770
		{
			if (QuickExtensionChange = 1) {
				send, y
				Sleep, 100
				TrayTip Auto-Confirmed, Change to File Extension, 2, 16
				Sleep, 2000
				HideTrayTip()
			} else {
				Return
			}	
		}
	}
Return


; MENU OPTIONS
;--------------
EditScript: 
	message = 
	Run, notepad++.exe "D:\OneDrive\LevenTech\Apps\GitHub\ExplorerTools\ExplorerTools.ahk"
	Return

ReloadScript: 
	SetTimer, ExitMe, -100
	Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
	Exit

ExitMe: 
	ExitApp
	
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


; ACTUAL HOTKEYS AND SHORTCUTS
;------------------------------

#AppsKey::Run, taskmgr

F4::
	If (AlreadyPressed = 0)
	{
		AlreadyPressed := 1
		TrayTip Close Window?, Press F4 again, , 18
		SetTimer, CancelClose, -2000
		Return
	}
	HideTrayTip()
	Send, !{F4}
	AlreadyPressed := 0
Return

CancelClose:
	If (AlreadyPressed = 0) {
		Return
	}
	AlreadyPressed := 0
	HideTrayTip()
	Sleep 20
	TrayTip Cancelled, Not Closing Window, , 17
	Sleep 1000
	HideTrayTip()
Return

F3::
	If (AlreadyPressedTab = 0)
	{
		AlreadyPressedTab := 1
		TrayTip Close Tab?, Press F3 again, , 18
		SetTimer, CancelCloseTab, -2000
		Return
	}
	HideTrayTip()
	Send, ^w
	AlreadyPressedTab := 0
Return

CancelCloseTab:
	If (AlreadyPressedTab = 0) {
		Return
	}
	AlreadyPressedTab := 0
	HideTrayTip()
	Sleep 20
	TrayTip Cancelled, Not Closing Tab, , 17
	Sleep 1000
	HideTrayTip()
Return

	
	
^#r::
	Run, C:\Windows\System32\EmptyRecycleBin.exe
	Return
	
#c::
	explorerpath:= "explorer /e," "C:\"
	Run, %explorerpath%
	Return
	
#d::
	explorerpath:= "explorer /e," "D:\"
	Run, %explorerpath%
	Return

#e::
	explorerpath:= "explorer /e," "E:\"
	Run, %explorerpath%
	Return

#f::
	explorerpath:= "explorer /e," "F:\"
	Run, %explorerpath%
	Return	
	
^+f::
	Send, {AppsKey}
	Sleep, 100
	Send, f
	Sleep, 100
	TrayTip Files2Folder, 1 file, , 16
	Sleep, 1500
	HideTrayTip()
	Return

^+g::
	Send, {AppsKey}
	Sleep, 100
	Send, f
	Sleep, 500
	Send, {Enter}
	Sleep, 100
	TrayTip Files2Folder, multiple files, , 16
	Sleep, 1500
	HideTrayTip()
	Return

^+c:: 
	Send, {F2}
	Sleep, 200
	Send, ^c
	Send, {Esc}
	Sleep, 100
	TrayTip Copied Filename, %clipboard%, , 16
	Sleep, 1500
	HideTrayTip()
	Return
	
^+x:: 
	Send, {F2}
	Sleep, 200
	Send, ^c
	Send, {Esc}
	Sleep, 100
	Send, {Delete}
	Sleep, 100
	Send y
	TrayTip Copied/Deleted, %clipboard%, , 17
	Sleep, 1500
	HideTrayTip()
	Return	

^+v::
	Send, {F2}
	Sleep 200
	Send, ^v
	Send, {Enter}
	Sleep 100
	TrayTip Pasted Filename, %clipboard%, , 17
	Sleep, 1500
	HideTrayTip()
	Return

^+s:: 
	Send, {F2}
	Sleep, 200
	Send, ^v
	Send, .en{Enter}
	Sleep, 100
	TrayTip Pasted Subtitles, %clipboard%.en, , 17
	Sleep, 2000
	HideTrayTip()
	Return
	
^+b::
	Send, {F2}
	Sleep 200
	Send, ^v
	Sleep 100
	TrayTip Pasted Filename (stay), %clipboard%, , 17
	Sleep, 1500
	HideTrayTip()
	Return	