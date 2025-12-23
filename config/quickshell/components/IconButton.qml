import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

StyledButton {
    id: root
    // Values: "default", "narrow", "wide"
    property string buttonWidth: "default"

    horizontalPadding: 0
    implicitWidth: {
        if (root.buttonWidth === "narrow") {
            switch (root.size) {
            case "xs":
                return 28;
            case "sm":
                return 32;
            case "md":
                return 48;
            case "lg":
                return 64;
            case "xl":
                return 104;
            default:
                return 32;
            }
        }

        if (root.buttonWidth === "wide") {
            switch (root.size) {
            case "xs":
                return 40;
            case "sm":
                return 52;
            case "md":
                return 72;
            case "lg":
                return 128;
            case "xl":
                return 184;
            default:
                return 52;
            }
        }

        return root.implicitHeight;
    }

    iconSize: {
        switch (root.size) {
        case "xs":
            return 20;
        case "sm":
        case "md":
            return 24;
        case "lg":
            return 32;
        case "xl":
            return 40;
        default:
            return 20;
        }
    }
}
