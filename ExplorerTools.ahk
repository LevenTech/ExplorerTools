
;-----------------------------------|
;                                   |
; ExplorerTools by LevenTech        |
;                                   |
; Version 1.4 (9-21-17)             |
;                                   |
; Optional Add-Ons:                 |
;  - Files2Folder                   |
;-----------------------------------|


; TRAY ICON CONFIGURATION
;-------------------------
Menu, Tray, Tip, ExplorerTools by LevenTech
Menu, Tray, Icon, ExplorerTools.ico, 1, 0

Menu, Tray, NoStandard
Menu, Tray, Add, Instructions, MyHelp
Menu, Tray, Default, Instructions 
Menu, Tray, Standard
Return


; HELP TEXT
;-----------
MyHelp: 
+^/::
!^/::
	message = 
	message = %message%`n Windows+C: `tOpen C:\ drive
	message = %message%`n Windows+D: `tOpen D:\ drive`n
	message = %message%`n Ctrl+Alt/Shift+F: `tMove file to folder with same name
	message = %message%`n Ctrl+Alt/Shift+D: `tMove files to folders with same names`n
	message = %message%`n note: these require the third-party app <a href="http://skwire.dcmembers.com/wb/pages/software/files-2-folder.php">Files2Folder</a>
	message = %message%`n Ctrl+Alt/Shift+C: `tCopy filename to clipboard (no extension)
	message = %message%`n Ctrl+Alt/Shift+V: `tPaste clipboard into filename (no extension)
	message = %message%`n Ctrl+Alt/Shift+S: `tPaste clipboard into filename and append ".en"`n
	message = %message%`n Ctrl+Alt/Shift+X: `tPaste clipboard into filename and stay in the field
	message = %message%`n Ctrl+Context: `tOpen Task Manager`n
	message = %message%`n Ctrl+Alt/Shift+R: `tEmpty Recycle Bin`n
	message = %message%`n Ctrl+Alt/Shift+?: `tOpen This Help Window
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
	
	
^!f::
^+f::
	Send, {AppsKey}
	Sleep, 100
	Send, f
	Return

^!d::
^+d::
	Send, {AppsKey}f
	Sleep, 500
	Send, {Enter}
	Return

^!c:: 
^+c:: 
	Send, {F2}
	Sleep, 100
	Send, ^c
	Send, {Esc}
	Return

^!v::
^+v::
	Send, {F2}
	Sleep, 100
	Send, ^v
	Send, {Enter}
	Return

^!x:: 
^+x:: 
	Send, {F2}
	Sleep, 100
	Send, ^v
	Send, .en
	Send, {Enter}
	Return
