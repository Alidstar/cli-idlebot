class Game {
    static WIN_NAME := "Crusaders of The Lost Idols"

    static WIN_SIZE := new Game.Dimension(1016, 714)
    static LEVELUP_BUTTON := new Game.Dimension(994, 664)
    static UPGRADE_BUTTON := new Game.Dimension(994, 566)
    static LEFT_BUTTON := new Game.Dimension(22, 615)
    static RIGHT_BUTTON := new Game.Dimension(994, 615)

    static CSD_TL_BUTTON := new Game.Dimension(300, 550)
    static CSD_OFFSET := new Game.Dimension(310, 90)
    static ABI_BUTTON := new Game.Dimension(370, 485)
    static ABI_OFFSET_X := 40

    static CLICK_LOCATION := new Game.Dimension(480, 330)

    static NAVI_BUTTON_HOVER_COLOR := 0xFFCA1C
    static NAVI_BUTTON_ENABLE_COLOR := 0xFFB103
    static NAVI_BUTTON_DISABLE_COLOR := 0xA07107

    static ABI_BUTTON_HOVER_COLOR := 0x00CD00
    static ABI_BUTTON_ENABLE_COLOR := 0x009200
    static ABI_BUTTON_DISABLE_COLOR := 0x6F6F6F

    GetLocation(xRatio, yRatio) {
        name := Game.WIN_NAME
        WinGetPos, , , win_w, win_h, %name%
    }

    GetCrusaderPosition(index) {
        row := Mod(index - 1, 2)
        col := (index - 1) // 2 
        p := Game.CSD_TL_BUTTON.offset(Game.CSD_OFFSET.x * col, Game.CSD_OFFSET.y * row)
        return new Game.Dimension(p.x, p.y)
    }

    IsInCrusaderTab() {
        if (WinActive(Game.WIN_NAME)) {
            win := Game.WIN_NAME
            WinGetPos, win_x, win_y, , , %win%
            x := Game.LEFT_BUTTON.x
            y := Game.LEFT_BUTTON.y
            PixelGetColor, color, %x%, %y%, RGB
            return (color = Game.NAVI_BUTTON_HOVER_COLOR) || (color = Game.NAVI_BUTTON_ENABLE_COLOR) || (color = Game.NAVI_BUTTON_DISABLE_COLOR)
        }
        return 1
    }

    IsAbilityReady(index) {
        if (WinActive(Game.WIN_NAME) && index >= 1 && index <= 8) {
            win := Game.WIN_NAME
            WinGetPos, win_x, win_y, , , %win%
            ability := Game.GetAbility(index)
            x := ability.x
            y := ability.y
            PixelGetColor, color, %x%, %y%, RGB
            return (color = Game.ABI_BUTTON_ENABLE_COLOR) || (color = Game.ABI_BUTTON_HOVER_COLOR)
        }
        return 0
    }

    GetAbility(index) {
        if (index >= 1 && index <= 8) {
            return Game.ABI_BUTTON.offset((index - 1) * Game.ABI_OFFSET_X, 0)
        }
        return 0
    }

    class Dimension {
        __New(x, y) {
            this.x := x
            this.y := y
        }

        offset(x, y) {
            return new Game.Dimension(this.x + x, this.y + y)
        }

        toPosition() {
            return "x" . this.x . " y" . this.y
        }
    }
}