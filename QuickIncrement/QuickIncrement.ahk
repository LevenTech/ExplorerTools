#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;-----------------------------------|
;                                   |
; QuickIncrement by LevenTech       |
;                                   |
; Version 1.1 (9-26-17)             |
;                                   |
;-----------------------------------|


; TRAY ICON CONFIGURATION
;-------------------------
Menu, Tray, Tip, QuickIncrement by LevenTech
Menu, Tray, Icon, QuickIncrement.ico, 1, 0

Menu, Tray, NoStandard
Menu, Tray, Add, Instructions, MyHelp
Menu, Tray, Default, Instructions 
Menu, Tray, Standard

; HELP TEXT
;-----------
MyHelp: 
+^/::
!^/::
	message = 
	message = %message%`n NOTE: `tOnly 1-digit and 2-digit numbers are supported
	message = %message%`n `t(numbers with 3+ digits will not change)
	message = %message%`n
	message = %message%`n
	message = %message%`n Ctrl + Shift + (1-9):`t Increases numbers in selected text by (1-9)
	message = %message%`n
	message = %message%`n Ctrl + Shift + 0:`t`t Clear numbers from selected text
	message = %message%`n
	MsgBox, , QuickIncrement by LevenTech, %message%
Return

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

	
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


