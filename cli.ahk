LevelUp() {
	ControlClick, x994 y664, Crusaders of The Lost Idols
}

Collect() {
	MouseMove, 0, 150, 5, R
	MouseMove, 0, -150, 5, R
}

AutoClick() {
	ControlClick, x700 y330, Crusaders of The Lost Idols
}

Forward() {
	ControlSend, , {Right}, Crusaders of The Lost Idols
}

i := 0
Loop {
	If (forward_enable and Mod(i, 600) = 0) {
		Forward()
	}
	If (level_enable and Mod(i, 200) = 0) {
		LevelUp()
	}
	If (collect_enable) {
		Collect()
	}
	If (click_enable) {
		AutoClick()
	}

	If (i = 600) {
		i := 0
	} Else {
		i += 1
	}
	Sleep, 100
}

!l::LevelUp()
^!l:: level_enable := !level_enable

^!a:: click_enable := !click_enable
^!c:: collect_enable := !collect_enable
^!Right:: forward_enable := !forward_enable

;Escape::ExitApp