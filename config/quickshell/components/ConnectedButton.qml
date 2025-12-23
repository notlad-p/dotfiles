import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

StyledButton {
    id: root
    Layout.minimumWidth: 48

    radius: {
        switch (root.size) {
        case "xs":
        case "sm":
        case "md":
          return Theme.radius.small;
        case "lg":
          return Theme.radius.large;
        case "xl":
          return Theme.radius.largeIncreased;
        default:
          return Theme.radius.small;
        }
    }

    pressedRadius: {
        switch (root.size) {
        case "xs":
        case "sm":
        case "md":
            return Theme.radius.extraSmall;
        case "lg":
            return Theme.radius.medium;
        case "xl":
            return Theme.radius.large;
        default:
            return Theme.radius.extraSmall;
        }
    }
}
