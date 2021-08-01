import QtQuick 2.12

Item {
    id: root

    property string vertexShader: ""
    property string fragmentShader: ""
    property int status: 0
    property string log: ""
    property real time: 0

    Image {
        anchors.fill: parent
        source: "qrc:/sample_image.jpg"
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: ShaderEffect {
            property vector2d u_resolution: Qt.vector2d(root.width, root.height)
            property vector2d u_mouse: Qt.vector2d(mouseArea.mouseX, mouseArea.mouseY)
            property real u_time: root.time

            vertexShader: root.vertexShader
            fragmentShader: root.fragmentShader

            mesh: GridMesh { resolution: Qt.size(16, 16) }

            Component.onCompleted: {
                root.status = status
                root.log = log
            }

            onStatusChanged: {
                root.status = status
            }

            onLogChanged: {
                root.log = log
            }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
    }

    Timer {
        running: true
        repeat: true
        interval: 34

        onTriggered: {
            root.time += 0.01
        }
    }
}
