pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property FontSize size: FontSize {}

    component FontSize: QtObject {
        // 10px
        readonly property int twoxs: 8
        // 12px
        readonly property int xs: 9
        // 14px
        readonly property int sm: 11
        // 16px
        readonly property int base: 12
        // 18px
        readonly property int lg: 14
        // 20px
        readonly property int xl: 15
        // 24px
        readonly property int twoxl: 18
        // 30px
        readonly property int threexl: 23
        // 36px
        readonly property int fourxl: 27
        // 48px
        readonly property int fivexl: 36
        // 60px
        readonly property int sixxl: 45
        // 72px
        readonly property int sevenxl: 54
        // 96px
        readonly property int eightxl: 72
        // 128px
        readonly property int ninexl: 96

        // readonly property int small: 11
        // readonly property int smaller: 12
        // readonly property int normal: 13
        // readonly property int larger: 15
        // readonly property int large: 18
        // readonly property int extraLarge: 28
    }
}
