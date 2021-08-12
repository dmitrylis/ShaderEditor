import QtQuick 2.12
import QtQuick.Controls 2.12

import com.dln.PropertyHandler 1.0

Rectangle {
    id: root

    property alias name: nameText.text
    property int type: 0
    property var value: undefined
    property alias actionText: actionButton.text
    property bool readOnly: false

    function nameValid(name) {
        return !!name && !name.match(/^ *$/)
    }

    function reset() {
        root.name = ""
        contentLoader.reset()
    }

    signal actionClicked(string name, int type, var value)
    signal valueModified(var value)

    QtObject {
        id: internal

        function handleType(floatType, sampler2dType, vector2dType, vector3dType, vector4dType, matrix4x4Type) {
            switch(root.type) {
            case PropertyHandler.Float: return floatType
            case PropertyHandler.Sampler2d: return sampler2dType
            case PropertyHandler.Vector2d: return vector2dType
            case PropertyHandler.Vector3d: return vector3dType
            case PropertyHandler.Vector4d: return vector4dType
            case PropertyHandler.Matrix4x4: return matrix4x4Type
            default: return null
            }
        }
    }

    height: headerItem.height + nameText.height + contentLoader.height + 5 + 5 + 5
    radius: 8
    color: "#33352f"

    Item { // different types based on readOnly
        id: headerItem

        width: parent.width
        height: 30

        Text {
            visible: root.readOnly // TODO: loader
            anchors.fill: parent
            text: internal.handleType("Float", "Sampler2d", "Vector2d", "Vector3d", "Vector4d", "Matrix4x4")
            verticalAlignment: Text.AlignVCenter
            leftPadding: 15
            color: "white"
        }

        ComboBox {
            visible: !root.readOnly // TODO: loader
            anchors.fill: parent
            textRole: "text"
            valueRole: "value"
            currentIndex: root.type

            model: [
                { value: PropertyHandler.Float, text: "Float" },
                { value: PropertyHandler.Sampler2d, text: "Sampler2d" },
                { value: PropertyHandler.Vector2d, text: "Vector2d" },
                { value: PropertyHandler.Vector3d, text: "Vector3d"},
                { value: PropertyHandler.Vector4d, text: "Vector4d" },
                { value: PropertyHandler.Matrix4x4, text: "Matrix4x4" }
            ]

            onActivated: {
                root.type = currentValue
                nameText.forceActiveFocus()
            }
        }
    }

    TextField {
        id: nameText

        anchors {
            left: parent.left
            right: actionButton.left
            top: headerItem.bottom
            margins: 5
        }
        height: 30
        color: "black"
        selectedTextColor: "white"
        selectionColor: "dimgrey"
        selectByMouse: true
        placeholderText: "Set uniform name"
        readOnly: root.readOnly

        background: Rectangle {
            radius: 5
            color: nameText.activeFocus ? "#a8a8a1" : "#8b8b85"
        }

        onAccepted: {
            actionButton.clicked()
        }
    }

    UniformButton {
        id: actionButton

        anchors {
            right: parent.right
            top: headerItem.bottom
            margins: 5
        }
        enabled: root.nameValid(root.name)

        onClicked: {
            root.actionClicked(root.name, root.type, contentLoader.item.uniformValue)
        }
    }

    Loader {
        id: contentLoader

        function reset() {
            active = false
            active = true
        }

        anchors {
            left: parent.left
            right: parent.right
            top: nameText.bottom
            margins: 5
        }

        sourceComponent: internal.handleType(floatComponent, sampler2dComponent, vector2dComponent, vector3dComponent, vector4dComponent, matrix4x4Component)

        onItemChanged: {
            if (item && root.value !== undefined) {
                item.uniformValue = root.value
            }
        }

        Connections {
            target: contentLoader.item

            onUniformValueChanged: {
                root.valueModified(contentLoader.item.uniformValue)
            }
        }
    }

    // Float uniform
    Component {
        id: floatComponent

        FloatUniform {
        }
    }

    // Sampler2d uniform
    Component {
        id: sampler2dComponent

        Sampler2dUniform {
        }
    }

    // Vector2d uniform
    Component {
        id: vector2dComponent

        Vector2dUniform {
        }
    }

    // Vector3d uniform
    Component {
        id: vector3dComponent

        Vector3dUniform {
        }
    }

    // Vector4d uniform
    Component {
        id: vector4dComponent

        Vector4dUniform {
        }
    }

    // Matrix4x4 uniform
    Component {
        id: matrix4x4Component

        Matrix4x4Uniform {
        }
    }
}
