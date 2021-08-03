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

        background: Rectangle { color: "#2e2f30" }
        color: "white"
        selectedTextColor: "white"
        selectionColor: "#565757"

    }

    GlslHighlighter {
        quickTextDocument: textArea.textDocument ///////
    }
}
