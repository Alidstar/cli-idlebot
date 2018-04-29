#Include, state.ahk

GetLocation(xRatio, yRatio) {
	norm_w := 1016
	norm_h := 714
	WinGetPos, , , win_w, win_h, Crusaders of The Lost Idols
}

LevelUp() {
	ControlClick, x994 y664, Crusaders of The Lost Idols
}

Collect() {
	MouseMove, 0, 100, 0, R
	MouseMove, 0, -100, 0, R
}

AutoClick() {
	ControlClick, x700 y330, Crusaders of The Lost Idols
}

Forward() {
	ControlSend, , {Right}, Crusaders of The Lost Idols
}

i := 0
Loop {
	If (state.autoplay) {
		If (Mod(i, 300) = 0) {
			LevelUp()
		}
		If (Mod(i, 600) = 0) {
			Forward()
		}
	}
	If (state.autocollect) {
		Collect()
	}
	If (state.autoclick) {
		AutoClick()
	}

	If (i = 600) {
		i := 0
	} Else {
		i += 1
	}
	Sleep, 100
}

F5:: state.show()
F6:: state.autoplay := !state.autoplay
F7:: state.autoclick := !state.autoclick
F8:: state.autocollect := !state.autocollect
F9:: LevelUp()
