#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-----------------------------------|
;                                   |
; ExplorerTools by LevenTech        |
;                                   |
; Version 1.5 (9-22-17)             |
;                                   |
; Optional Add-Ons:                 |
;  - Files2Folder                   |
;-----------------------------------|


; FEATURE CONFIG
;----------------
QuickExtensionChange = 1

; TRAY ICON CONFIGURATION
;-------------------------
Menu, Tray, Tip, ExplorerTools by LevenTech
Menu, Tray, Icon, ExplorerTools.ico, 1, 0

Menu, Tray, NoStandard
Menu, Tray, Add, Instructions, MyHelp
Menu, Tray, Add, Disable Auto-Extension Change, DisableExtChg
Menu, Tray, Add, Download Files2Folder, DownloadF2F
Menu, Tray, Default, Instructions 
Menu, Tray, Standard

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 500  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

MyLoop:
; ONGOING BACKGROUND CODE
;-------------------------
if (QuickExtensionChange = 1) {
	While, 1
	{
		WinWaitActive, Rename ahk_class #32770
		if (QuickExtensionChange = 1) {
			send y
		} else {
			Return
		}
	}
}
Return

; HELP TEXT
;-----------

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
	Goto, MyLoop
	Return

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
	message = %message%`n  ---------------------------------------------------------------
	message = %message%`n  |  NOTE:`t`t`t`t`t`t|
	message = %message%`n  |   These shortcuts say`t Ctrl + Alt   +  ___      `t|
	message = %message%`n  |   but you can also use`t Ctrl + Shift +  ___      `t|
	message = %message%`n  ---------------------------------------------------------------
	message = %message%`n
	message = %message%`n
	message = %message%`n  Ctrl + Alt + ?: `tOpen This Help Window
	message = %message%`n
	message = %message%`n
	message = %message%`n  WINDOWS TOOLS
	message = %message%`n -------------------------------------------------------
	message = %message%`n  Ctrl + Context: `tOpen Task Manager
	message = %message%`n  Ctrl + Alt + R: `tEmpty Recycle Bin
	message = %message%`n -------------------------------------------------------
	message = %message%`n
	message = %message%`n  LOCATION SHORTCUTS
	message = %message%`n -------------------------------------------------------
	message = %message%`n  Win + C: `tOpen C:\ drive
	message = %message%`n  Win + D: `tOpen D:\ drive
	message = %message%`n -------------------------------------------------------
	message = %message%`n
	message = %message%`n  FILE NAME COPY / PASTE TOOLS
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n  Ctrl + Alt + C: `tCopy filename to clipboard (no extension)
	message = %message%`n  Ctrl + Alt + V: `tPaste clipboard into filename (no extension)
	message = %message%`n  Ctrl + Alt + S: `tPaste clipboard into filename and append ".en"
	message = %message%`n  Ctrl + Alt + X: `tPaste clipboard into filename and stay in the field
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n
	message = %message%`n  FILES2FOLDER (download add-on from tray icon)
	message = %message%`n -----------------------------------------------------------------------------
	message = %message%`n  Ctrl + Alt + F: `tMove file to folder with same name
	message = %message%`n  Ctrl + Alt + D: `tMove files to folders with same names
	message = %message%`n -----------------------------------------------------------------------------

	MsgBox, , ExplorerTools by LevenTech, %message%
	Return


; ACTUAL HOTKEYS AND SHORTCUTS
;------------------------------

^AppsKey::Run, taskmgr
	
^!r::
^+r::
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
	
	
^+f::
	Send, {AppsKey}
	Sleep, 100
	Send, f
	Return

^+d::
	Send, {AppsKey}f
	Sleep, 500
	Send, {Enter}
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

^+v::
	Send, {F2}
	Sleep 200
	Send, ^v
	Send, {Enter}
	Sleep 100
	TrayTip Pasted Filename, %clipboard%, , 16
	Sleep, 1500
	HideTrayTip()
	Return

^+x:: 
	Send, {F2}
	Sleep, 200
	Send, ^v
	Send, .en{Enter}
	Sleep, 100
	TrayTip Pasted Subtitles, %clipboard%.en, , 17
	Sleep, 2000
	HideTrayTip()
	Return

	

