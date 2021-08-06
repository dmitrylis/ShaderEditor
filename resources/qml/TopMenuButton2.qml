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
        Rectangle {
            anchors {
                fill: bgRect
                margins: -internal.outlineWidth
            }
            color: "#272822"
            radius: bgRect.radius + internal.outlineWidth
            scale: internal.btnScale

            layer {
                enabled: true
                effect: ShaderEffect {
                    fragmentShader: "\
                        #ifdef GL_ES
                        precision lowp float;
                        #endif

                        uniform sampler2D source;
                        uniform float qt_Opacity;
                        varying highp vec2 qt_TexCoord0;

                        void main() {
                            vec4 p = texture2D(source, qt_TexCoord0);
                            gl_FragColor = step(0.8, qt_TexCoord0.y) * p * qt_Opacity;
                        }"
                }
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
            scale: internal.btnScale
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

        Text {
            id: textItem

            anchors {
                centerIn: parent
                verticalCenterOffset: internal.topOffset
            }
            text: root.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            scale: internal.btnScale
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
