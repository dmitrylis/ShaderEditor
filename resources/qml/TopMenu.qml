import QtQuick 2.12

ListView {
    QtObject {
        id: internal

        property int currentShader: 0
        property var shaderModel: [
            { text: "Empty", fragmentShader: Shaders.emptyShader },
            { text: "Empty UV", fragmentShader: Shaders.emptyUvShader },
            { text: "Simple", fragmentShader: Shaders.simpleShader },
            { text: "Linear", fragmentShader: Shaders.linearDemoShader },
            { text: "Expo", fragmentShader: Shaders.expoDemoShader },
            { text: "Greyscale", fragmentShader: Shaders.greyscaleShader },
            { text: "Flag", fragmentShader: Shaders.russiaFlagShader },
            { text: "Circle", fragmentShader: Shaders.circleShader },
            { text: "Magnifier Glass", fragmentShader: Shaders.magnifierGlassShader },
            { text: "Magic Lens", fragmentShader: Shaders.magicLensShader },
            { text: "Distance Field", fragmentShader: Shaders.distanceFieldShader },
            { text: "Polar Coordinates 1", fragmentShader: Shaders.polarCoordinatesShader1 },
            { text: "Polar Coordinates 2", fragmentShader: Shaders.polarCoordinatesShader2 },
            { text: "Ripple Effect 1", fragmentShader: Shaders.rippleEffectShader1 },
            { text: "Ripple Effect 2", fragmentShader: Shaders.rippleEffectShader2 },
            { text: "Heat haze air", fragmentShader: Shaders.heatHazeAirShader },
            { text: "Fractal", fragmentShader: Shaders.fractalShader },
            { text: "Complex Fog", fragmentShader: Shaders.complexFogShader }
        ]
    }

    implicitWidth: 200
    implicitHeight: 55
    orientation: ListView.Horizontal
    spacing: 10

    model: internal.shaderModel
    delegate: TopMenuButton2 {
        text: modelData.text
        highlighted: index === internal.currentShader
        z: highlighted ? 2 : 1

        onClicked: {
            const originalFragmentShader = internal.shaderModel[internal.currentShader].fragmentShader
            const originalVertexShader = Shaders.defaultVertexShader

            if (originalFragmentShader === fragmentShaderTextArea.text && originalVertexShader === vertexShaderTextArea.text) {
                internal.currentShader = index
                fragmentShaderTextArea.text = modelData.fragmentShader
                vertexShaderTextArea.text = Shaders.defaultVertexShader
            }
            else {
                dialogs.shaderChangeDialog.openDialog(index, modelData.fragmentShader,
                                                      function(index, fragmentShader) {
                                                          internal.currentShader = index
                                                          fragmentShaderTextArea.text = fragmentShader
                                                          vertexShaderTextArea.text = Shaders.defaultVertexShader
                                                      })
            }
        }
    }
    header: Item { width: 10; height: 1 }
    footer: Item { width: 10; height: 1 }
}
