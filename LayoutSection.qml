import QtQuick 2.0

Rectangle {
    property alias text: textItem.text

    implicitWidth: 200
    implicitHeight: 30
    color: "#33352f"

    Text {
        id: textItem

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 15
        }
        color: "white"
    }
}
