class Game {
    static WIN_NAME := "Crusaders of The Lost Idols"

    static WIN_SIZE := new Game.Dimension(1016, 714)
    static LEVELUP_BUTTON := new Game.Dimension(994, 664)
    static UPGRADE_BUTTON := new Game.Dimension(994, 566)
    static CSD_TL_BUTTON := new Game.Dimension(300, 550)
    static CSD_OFFSET := new Game.Dimension(310, 90)
    static CLICK_LOCATION := new Game.Dimension(480, 330)

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