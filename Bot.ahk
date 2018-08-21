#Include, State.ahk
#Include, Game.ahk

LevelUp(game) {
    if (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB)) {
        win := game.WIN_NAME
        p := game.lvlup_button.toPosition()
        ControlClick, %p%, %win%
    }
}

Upgrade(game) {
    if (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB)) {
        win := game.WIN_NAME
        p := game.UPGRADE_BUTTON.toPosition()
        ControlClick, %p%, %win%
    }
}

LoadFormation(game, key) {
    if (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB)) {
        win := game.WIN_NAME
        ControlSend, , %key%, %win%
    }
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
    If (game.MouseLocationIs(Game.LCT_IN_GAME) && (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB))) {
        MouseMove, 0, 50, 0, R
        MouseMove, 0, -100, 0, R
        MouseMove, 0, 50, 0, R
    }
}

AutoClick(game) {
    win := game.WIN_NAME
    if (state.followmouse && game.MouseLocationIs(Game.LCT_IN_GAME) && game.MouseLocationIs(Game.LCT_IN_CSD_TAB)) {
        MouseGetPos, mx, my
        ControlClick, x%mx% y%my%, %win%
    } else if (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB)) {
        p := game.CLICK_LOCATION.toPosition()
        ControlClick, %p%, %win%
    }
}

Forward(game) {
    if (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB)) {
        win := game.WIN_NAME
        ControlSend, , {Right}, %win%
    }
}

FocusLevel(game, index) {
    If (index >= 1 && index <= 6 && (!game.MouseLocationIs(Game.LCT_ACTIVE) || game.MouseLocationIs(Game.LCT_IN_CSD_TAB))) {
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
    game.UpdateMouseLocation()

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
    }
    If (state.autoupgrade) {
        If (Mod(i, 600) = 0) {
            Upgrade(game)
        }
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
    Sleep, 50
}

~F5:: state.autoplay := !state.autoplay
~F6:: state.autoupgrade := !state.autoupgrade
~F7:: state.autoclick := !state.autoclick
~F8:: state.autocollect := !state.autocollect
~F9:: state.show()
~F10:: LevelUp(game)
~F11:: Upgrade(game)

~!0:: state.focusOn := 0 state.reformation := 0
~!1:: state.focusOn := 1
~!2:: state.focusOn := 2
~!3:: state.focusOn := 3
~!4:: state.focusOn := 4
~!5:: state.focusOn := 5
~!6:: state.focusOn := 6

~!7:: state.reformation := "q"
~!8:: state.reformation := "w"
~!9:: state.reformation := "e"

~!Right:: state.fastforward := !state.fastforward

~MButton:: state.followmouse := !state.followmouse