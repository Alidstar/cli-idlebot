#Include, State.ahk
#Include, Game.ahk

LevelUp() {
    if (Game.IsInCrusaderTab()) {
        win := Game.WIN_NAME
        p := Game.LEVELUP_BUTTON.toPosition()
        ControlClick, %p%, %win%
    }
}

Upgrade() {
    if (Game.IsInCrusaderTab()) {
        win := Game.WIN_NAME
        p := Game.UPGRADE_BUTTON.toPosition()
        ControlClick, %p%, %win%
    }
}

LoadFormation(key) {
    win := Game.WIN_NAME
    ControlSend, , %key%, %win%
}

StormRider() {
    If (Game.IsAbilityReady(7)) {
        win := Game.WIN_NAME
        a2 := Game.GetAbility(2).toPosition()
        a7 := Game.GetAbility(7).toPosition()
        ControlClick, %a2%, %win%
        ControlClick, %a7%, %win%
    }
}

Collect() {
    MouseMove, 0, 100, 0, R
    MouseMove, 0, -100, 0, R
}

AutoClick() {
    if (Game.IsInCrusaderTab()) {
        win := Game.WIN_NAME
        p := Game.CLICK_LOCATION.toPosition()
        ControlClick, %p%, %win%
    }
}

Forward() {
    if (Game.IsInCrusaderTab()) {
        win := Game.WIN_NAME
        ControlSend, , {Right}, %win%
    }
}

FocusLevel(index) {
    If (Game.IsInCrusaderTab() && index >= 1 && index <= 6) {
        win := Game.WIN_NAME
        p := Game.GetCrusaderPosition(index).toPosition()
        ControlSend, , {Ctrl Down}, %win%
        ControlClick, %p%, %win%
        ControlSend, , {Ctrl up}, %win%
    }
}

i := 0
Loop {
    If (state.autoplay) {
        If (Mod(i, 50) = 0) {
            LoadFormation(state.reformation)
            LoadFormation(state.reformation)
        }
        If (Mod(i, 250) = 0) {
            StormRider()
            FocusLevel(state.focusOn)
            LevelUp()
            Forward()
        }
        If (Mod(i, 600) = 0) {
            Upgrade()
        }
    }
    If (state.autocollect) {
        Collect()
    }
    If (state.autoclick) {
        AutoClick()
    }

    If (i = 1000) {
        i := 0
    } Else {
        i += 1
    }
    Sleep, 100
}

; F1:: LoadFormation(state.reformation)
F5:: state.show()
F6:: state.autoplay := !state.autoplay
F7:: state.autoclick := !state.autoclick
F8:: state.autocollect := !state.autocollect
F9:: LevelUp()
F10:: FocusLevel(state.focusOn)
F11:: Upgrade()

!0:: state.focusOn := 0 state.reformation := 0
!1:: state.focusOn := 1
!2:: state.focusOn := 2
!3:: state.focusOn := 3
!4:: state.focusOn := 4
!5:: state.focusOn := 5
!6:: state.focusOn := 6

!7:: state.reformation := "q"
!8:: state.reformation := "w"
!9:: state.reformation := "e"
