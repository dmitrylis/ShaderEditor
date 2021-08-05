import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Shapes 1.12

T.Button {
    id: root

    QtObject {
        id: internal

        property real xOffset
        property real yOffset
        property real textOffset
        property color bgColor

        Behavior on xOffset { NumberAnimation { duration: 150 } }
        Behavior on yOffset { NumberAnimation { duration: 150 } }
        Behavior on textOffset { NumberAnimation { duration: 150 } }
    }

    implicitWidth: contentItem.width
    implicitHeight: 45

    background: Shape {
        id: shapeBg

        ShapePath {
            strokeWidth: -1 // dirty hack
            fillColor: "#272822"
            startX: 0; startY: 0

            PathLine { x: shapeBg.width; y: 0 }
            PathLine { x: shapeBg.width; y: shapeBg.height }

            PathCubic {
                control1X: shapeBg.width - internal.xOffset; control1Y: shapeBg.height + internal.yOffset
                control2X: internal.xOffset; control2Y: shapeBg.height + internal.yOffset
                x: 0; y: shapeBg.height
            }

            PathLine { x: 0; y: 0 }
        }
    }

    contentItem: Item {
        width: Math.max(textItem.width + 20, 90)

        Text {
            id: textItem

            anchors {
                centerIn: parent
                verticalCenterOffset: internal.textOffset
            }
            text: root.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
    }

    states: [
        State {
            name: "normal"
            when: !root.down && !root.hovered && !root.highlighted

            PropertyChanges { target: internal; xOffset: 0; yOffset: 0; textOffset: 0 }
            PropertyChanges { target: textItem; color: "white" }
        },
        State {
            name: "normalHovered"
            when: !root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; xOffset: 20; yOffset: 10; textOffset: 3 }
            PropertyChanges { target: textItem; color: "#58d9ef" }
        },
        State {
            name: "normalHoveredDown"
            when: root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; xOffset: 25; yOffset: 15; textOffset: 6 }
            PropertyChanges { target: textItem; color: "#58d9ef" }
        },
        State {
            name: "highlighted"
            when: !root.down && !root.hovered && root.highlighted

            PropertyChanges { target: internal; xOffset: 20; yOffset: 10; textOffset: 3 }
            PropertyChanges { target: textItem; color: "#58d9ef" }
        },
        State {
            name: "highlightedHovered"
            when: !root.down && root.hovered && root.highlighted

            PropertyChanges { target: internal; xOffset: 25; yOffset: 15; textOffset: 6 }
            PropertyChanges { target: textItem; color: "white" }
        },
        State {
            name: "highlightedHoveredDown"
            when: root.down && root.hovered && root.highlighted

            PropertyChanges { target: internal; xOffset: 30; yOffset: 20; textOffset: 9 }
            PropertyChanges { target: textItem; color: "white" }
        }
    ]
}
