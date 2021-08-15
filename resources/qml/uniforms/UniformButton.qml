import QtQuick 2.12
import QtQuick.Templates 2.12 as T

T.Button {
    id: root

    QtObject {
        id: internal

        property color bgColor
    }

    implicitWidth: 30
    implicitHeight: 30

    background: Rectangle {
        color: internal.bgColor
        radius: 5
        opacity: root.enabled ? 1.0 : 0.5
    }

    contentItem: Item {
        width: Math.max(textItem.width + 30, 90)
        opacity: root.enabled ? 1.0 : 0.4

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

        Image {
            anchors.centerIn: parent
            visible: status === Image.Ready && !textItem.text
            source: root.icon.source
        }
    }

    states: [
        State {
            name: "normal"
            when: !root.down && !root.hovered && !root.highlighted

            PropertyChanges { target: internal; bgColor: "#a8a8a1" }
        },
        State {
            name: "normalHovered"
            when: !root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; bgColor: "#8b8b85" }
        },
        State {
            name: "normalHoveredDown"
            when: root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; bgColor: "#a8a8a1" }
        }
    ]
}
