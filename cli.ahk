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

i := 0
Loop {
	If (level_enable and Mod(i, 300) = 0) {
		LevelUp()
	}
	If (collect_enable) {
		Collect()
	}
	If (click_enable) {
		AutoClick()
	}

	If (i = 299) {
		i := 0
	} Else {
		i := i + 1
	}
	Sleep, 100
}

!l::LevelUp()
^!l:: level_enable := !level_enable

^!a:: click_enable := !click_enable
^!c:: collect_enable := !collect_enable

;Escape::ExitApp