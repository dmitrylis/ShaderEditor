import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Shader Editor")
    color: "#272822"

    TopMenu {
        id: topMenu

        width: parent.width
        z: 1
    }

    SplitView {
        anchors {
            left: parent.left
            right: customUniforms.left
            top: topMenu.bottom
            bottom: logWindow.top
        }
        orientation: Qt.Horizontal

        SplitView {
            width: parent.width * 0.4
            orientation: Qt.Vertical

            ShaderTextArea {
                id: fragmentShaderTextArea

                height: parent.height * 0.5
                text: Shaders.emptyShader
                title: "Fragment Shader"
            }

            ShaderTextArea {
                id: vertexShaderTextArea

                height: parent.height * 0.5
                text: Shaders.defaultVertexShader
                title: "Vertex Shader"
            }
        }

        ShaderOutput {
            id: shaderOutput

            width: parent.width * 0.6
            fragmentShader: fragmentShaderTextArea.text
            vertexShader: vertexShaderTextArea.text
        }
    }

    CustomUniforms {
        id: customUniforms

        anchors {
            right: parent.right
            top: topMenu.bottom
            bottom: logWindow.top
        }
    }

    LogWindow {
        id: logWindow

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    Dialogs {
        id: dialogs

        anchors.fill: parent
    }
}
