import QtQuick 2.12

import QtQuick.Controls 2.12 as Controls2
import QtQuick.Dialogs 1.2 as Dialogs1

Item {
    property Controls2.Dialog shaderChangeDialog: Controls2.Dialog {
        property int index
        property string fragmentShader
        property var acceptAction // params: index, fragmentShader

        function openDialog(index, fragmentShader, acceptAction) {
            shaderChangeDialog.index = index
            shaderChangeDialog.fragmentShader = fragmentShader
            shaderChangeDialog.acceptAction = acceptAction
            open()
        }

        anchors.centerIn: parent
        title: "This action will reset your progress, are you sure?"
        standardButtons: Controls2.Dialog.Ok | Controls2.Dialog.Cancel
        modal: true

        onAccepted: {
            shaderChangeDialog.acceptAction(shaderChangeDialog.index, shaderChangeDialog.fragmentShader)
        }
    }

    property Dialogs1.FileDialog openImageDialog: Dialogs1.FileDialog {
        property var acceptAction // params: source

        function openDialog(acceptAction) {
            openImageDialog.acceptAction = acceptAction
            open()
        }

        title: "Please choose a picture"
        folder: shortcuts.pictures
        nameFilters: [ "Image files (*.jpg *.jpeg *.png)" ]

        onAccepted: {
            const files = fileUrls
            if (files.length > 0) {
                openImageDialog.acceptAction(files[0])
            }
        }
    }

    property Controls2.Dialog removeUniformDialog: Controls2.Dialog {
        property string name
        property var acceptAction // params: name

        function openDialog(name, acceptAction) {
            removeUniformDialog.name = name
            removeUniformDialog.acceptAction = acceptAction
            open()
        }

        anchors.centerIn: parent
        title: "Do you really want to remove this uniform?"
        standardButtons: Controls2.Dialog.Ok | Controls2.Dialog.Cancel
        modal: true

        onAccepted: {
            removeUniformDialog.acceptAction(removeUniformDialog.name)
        }
    }
}
