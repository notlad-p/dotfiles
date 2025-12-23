// TODO: rename to StyledText

import QtQuick

import qs.config

Text {
    property real pointSize: Fonts.size.xs
    // property Font.FontWeight weight: Font.Normal
    font.family: "Roboto"
    font.pointSize: pointSize
    font.weight: Font.Normal
    font.letterSpacing: 0.4
    color: Theme.colors._onSurface
    renderType: TextEdit.NativeRendering
}
