class State {
    autoplay := False
    autoupgrade := False
    autoclick := False
    autocollect := False
    fastforward := False
    followmouse := False

    reformation := 0
    focusOn := 0

    __show_state_bool(name, var) {
        delim := StrLen(name) < 11 ? "`t`t" : "`t"
        return name delim (var ? "ON" : "OFF")
    }

    __show_state_value(name, value) {
        delim := StrLen(name) < 11 ? "`t`t" : "`t"
        return name delim value
    }

    show() {
        str := this.__show_state_bool("auto play", this.autoplay)
        str .= "`n" . this.__show_state_bool("auto upgrade", this.autoupgrade)
        str .= "`n" . this.__show_state_bool("auto click", this.autoclick)
        str .= "`n" . this.__show_state_bool("auto collect", this.autocollect)
        str .= "`n" . this.__show_state_bool("fast forward", this.fastforward)
        str .= "`n" . this.__show_state_bool("follow mouse", this.followmouse)
        str .= "`n" . this.__show_state_value("focus crusader", this.focusOn ? this.focusOn : "None")
        str .= "`n" . this.__show_state_value("reformation", this.reformation ? this.reformation : "None")
        MsgBox, , State, %str%
    }
}