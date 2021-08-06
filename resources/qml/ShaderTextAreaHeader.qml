import QtQuick 2.12

Rectangle {
    property alias text: textItem.text

    implicitWidth: 200
    implicitHeight: 33
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
