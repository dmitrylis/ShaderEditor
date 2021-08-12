import QtQuick 2.12

UniformSpinBox {
    id: root

    property real uniformValue: 0.0

    onUniformValueChanged: {
        value = root.uniformValue * 100
    }

    onValueModified: {
        root.uniformValue = value / 100.0
    }
}
