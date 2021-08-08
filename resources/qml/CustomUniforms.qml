import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    function toggleVisible() {
        if (width === 400) {
            width = 0
        }
        else {
            width = 400
        }
    }

    width: 0
    visible: width > 0
    color: "#33352f"
    clip: true

    Behavior on width { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }

    ListView {
        anchors {
            fill: parent
            margins: 15
        }
        spacing: 10
        model: _dynamicPropertyHandler.dynamicPropertyModel

        header: Item {
            width: ListView.view.width
            height: headerDelegate.height + ListView.view.spacing

            CustomUniformDelegate {
                id: headerDelegate

                width: parent.width
                actionText: "+"

                onActionClicked: {
                    if (!name || !!name.match(/^ *$/)) {
                        return // TODO: show dialog maybe
                    }

                    if (_dynamicPropertyHandler.assignProperty(name, value)) {
                        headerDelegate.reset()
                    }

                    // TODO: show dialog maybe
                }
            }
        }

        delegate: CustomUniformDelegate {
            name: NameRole
            value: ValueRole
            actionText: "x"
            readOnly: true

            onValueModified: {
                _dynamicPropertyHandler.updateProperty(NameRole, value)
            }

            onActionClicked: {
                _dynamicPropertyHandler.removeProperty(NameRole)
            }
        }
    }
}
