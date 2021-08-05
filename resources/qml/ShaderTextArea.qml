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
        leftPadding: 50

        background: Rectangle { width: parent.width; height: parent.height; color: "#272822" }
        color: "#f8f8de"
        selectedTextColor: "#f8f8de"
        selectionColor: "#49483e"

        font.family: "Consolas"

        Item {
            width: 35
            height: parent.height

            Rectangle {
                anchors.right: parent.right
                width: 2
                height: parent.height
                color: "#33352f"
            }

            Column {
                anchors {
                    right: parent.right
                    top: parent.top
                    rightMargin: 6
                    topMargin: textArea.padding
                }

                Repeater {
                    model: textArea.lineCount

                    Text {
                        anchors.right: parent.right
                        font.family: "Consolas"
                        text: index + 1
                        color: "#9d9d96"
                    }
                }
            }
        }

    }

    GlslHighlighter {
        quickTextDocument: textArea.textDocument
    }
}
