class Game {
    static WIN_NAME := "Crusaders of The Lost Idols"

    static WIN_RATIO := 0.675 ; h/w

    static CSD_OFFSET_X := 310
    static CSD_OFFSET_Y := 90
    static ABI_OFFSET_X := 40

    static CLICK_LOCATION := new Game.Dimension(550, 330)

    static LCT_ACTIVE := 1 << 1
    static LCT_IN_GAME := 1 << 2
    static LCT_IN_CSD_TAB :=  1 << 3
    static LCT_IN_PLAY_AREA := 1 << 4

    static NAVI_BUTTON_HOVER_COLOR := 0xFFCA1C
    static NAVI_BUTTON_ENABLE_COLOR := 0xFFB103
    static NAVI_BUTTON_DISABLE_COLOR := 0xA07107

    static ABI_BUTTON_HOVER_COLOR := 0x00CD00
    static ABI_BUTTON_ENABLE_COLOR := 0x009200
    static ABI_BUTTON_DISABLE_COLOR := 0x6F6F6F

    __New() {
        if (!WinExist(Game.WIN_NAME)) {
            MsgBox % Game.WIN_NAME . " is not launched"
            ExitApp, -1
        }

        name := Game.WIN_NAMEs
        WinGet, hwnd, ID, %name%
        WinGetPos, win_x, win_y, win_w, win_h, %name%
        this.win_x := win_x
        this.win_y := win_y
        this.win_w := win_w
        this.win_h := win_h
        ; MsgBox % "win location " . win_x . " " . win_y
        ; MsgBox % "win size " . win_w . " " . win_h

        CoordMode, Mouse, Screen
        MouseGetPos, old_mx, old_my

        WinActivate, %name%
        CoordMode, Mouse, Client
        BlockInput, MouseMove
        MouseMove, 0, 0, 0

        CoordMode, Mouse, Window
        MouseGetPos, cli_offset_x, cli_offset_y

        CoordMode, Mouse, Screen
        MouseMove, old_mx, old_my
        BlockInput, MouseMoveOff

        CoordMode, Mouse, Window
        ; MsgBox % "client offset " . cli_offset_x . " " . cli_offset_y

        this.lvlup_button := new Game.Dimension(985, 630).offset(cli_offset_x, cli_offset_y)
        this.upgrade_button := new Game.Dimension(985, 540).offset(cli_offset_x, cli_offset_y)
        this.left_button := new Game.Dimension(10, 585).offset(cli_offset_x, cli_offset_y)
        this.right_button := new Game.Dimension(985, 585).offset(cli_offset_x, cli_offset_y)
        this.csd_button := new Game.Dimension(285, 525).offset(cli_offset_x, cli_offset_y)
        this.abi_button := new Game.Dimension(360, 454).offset(cli_offset_x, cli_offset_y)
    }

    GetCrusaderPosition(index) {
        row := Mod(index - 1, 2)
        col := (index - 1) // 2
        return this.csd_button.offset(Game.CSD_OFFSET_X * col, Game.CSD_OFFSET_Y * row)
    }

    UpdateMouseLocation() {
        this.mouse_location := 0
        this.mouse_location |= WinActive(Game.WIN_NAME) ? Game.LCT_ACTIVE : 0

        CoordMode, Mouse, Screen
        MouseGetPos, mx, my
        CoordMode, Mouse, Window
        isInWindown := mx > this.win_x && mx < this.win_x + this.win_w && my > this.win_y && my < this.win_y + this.win_h
        this.mouse_location |= isInWindown ? Game.LCT_IN_GAME : 0

        win := Game.WIN_NAME
        x := this.left_button.x
        y := this.left_button.y
        PixelGetColor, color, %x%, %y%, RGB
        isInCRDTab := color = Game.NAVI_BUTTON_HOVER_COLOR || color = Game.NAVI_BUTTON_ENABLE_COLOR || color = Game.NAVI_BUTTON_DISABLE_COLOR
        this.mouse_location |= isInCRDTab ? Game.LCT_IN_CSD_TAB : 0
    }

    MouseLocationIs(location) {
        return this.mouse_location & location
    }

    IsAbilityReady(index) {
        if (WinActive(Game.WIN_NAME) && index >= 1 && index <= 8) {
            win := Game.WIN_NAME
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
            return Game.abi_button.offset((index - 1) * Game.ABI_OFFSET_X, 0)
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