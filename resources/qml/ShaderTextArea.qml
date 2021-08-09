import QtQuick 2.12
import QtQuick.Controls 2.12

import com.dln.highlighter 1.0

Item {
    property alias text: textArea.text
    property alias title: header.text

    clip: true

    ShaderTextAreaHeader {
        id: header

        width: parent.width
        z: 1
    }

    Flickable {
        id: scrollArea

        anchors {
            fill: parent
            topMargin: header.height
            leftMargin: 40
        }
        leftMargin: 10
        rightMargin: 10
        topMargin: 10
        bottomMargin: 10
        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {}
        ScrollBar.horizontal: ScrollBar {}

        TextArea.flickable: TextArea {
            id: textArea

            padding: 0
            selectByMouse: true
            cursorVisible: true
            persistentSelection: true
            wrapMode: TextEdit.NoWrap
            background: Rectangle { width: parent.width; height: parent.height; color: "#272822" }
            color: "#f8f8de"
            selectedTextColor: "#f8f8de"
            selectionColor: "#49483e"
            font.family: "Consolas"
        }
    }

    // line numbers column
    Rectangle {
        width: scrollArea.anchors.leftMargin
        height: parent.height
        color: "#272822"

        Rectangle {
            anchors.horizontalCenter: parent.right
            width: 2
            height: parent.height
            color: "#33352f"
        }

        Column {
            anchors {
                right: parent.right
                top: parent.top
                rightMargin: 6
                topMargin: scrollArea.anchors.topMargin + scrollArea.contentItem.y
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

    // current line highlight
    FontMetrics {
        id: fontMetrics

        font: textArea.font
    }

    Rectangle {
        y: scrollArea.anchors.topMargin + scrollArea.contentItem.y + textArea.cursorRectangle.y
        height: fontMetrics.height
        width: parent.width
        color: "white"
        opacity: 0.027
    }

    GlslHighlighter {
        quickTextDocument: textArea.textDocument
    }
}
