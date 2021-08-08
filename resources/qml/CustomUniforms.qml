import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    function toggleVisible() {
        if (width === 200) {
            width = 0
        }
        else {
            width = 200
        }
    }

    width: 0
    visible: width > 0
    color: "#33352f"

    Behavior on width { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }

    ListView {
        anchors.fill: parent
        model: _dynamicPropertyHandler.dynamicPropertyModel
        delegate: Rectangle {
            width: ListView.view.width
            height: 40

            Row {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 15
                }
                spacing: 10

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: NameRole + "  " + ValueRole
                }

                Button {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "u"
                    width: 40

                    onClicked: {
                        _dynamicPropertyHandler.updateProperty(NameRole, 0.9) // TODO: need to open popup and set fields
                    }
                }

                Button {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "x"
                    width: 40

                    onClicked: {
                        _dynamicPropertyHandler.removeProperty(NameRole)
                    }
                }
            }
        }

        footer: Button {
            width: ListView.view.width
            height: 50
            text: "+ add"

            onClicked: {
                // TODO: need to open popup and set fields
                _dynamicPropertyHandler.assignProperty("testProp", 1.0)
                _dynamicPropertyHandler.assignProperty("testProp2", 1.0)
            }
        }
    }
}
