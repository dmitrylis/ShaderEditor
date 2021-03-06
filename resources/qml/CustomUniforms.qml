import QtQuick 2.12
import QtQuick.Controls 2.12

import com.dln.PropertyHandler 1.0

import "uniforms"

Rectangle {
    function toggleVisible() {
        if (width === 320) {
            width = 0
        }
        else {
            width = 320
        }
    }

    width: 0
    visible: width > 0
    color: "#272822"
    clip: true

    Behavior on width { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }

    ListView {
        anchors {
            fill: parent
            margins: 5
        }
        spacing: 5
        model: _dynamicPropertyHandler.dynamicPropertyModel

        header: Item {
            width: ListView.view.width
            height: headerDelegate.height + ListView.view.spacing

            Uniform {
                id: headerDelegate

                width: parent.width
                actionIcon: "qrc:/resources/assets/images/add.png"

                onActionClicked: {
                    if (_dynamicPropertyHandler.assignProperty(name, type, value)) {
                        headerDelegate.reset()
                    }
                }
            }
        }

        delegate: Uniform {
            width: ListView.view.width
            name: NameRole
            type: TypeRole
            value: ValueRole
            actionIcon: "qrc:/resources/assets/images/remove.png"
            readOnly: true

            onValueModified: {
                _dynamicPropertyHandler.updateProperty(NameRole, value)
            }

            onActionClicked: {
                dialogs.removeUniformDialog.openDialog(NameRole, function(name) { _dynamicPropertyHandler.removeProperty(name) })
            }
        }
    }
}
