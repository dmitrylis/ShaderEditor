import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: root

    property alias name: nameText.text
    property real value: 0.0
    property alias actionText: action.text
    property alias readOnly: nameText.readOnly

    signal valueModified(real value)
    signal actionClicked(string name, real value)

    function reset() {
        root.name = ""
        root.value = 0.0
    }

    width: ListView.view ? ListView.view.width : 200
    height: nameText.height

    TextField {
        id: nameText

        anchors {
            left: parent.left
            right: spinbox.left
            verticalCenter: parent.verticalCenter
            rightMargin: 10
        }
        //color: "white"
        selectByMouse: true
        placeholderText: "Set name"
    }

    SpinBox {
        id: spinbox

        property int decimals: 2
        property real realValue: value / 100.0

        anchors {
            right: action.left
            verticalCenter: parent.verticalCenter
            rightMargin: 10
        }
        from: -500
        to: 500
        stepSize: 10

        validator: DoubleValidator { bottom: spinbox.from; top: spinbox.to }
        textFromValue: function(value, locale) { return Number(value / 100.0).toLocaleString(locale, 'f', spinbox.decimals) }
        valueFromText: function(text, locale) { return Number.fromLocaleString(locale, text) * 100 }

        Component.onCompleted: {
            spinbox.value = root.value * 100.0
        }

        onValueModified: {
            root.valueModified(realValue)
        }
    }

    Button {
        id: action

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        width: 40

        onClicked: {
            root.actionClicked(root.name, spinbox.realValue)
        }
    }
}
