class State {
	autoplay := False
	autoclick := False
	autocollect := False

	__Get(key) {
		return this[key]
	}

	__Set(key, value) {
		this[key] := value
	}

	__show_state(name, var) {
		delim := StrLen(name) < 11 ? "`t`t" : "`t"
		return name . delim . (var ? "ON" : "OFF")
	}

	show() {
		str := this.__show_state("auto play", this.autoplay)
		str .= "`n" . this.__show_state("auto click", this.autoclick)
		str .= "`n" . this.__show_state("auto collect", this.autocollect)
		MsgBox, , State, %str%
	}
}