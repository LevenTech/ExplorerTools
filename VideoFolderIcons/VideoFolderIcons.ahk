#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;-----------------------------------|
;                                   |
; VideoFolderIcons by LevenTech 	|
;                                   |
; Version 1.0 (10-3-17)             |
;                                   |
;-----------------------------------|

#UseHook, On

; TRAY ICON CONFIGURATION
;-------------------------
	Menu, Tray, Tip, VideoFolderIcons by LevenTech
	Menu, Tray, Icon, VideoFolderIcons.ico, 1, 0
	 
	;Menu, Tray, NoStandard
	;Menu, Tray, Add, Instructions, MyHelp
	;Menu, Tray, Default, Instructions 
	;Menu, Tray, Standard
Return

^#RButton::
	Send, {RButton}
	Send, {Up}
	Send, {Enter}
	Sleep 500
	Send, ^+{Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
	Sleep 200
	SendRaw, poster.jpg
	Send, {Enter}
	Sleep 200
	Send, {Tab}
	Send, {Tab}
	Send, {Tab}
	Send, {Enter}
Return

^+RButton::
	Send, {RButton}
	Send, {Up}
	Send, {Enter}
	Sleep 500
	Send, ^+{Tab}
	Send, P
	Send, {Enter}
Return