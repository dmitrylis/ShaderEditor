import QtQuick 2.12
import QtQuick.Dialogs 1.2

Item {
    id: root

    property string vertexShader: ""
    property string fragmentShader: ""
    property int status: 0
    property string log: ""
    property real time: 0

    Image {
        id: sourceImage

        anchors.fill: parent
        source: "qrc:/resources/assets/images/sample_image.jpg"
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: ShaderEffect {
            id: shaderEffect

            property vector2d u_resolution: Qt.vector2d(root.width, root.height)
            property vector2d u_mouse: Qt.vector2d(mouseArea.mouseX / root.width, mouseArea.mouseY / root.height)
            property real u_time: root.time

            vertexShader: root.vertexShader
            fragmentShader: root.fragmentShader

            mesh: GridMesh { resolution: Qt.size(16, 16) }

            Component.onCompleted: {
                _dynamicPropertyHandler.registerSourceObject(shaderEffect)

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

    FloatingMenu {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }
    }

    FileDialog {
        id: fileDialog

        title: "Please choose a picture"
        folder: shortcuts.pictures
        nameFilters: [ "Image files (*.jpg *.jpeg *.png)" ]

        onAccepted: {
            const files = fileDialog.fileUrls
            if (files.length > 0) {
                sourceImage.source = files[0]
            }
        }
    }
}
