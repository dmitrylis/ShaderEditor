import QtQuick 2.12

Column {
    QtObject {
        id: internal

        function fillModeText() {
            switch (sourceImage.fillMode) {
            case Image.Stretch: return "Stretch"
            case Image.PreserveAspectFit: return "Fit"
            case Image.PreserveAspectCrop: return "Crop"
            case Image.Tile: return "Tile"
            case Image.TileVertically: return "TileV"
            case Image.TileHorizontally: return "TileH"
            case Image.Pad: return "Pad"
            default: return "unknown"
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
            [ "Uniforms", customUniforms.toggleVisible ],
            [ "Source", fileDialog.open ],
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
