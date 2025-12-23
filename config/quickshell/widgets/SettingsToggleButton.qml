import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

WrapperRectangle {
    id: root
    required property string iconName
    required property string toggledIconName
    required property bool toggled

    color: root.toggled ? Colors.blue : Colors.black800
    margin: 11
    radius: 8

    Icon {
        iconName: toggled ? root.toggledIconName : root.iconName
        iconColor: root.toggled ? Colors.black700 : Colors.white
        size: 20
        opacity: root.toggled ? 1 : 0.6
    }
}
