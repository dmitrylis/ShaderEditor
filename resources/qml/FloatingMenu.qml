import QtQuick 2.12

Column {
    QtObject {
        id: internal

        function fillModeText() {
            const prefix = "Fill Mode:\n"

            switch (sourceImage.fillMode) {
            case Image.Stretch: return prefix + "Stretch"
            case Image.PreserveAspectFit: return prefix + "Fit"
            case Image.PreserveAspectCrop: return prefix + "Crop"
            case Image.Tile: return prefix + "Tile"
            case Image.TileVertically: return prefix + "TileV"
            case Image.TileHorizontally: return prefix + "TileH"
            case Image.Pad: return prefix + "Pad"
            default: return prefix + "unknown"
            }
        }

        function switchFillMode() {

            let currentFillMode = sourceImage.fillMode
            if (currentFillMode++ === 6) {
                currentFillMode = 0
            }
            sourceImage.fillMode = currentFillMode
        }

        property var menuModel: [
            [ "Custom\nUniforms", customUniforms.toggleVisible ],
            [ "Open\nImage", function() { dialogs.openImageDialog.openDialog(function(source) { shaderOutput.source = source }) } ],
            [ fillModeText(), switchFillMode ]
        ]
    }

    spacing: 15

    Repeater {
        model: internal.menuModel
        delegate: FloatingButton {
            text: modelData[0]

            onClicked: {
                internal.menuModel[index][1]() // due Qml problems need to call function like that
            }
        }
    }
}
