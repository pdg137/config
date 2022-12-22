; Borderless Window - AutoHotkey Script
; The script toggles the window border and title bar of the current window independently

; The hotkey is Control+Win+t. It applies changes to whatever window has focus.
^#t::
WinGetTitle, currentWindow, A
IfWinExist %currentWindow%
{
	WinSet, Style, ^0xC00000 ; toggle title bar
	WinMaximize
}
return

