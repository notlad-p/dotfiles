import QtQuick

import "root:/config"

Text {
    property real pointSize: Fonts.size.xs
    // property Font.FontWeight weight: Font.Normal
    font.family: "Inter"
    font.pointSize: pointSize
    font.weight: Font.Normal
    color: Colors.white
    renderType: TextEdit.NativeRendering

    // Component.onCompleted: {
    //     if (parent && parent.hasOwnProperty("layoutDirection")) {
    //         // This is a very rough heuristic
    //         // inLayout = true;
    //         console.log("Component is likely in a Layout.");
    //     } else {
    //         console.log("Component is likely NOT in a Layout.");
    //     }
    // }
}
