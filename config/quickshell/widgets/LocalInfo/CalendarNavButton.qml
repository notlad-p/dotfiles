// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Widgets

import "root:/components"
import "root:/config"

Button {
    id: navButton
    required property string btnType
    required property Item listView

    onClicked: {
        if (btnType === "decrement") {
            listView.decrementCurrentIndex();
        } else {
            listView.incrementCurrentIndex();
        }
    }

    background: WrapperRectangle {
        margin: 4
        radius: 6
        color: calNavHoverHandler.hovered ? Colors.black400 : Colors.black500

        HoverHandler {
            id: calNavHoverHandler
            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        Icon {
            iconName: navButton.btnType === "decrement" ? "caret-left" : "caret-right"
        }
    }
}
