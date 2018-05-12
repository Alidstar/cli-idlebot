class Game {
    static WIN_NAME := "Crusaders of The Lost Idols"

    static WIN_SIZE := new Game.Dimension(1016, 714)
    static LEVELUP_BUTTON := new Game.Dimension(994, 664)
    static UPGRADE_BUTTON := new Game.Dimension(994, 566)
    static LEFT_BUTTON := new Game.Dimension(22, 615)
    static RIGHT_BUTTON := new Game.Dimension(994, 615)

    static CSD_TL_BUTTON := new Game.Dimension(300, 550)
    static CSD_OFFSET := new Game.Dimension(310, 90)

    static CLICK_LOCATION := new Game.Dimension(480, 330)

    static NAVI_BUTTON_HOVER_COLOR := 0xFFCA1C
    static NAVI_BUTTON_ENABLE_COLOR := 0xFFB103
    static MAVI_BUTTON_DISABLE_COLOR := 0xA07107

    GetLocation(xRatio, yRatio) {
        name := Game.WIN_NAME
        WinGetPos, , , win_w, win_h, %name%
    }

    GetCrusaderPosition(index) {
        row := Mod(index - 1, 2)
        col := (index - 1) // 2 
        x := (col * Game.CSD_OFFSET.x) + Game.CSD_TL_BUTTON.x
        y := (row * Game.CSD_OFFSET.y) + Game.CSD_TL_BUTTON.y
        return new Game.Dimension(x, y)
    }

    IsInCrusaderTab() {
        if (WinActive(Game.WIN_NAME)) {
            win := Game.WIN_NAME
            WinGetPos, win_x, win_y, , , %win%
            x := Game.LEFT_BUTTON.x
            y := Game.LEFT_BUTTON.y
            PixelGetColor, color, %x%, %y%, RGB
            return (color = Game.NAVI_BUTTON_HOVER_COLOR) || (color = Game.NAVI_BUTTON_ENABLE_COLOR) || (color = Game.MAVI_BUTTON_DISABLE_COLOR)
        }
        return 1
    }

    class Dimension {
        __New(x, y) {
            this.x := x
            this.y := y
        }

        toPosition() {
            return "x" . this.x . " y" . this.y
        }
    }
}