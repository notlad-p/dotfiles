import QtQuick

import qs.config

Text {
  id: root
    property real pointSize: Fonts.size.xs
    property bool tabularNums: false
    // Role corresponds to the keys in Theme.typography.roles
    property string role: "bodyMedium"
    property var style: Theme.typography.roles[role]
    property int roundness: Theme.typography.roundness
    property int weight
    property int grade

    color: Theme.palette._onSurface
    font.family: Theme.typography.fontFamily
    font.pixelSize: style.size
    font.weight: style.weight
    font.letterSpacing: style?.letterSpacing || 0
    lineHeight: style?.lineHeight || 1
    lineHeightMode: style?.lineHeight ? Text.FixedHeight : Text.ProportionalHeight
    verticalAlignment: Text.AlignVCenter
    font.variableAxes: {
        const customAxes = {}

        if (root.roundness) {
          customAxes["ROND"] = root.roundness;
        }

        if (root.weight) {
          customAxes["wght"] = root.weight
        }

        if (root.grade) {
          customAxes["GRAD"] = root.grade
        }

        const axes = Object.assign({}, style.axes, customAxes)

        return axes
    }
    font.features: {
        "tnum": tabularNums
    }
    renderType: TextEdit.NativeRendering
}
