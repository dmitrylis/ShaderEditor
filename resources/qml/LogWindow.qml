import QtQuick 2.12

Rectangle {
    id: logWindow

    QtObject {
        id: internal

        function statusToValue(valueCompiled, valueUncompiled, valueError) {
            switch (shaderOutput.status) {
            case ShaderEffect.Compiled: return valueCompiled
            case ShaderEffect.Uncompiled: return valueUncompiled
            case ShaderEffect.Error:
            default: return valueError
            }
        }
    }

    height: Math.min(logTextEdit.height, 300)
    color: internal.statusToValue("green", "orange", "red")

    TextEdit {
        id: logTextEdit

        text: !!shaderOutput.log ? shaderOutput.log : internal.statusToValue("Shaders compiled", "Shaders compiling...", "Unknown error occured")
        readOnly: true
        padding: 5
        selectByMouse: !!shaderOutput.log
    }
}
