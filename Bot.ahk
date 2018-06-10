#Include, State.ahk
#Include, Game.ahk

LevelUp(game) {
    if (game.IsInCrusaderTab()) {
        win := game.WIN_NAME
        p := game.lvlup_button.toPosition()
        ControlClick, %p%, %win%
    }
}

Upgrade(game) {
    if (game.IsInCrusaderTab()) {
        win := game.WIN_NAME
        p := game.UPGRADE_BUTTON.toPosition()
        ControlClick, %p%, %win%
    }
}

LoadFormation(game, key) {
    win := game.WIN_NAME
    ControlSend, , %key%, %win%
}

StormRider(game) {
    If (game.IsAbilityReady(7)) {
        win := game.WIN_NAME
        a2 := game.GetAbility(2).toPosition()
        a7 := game.GetAbility(7).toPosition()
        ControlClick, %a2%, %win%
        ControlClick, %a7%, %win%
    }
}

Collect() {
    MouseMove, 0, 100, 0, R
    MouseMove, 0, -100, 0, R
}

AutoClick(game) {
    if (game.IsInCrusaderTab()) {
        win := game.WIN_NAME
        MouseGetPos, mx, my
        ControlClick, x%mx% y%my%, %win%
        ; p := game.CLICK_LOCATION.toPosition()
        ; ControlClick, %p%, %win%
    }
}

Forward(game) {
    win := game.WIN_NAME
    ControlSend, , {Right}, %win%
}

FocusLevel(game, index) {
    If (game.IsInCrusaderTab() && index >= 1 && index <= 6) {
        win := game.WIN_NAME
        p := game.GetCrusaderPosition(index).toPosition()
        ControlSend, , {Ctrl Down}, %win%
        ControlClick, %p%, %win%
        ControlSend, , {Ctrl up}, %win%
    }
}

game := new Game()

i := 0
Loop {
    If (state.fastforward) {
        Forward(game)
    }
    If (state.autoplay) {
        If (Mod(i, 100) = 0) {
            LoadFormation(game, state.reformation)
        }
        If (Mod(i, 250) = 0) {
            StormRider(game)
            FocusLevel(game, state.focusOn)
            LevelUp(game)
            Forward(game)
        }
        ; If (Mod(i, 600) = 0) {
            ; Upgrade(game)
        ; }
    }
    If (state.autocollect) {
        Collect()
    }
    If (state.autoclick) {
        AutoClick(game)
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
F9:: LevelUp(game)
F10:: FocusLevel(game, state.focusOn)
F11:: Upgrade(game)

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

!Right:: state.fastforward := !state.fastforward