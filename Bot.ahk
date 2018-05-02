#Include, state.ahk

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

FocusLevel(index) {
    row := Mod(index, 2)
    col := index // 2 
    x := (col * 310) + 300
    y := (row * 90) + 550
    ControlSend, , {Ctrl Down}, Crusaders of The Lost Idols
    ControlClick, x%x% y%y%, Crusaders of The Lost Idols
    ControlSend, , {Ctrl up}, Crusaders of The Lost Idols
}

i := 0
Loop {
    If (state.autoplay) {
        If (Mod(i, 250) = 0) {
            FocusLevel(state.focusOn)
            LevelUp()
        }
        If (Mod(i, 500) = 0) {
            Forward()
        }
    }
    If (state.autocollect) {
        Collect()
    }
    If (state.autoclick) {
        AutoClick()
    }

    If (i = 500) {
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
F10:: FocusLevel(state.focusOn)

!0:: state.focusOn := 0
!1:: state.focusOn := 1
!2:: state.focusOn := 2
!3:: state.focusOn := 3
!4:: state.focusOn := 4
!5:: state.focusOn := 5
!6:: state.focusOn := 6