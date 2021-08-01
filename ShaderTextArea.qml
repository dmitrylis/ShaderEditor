import QtQuick 2.12
import QtQuick.Controls 2.12

ScrollView {
    property alias text: textArea.text

    clip: true

    TextArea {
        id: textArea

        selectByMouse: true
        wrapMode: TextEdit.NoWrap
        persistentSelection: true
    }
}
