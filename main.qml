import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: rootWindow

    visible: true
    width: 1920
    height: 1080
    title: qsTr("Qml Shader Editor")
    color: "#272822"

    TopMenu {
        id: topMenu

        width: parent.width
    }

    ColumnLayout {
        anchors {
            left: parent.left
            top: topMenu.bottom
            bottom: logWindow.top
        }
        width: parent.width * 0.4
        spacing: 0

        LayoutSection {
            Layout.fillWidth: true
            text: "Fragment Shader"
        }

        ShaderTextArea {
            id: fragmentShaderTextArea

            Layout.fillWidth: true
            Layout.fillHeight: true
            text: Shaders.emptyShader
        }

        LayoutSection {
            Layout.fillWidth: true
            text: "Vertex Shader"
        }

        ShaderTextArea {
            id: vertexShaderTextArea

            Layout.fillWidth: true
            Layout.fillHeight: true
            text: Shaders.defaultVertexShader
        }
    }

    ShaderOutput {
        id: shaderOutput

        anchors {
            right: parent.right
            top: topMenu.bottom
            bottom: logWindow.top
        }
        width: parent.width * 0.6
        fragmentShader: fragmentShaderTextArea.text
        vertexShader: vertexShaderTextArea.text
    }

    LogWindow {
        id: logWindow

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
