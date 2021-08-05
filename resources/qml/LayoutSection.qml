import QtQuick 2.12

Rectangle {
    property alias text: textItem.text

    implicitWidth: 200
    implicitHeight: 35
    color: "#33352f"

    Text {
        id: textItem

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            verticalCenterOffset: 2
            leftMargin: 15
        }
        color: "white"
    }
}
