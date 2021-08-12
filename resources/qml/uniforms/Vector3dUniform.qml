import QtQuick 2.12

Column {
    id: root

    property vector3d uniformValue: Qt.vector3d(0.0, 0.0, 0.0)

    spacing: 5

    onUniformValueChanged: {
        spinX.value = root.uniformValue.x * 100
        spinY.value = root.uniformValue.y * 100
        spinZ.value = root.uniformValue.z * 100
    }

    UniformSpinBox {
        id: spinX

        width: parent.width

        onValueModified: {
            root.uniformValue.x = value / 100.0
        }
    }

    UniformSpinBox {
        id: spinY

        width: parent.width

        onValueModified: {
            root.uniformValue.y = value / 100.0
        }
    }

    UniformSpinBox {
        id: spinZ

        width: parent.width

        onValueModified: {
            root.uniformValue.z = value / 100.0
        }
    }
}
