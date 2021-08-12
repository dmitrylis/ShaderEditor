import QtQuick 2.12

Column {
    id: root

    property matrix4x4 uniformValue: Qt.matrix4x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

    spacing: 5

    onUniformValueChanged: {
        spinM11.value = root.uniformValue.m11 * 100
        spinM12.value = root.uniformValue.m12 * 100
        spinM13.value = root.uniformValue.m13 * 100
        spinM14.value = root.uniformValue.m14 * 100

        spinM21.value = root.uniformValue.m21 * 100
        spinM22.value = root.uniformValue.m22 * 100
        spinM23.value = root.uniformValue.m23 * 100
        spinM24.value = root.uniformValue.m24 * 100

        spinM31.value = root.uniformValue.m31 * 100
        spinM32.value = root.uniformValue.m32 * 100
        spinM33.value = root.uniformValue.m33 * 100
        spinM34.value = root.uniformValue.m34 * 100

        spinM41.value = root.uniformValue.m41 * 100
        spinM42.value = root.uniformValue.m42 * 100
        spinM43.value = root.uniformValue.m43 * 100
        spinM44.value = root.uniformValue.m44 * 100
    }

    Row {
        width: parent.width
        spacing: 5

        UniformSpinBox {
            id: spinM11

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m11 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM12

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m12 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM13

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m13 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM14

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m14 = value / 100.0
            }
        }
    }

    Row {
        width: parent.width
        spacing: 5

        UniformSpinBox {
            id: spinM21

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m21 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM22

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m22 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM23

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m23 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM24

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m24 = value / 100.0
            }
        }
    }

    Row {
        width: parent.width
        spacing: 5

        UniformSpinBox {
            id: spinM31

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m31 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM32

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m32 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM33

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m33 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM34

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m34 = value / 100.0
            }
        }
    }

    Row {
        width: parent.width
        spacing: 5

        UniformSpinBox {
            id: spinM41

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m41 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM42

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m42 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM43

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m43 = value / 100.0
            }
        }

        UniformSpinBox {
            id: spinM44

            width: parent.width * 0.25 - 3.75

            onValueModified: {
                root.uniformValue.m44 = value / 100.0
            }
        }
    }
}
