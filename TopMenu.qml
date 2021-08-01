import QtQuick 2.12
import QtQuick.Controls 2.12

ListView {
    QtObject {
        id: internal

        property int currentShader: 0
    }

    implicitWidth: 200
    implicitHeight: 45
    orientation: ListView.Horizontal
    spacing: 5

    model: [
        { text: "Empty", fragmentShader: Shaders.emptyShader },
        { text: "Empty UV", fragmentShader: Shaders.emptyUvShader },
        { text: "Simple", fragmentShader: Shaders.simpleShader },
        { text: "Linear", fragmentShader: Shaders.linearDemoShader },
        { text: "Expo", fragmentShader: Shaders.expoDemoShader },
        { text: "Greyscale", fragmentShader: Shaders.greyscaleShader },
        { text: "Flag", fragmentShader: Shaders.russiaFlagShader },
        { text: "Circle", fragmentShader: Shaders.circleShader },
        { text: "Distance Field", fragmentShader: Shaders.distanceFieldShader },
        { text: "Polar Coordinates 1", fragmentShader: Shaders.polarCoordinatesShader1 },
        { text: "Polar Coordinates 2", fragmentShader: Shaders.polarCoordinatesShader2 },
        { text: "Ripple Effect 1", fragmentShader: Shaders.rippleEffectShader1 },
        { text: "Ripple Effect 2", fragmentShader: Shaders.rippleEffectShader2 },
        { text: "Heat haze air", fragmentShader: Shaders.heatHazeAirShader },
        { text: "Complex Fog", fragmentShader: Shaders.complexFogShader }
    ]

    delegate: Button {
        text: modelData.text
        highlighted: index === internal.currentShader

        onClicked: {
            internal.currentShader = index
            fragmentShaderTextArea.text = modelData.fragmentShader
        }
    }
}
