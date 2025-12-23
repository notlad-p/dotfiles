import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

WrapperRectangle {
    id: root
    required property string iconName

    color: Colors.black800
    margin: 11
    radius: 8

    Icon {
        iconName: root.iconName
        iconColor: Colors.white
        size: 20
    }
}
