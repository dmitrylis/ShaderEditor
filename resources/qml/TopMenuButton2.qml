import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

T.Button {
    id: root

    QtObject {
        id: internal

        property real topOffset
        property real btnScale
        property color bgColor
        property int outlineWidth: 7

        Behavior on topOffset { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
        Behavior on btnScale { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
    }

    implicitWidth: contentItem.width
    implicitHeight: 55

    background: Item {
        scale: internal.btnScale

        Item {
            anchors {
                horizontalCenter: bgRect.horizontalCenter
                bottom: bgRect.bottom
                bottomMargin: -internal.outlineWidth
            }
            width: childrenRect.width
            height: childrenRect.height * 0.2
            clip: true

            Rectangle {
                anchors.bottom: parent.bottom
                width: bgRect.width + 2 * internal.outlineWidth
                height: bgRect.height + 2 * internal.outlineWidth
                color: "#272822"
                radius: bgRect.radius + internal.outlineWidth
            }
        }

        Rectangle {
            id: bgRect

            anchors {
                centerIn: parent
                verticalCenterOffset: internal.topOffset
            }
            width: parent.width
            height: parent.height - 18
            radius: 9
            color: internal.bgColor

            layer {
                enabled: true
                effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 6
                    radius: 12
                    samples: 2 * radius + 1
                    cached: true
                    color: "#66000000"
                }
            }
        }
    }

    contentItem: Item {
        width: Math.max(textItem.width + 30, 90)
        scale: internal.btnScale

        Text {
            id: textItem

            anchors {
                centerIn: parent
                verticalCenterOffset: internal.topOffset
            }
            text: root.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    states: [
        State {
            name: "normal"
            when: !root.down && !root.hovered && !root.highlighted

            PropertyChanges { target: internal; topOffset: 0; btnScale: 1.0; bgColor: "transparent" }
            PropertyChanges { target: textItem; color: "white" }
        },
        State {
            name: "normalHovered"
            when: !root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; topOffset: 0; btnScale: 1.07; bgColor: "#33352f" }
            PropertyChanges { target: textItem; color: "white" }
        },
        State {
            name: "normalHoveredDown"
            when: root.down && root.hovered && !root.highlighted

            PropertyChanges { target: internal; topOffset: 0; btnScale: 1.0; bgColor: "#33352f" }
            PropertyChanges { target: textItem; color: "white" }
        },
        State {
            name: "highlighted"
            when: !root.down && !root.hovered && root.highlighted

            PropertyChanges { target: internal; topOffset: 8; btnScale: 1.07; bgColor: "#8b8b85" }
            PropertyChanges { target: textItem; color: "black" }
        },
        State {
            name: "highlightedHovered"
            when: !root.down && root.hovered && root.highlighted

            PropertyChanges { target: internal; topOffset: 8; btnScale: 1.14; bgColor: "#7f7f7a" }
            PropertyChanges { target: textItem; color: "black" }
        },
        State {
            name: "highlightedHoveredDown"
            when: root.down && root.hovered && root.highlighted

            PropertyChanges { target: internal; topOffset: 8; btnScale: 1.07; bgColor: "#7f7f7a" }
            PropertyChanges { target: textItem; color: "black" }
        }
    ]
}
