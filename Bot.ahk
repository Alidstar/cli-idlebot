#Include, State.ahk
#Include, Game.ahk

LevelUp() {
    win := Game.WIN_NAME
    p := Game.LEVELUP_BUTTON.toPosition()
    ControlClick, %p%, %win%
}

Collect() {
    MouseMove, 0, 100, 0, R
    MouseMove, 0, -100, 0, R
}

AutoClick() {
    win := Game.WIN_NAME
    p := Game.CLICK_LOCATION.toPosition()
    ControlClick, %p%, %win%
}

Forward() {
    win := Game.WIN_NAME
    ControlSend, , {Right}, %win%
}

FocusLevel(index) {
    win := Game.WIN_NAME
    p := Game.GetCrusaderPosition(index).toPosition()
    ControlSend, , {Ctrl Down}, %win%
    ControlClick, %p%, %win%
    ControlSend, , {Ctrl up}, %win%
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