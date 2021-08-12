import QtQuick 2.12
import QtGraphicalEffects 1.12

Column {
    id: root

    property string uniformValue: ""

    spacing: 5

    UniformButton {
        width: parent.width

        text: "Open image"

        onClicked: {
            dialogs.openImageDialog.openDialog(function(source) {
                root.uniformValue = source
            })
        }
    }

    Image {
        id: preview

        width: parent.width
        height: status === Image.Ready ? 135 : 0
        source: root.uniformValue
        fillMode: Image.PreserveAspectCrop

        layer {
            enabled: true
            effect: OpacityMask {
                maskSource: Rectangle {
                    width: preview.width
                    height: preview.height
                    radius: 5
                }
            }
        }
    }
}
