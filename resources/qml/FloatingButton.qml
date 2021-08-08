import QtQuick 2.12
import QtQuick.Templates 2.12 as T

import "effects"

T.Button {
    id: root

    QtObject {
        id: internal

        property real btnScale
        property color bgColor

        Behavior on btnScale { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
    }

    implicitWidth: contentItem.width
    implicitHeight: 55

    background: Rectangle {
        scale: internal.btnScale
        color: internal.bgColor
        radius: 9
        layer {
            enabled: true
            effect: ShadowEffect {}
        }
    }

    contentItem: Item {
        width: Math.max(textItem.width + 30, 90)
        scale: internal.btnScale

        Text {
            id: textItem

            anchors {
                centerIn: parent
            }
            text: root.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
        }
    }

    states: [
        State {
            name: "normal"
            when: !root.down && !root.hovered && !root.highlighted

            PropertyChanges { target: internal; btnScale: 1.0; bgColor: "#a8a8a1" }
        },
        State {
            name: "normalHovered"
            when: !root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; btnScale: 1.07; bgColor: "#8b8b85" }
        },
        State {
            name: "normalHoveredDown"
            when: root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; btnScale: 1.0; bgColor: "#8b8b85" }
        },
        State {
            name: "highlighted"
            when: !root.down && !root.hovered && root.highlighted

            PropertyChanges { target: internal; btnScale: 1.07; bgColor: "#a8a8a1" }
        },
        State {
            name: "highlightedHovered"
            when: !root.down && root.hovered && root.highlighted

            PropertyChanges { target: internal; btnScale: 1.14; bgColor: "#8b8b85" }
        },
        State {
            name: "highlightedHoveredDown"
            when: root.down && root.hovered && root.highlighted

            PropertyChanges { target: internal; btnScale: 1.07; bgColor: "#8b8b85" }
        }
    ]
}
