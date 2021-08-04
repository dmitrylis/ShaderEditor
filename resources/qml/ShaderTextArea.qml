import QtQuick 2.12
import QtQuick.Controls 2.12

import dln.com.highlighter 1.0

ScrollView {
    property alias text: textArea.text

    clip: true

    TextArea {
        id: textArea

        selectByMouse: true
        cursorVisible: true
        persistentSelection: true
        wrapMode: TextEdit.NoWrap
        padding: 10

        background: Rectangle { width: parent.width; height: parent.height; color: "#272822" }
        color: "#f8f8de"
        selectedTextColor: "#f8f8de"
        selectionColor: "#49483e"

        font.family: "Consolas"

    }

    GlslHighlighter {
        quickTextDocument: textArea.textDocument
    }
}
