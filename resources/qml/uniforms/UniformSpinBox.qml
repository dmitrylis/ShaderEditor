import QtQuick 2.12
import QtQuick.Templates 2.12 as T

T.SpinBox {
    id: root

    implicitWidth: contentItem.implicitWidth + up.implicitIndicatorWidth
    implicitHeight: 30
    rightPadding: up.indicator ? up.indicator.width : 0

    from: -5000
    to: 5000
    stepSize: 10

    editable: true
    validator: DoubleValidator { bottom: root.from; top: root.to }
    textFromValue: function(value, locale) { return Number(value / 100.0).toLocaleString(locale, 'f', 2) }
    valueFromText: function(text, locale) { return Number.fromLocaleString(locale, text) * 100 }

    contentItem: TextInput {
        text: root.displayText
        opacity: root.enabled ? 1 : 0.3
        leftPadding: 10
        font: root.font
        selectionColor: "dimgrey"
        verticalAlignment: Qt.AlignVCenter

        readOnly: !root.editable
        validator: root.validator
        inputMethodHints: root.inputMethodHints
        selectByMouse: true
        clip: true
    }

    up.indicator: Text {
        x: parent.width - width
        height: parent.height * 0.5
        width: 30
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
        text: "+"
        opacity: up.pressed ? 0.5 : 1.0
    }

    up.onPressedChanged: root.forceActiveFocus()

    down.indicator: Text {
        x: parent.width - width
        y: parent.height * 0.5
        height: parent.height * 0.5
        width: 30
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
        text: "-"
        opacity: down.pressed ? 0.5 : 1.0
    }

    down.onPressedChanged: root.forceActiveFocus()

    background: Rectangle {
        radius: 5
        color: root.activeFocus ? "#a8a8a1" : "#8b8b85"
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton

        onWheel: {
            if (wheel.angleDelta.y > 0) {
                value += stepSize * 0.5
            }
            else {
                value -= stepSize * 0.5
            }
        }
    }
}
