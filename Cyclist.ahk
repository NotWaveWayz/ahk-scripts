#NoEnv
#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 72727
#MaxHotkeysPerInterval 72727

; Modifiable Variables ;

Sequence := "dfjk" ; The custom sequence
SequenceVal := StrLen(Sequence) ; The sequence value, shouldn't be modified.
MessageClear := 1 ; When it should reset the colors and tooltips, use 0 to disable it, 1 to clear on first letter. Old: StrLen(Sequence) / 2
LineText := "█" ; The border text, it allows movement of the script, shouldn't be modified.
ExitText := "❌" ; The exit button text. Default: "Exit"
ExitTextAlt := "❌" ; The exit button text but only for text lower than 3. Default "❌"
Website := "https://github.com/NotWaveWayz/ahk-scripts" ; hosted site, shouldn't be modified.
VerNum := "1.0" ; Current version number, shouldn't be modified.

; IMPORTANT: modifying these colors could lead to errors, mainly wrong color pixels, this wont be fixed.
; T = Top, B = Bottom, Blank = Startup, Reset = MessageClear

FailColorT := "F08080"
FailColorB := "F08080"
PassColorT := "98FB98"
PassColorB := "98FB98"
BlankColorT := "FFFFFF"
BlankColorB := "FFFFFF"
ResetColorT := "FFFFFF"
ResetColorB := "FFFFFF"

; Modifiable Variables ;

; Tray Icon ;

Menu, Tray, Icon, ddores.dll, 29
Menu,Tray,Tip,Cyclist - v%VerNum%
Menu,Tray,NoStandard
Menu,Tray,Add,Cyclist - v%VerNum%,Version
Menu,Tray,Add,Help Guide,Guide
Menu,Tray,Add,Edit Script,Edit
Menu,Tray,Add,Exit

; Tray Icon ;

; Checks for any errors with MessageClear, Sequence/SequenceVal ;

If (SequenceVal < 2){
Msgbox,,Error!,Sequence cannot be less than 2`nExiting...,10
ExitApp
}Else If (MessageClear = "0"){
MessageClear := SequenceVal + 1
}Else If ("%MessageClear%" > "%SequenceVal%" || "%MessageClear%" not contains ".000000" || "%MessageClear%" contains "-"){
MsgBox,,Warning! | MessageClear: %MessageClear%,If your "MessageClear" value is negative or greater than %SequenceVal% it will be reverted to the default setting.`n`nOtherwise`, all numbers past "." gets removed due to values unable to be read.,20

If ("%MessageClear%" > "%SequenceVal%" || "%MessageClear%" contains "-")
MessageClear := StrLen(Sequence) / 2

MessageClear := SubStr(MessageClear, 1, InStr(MessageClear, ".") - 1) 
MessageClear := SubStr(MessageClear, InStr(MessageClear, ".") + 1)
}

Loop, %SequenceVal% {
Line := Line LineText
}

; Checks for any errors with MessageClear, Sequence/SequenceVal ;

If (SequenceVal < 3)
ExitText := ExitTextAlt

BoxWidth := SequenceVal * 10
WinWidth := BoxWidth * 1.5
Gui, Color, FFFFFE
Gui,Font,c%BlankColorT%
Gui,Add,Text,vT1 GuiMove,%Line%
Gui,Font,cBlack
Gui,Add,Edit,w%BoxWidth% vEdit gSubmit
Gui,Add,Button,w%BoxWidth% gExit,%ExitText%
Gui,Font,c%BlankColorB%
Gui,Add,Text,vT2 GuiMove,%Line%
Gui,Show,w%WinWidth% h69,Cyclist - v%VerNum%
Gui -Caption +LastFound +AlwaysOnTop +ToolWindow
WinSet, TransColor, FFFFFE
Return

Submit:
If (CapsCheck = 0)
ToolTip
Gui,Submit,NoHide
EditVal := StrLen(Edit)
CapsCheck := GetKeyState("Capslock", "T")
If (EditVal = SequenceVal){
GuiControl,,Edit

If not (Edit = Sequence){
If (CapsCheck = 1)
ToolTip,Sorry`, You Failed :(`n%Edit% ≠ %Sequence%`nPress ESC to remove message.
GuiControl, +c%FailColorT%, T1
GuiControl, +c%FailColorB%, T2
GuiControl,,T1,%Line%
GuiControl,,T2,%Line%

}If (Edit = Sequence){
If (CapsCheck = 1)
ToolTip,Good Job! :D`nSequence: %Edit% = %Sequence%`nPress ESC to remove message.
GuiControl, +c%PassColorT%, T1
GuiControl, +c%PassColorB%, T2
GuiControl,,T1,%Line%
GuiControl,,T2,%Line%
}
}If (EditVal = MessageClear){
ToolTip
GuiControl, +c%ResetColorT%, T1
GuiControl, +c%ResetColorB%, T2
GuiControl,,T1,%Line%
GuiControl,,T2,%Line%
}
Return

uiMove:
PostMessage, 0xA1, 2,,, A 
Return

Edit:
Run, notepad.exe %A_ScriptFullPath%
Return

Guide:
WinClose,Cyclist Guide - v%VerNum%
MsgBox,262176,Cyclist Guide - v%VerNum%,Cyclist is a simple script to easily practice a cycle of keys`, useful for rhythm games like osu!`, Friday Night Funkin`, etc.`n`nKeys:`n`nPress ESCAPE to remove tooltip messages. (u)`nPress CTRL+ALT+ENTER to Activate Cyclist. (u)`nPress BACKSPACE to clear characters.`nToggle CAPS to toggle messages.`n`n(u) means universal, otherwise keys only work while using Cyclist. Keys are never blocked and can be used in different applications (except CTRL+ALT+ENTER).
WinActivate,Cyclist - v%VerNum%
Return

Version:
Run, %Website%
Return

Exit:
GuiClose:
ToolTip
ExitApp
Return

~Escape::ToolTip

^!Enter::
ToolTip,Activated Cyclist!
WinActivate,Cyclist - v%VerNum%
Sleep 500
ToolTip
Return

#If WinActive("Cyclist - v" VerNum)
~BackSpace::
GuiControl,,Edit
ToolTip,Cleared Text..
Sleep 500
ToolTip
Return
