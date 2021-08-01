import QtQuick 2.0

Rectangle {
    property alias text: textItem.text

    implicitWidth: 200
    implicitHeight: 25
    color: "lightgrey"

    Text {
        id: textItem

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 25
        }
    }
}
