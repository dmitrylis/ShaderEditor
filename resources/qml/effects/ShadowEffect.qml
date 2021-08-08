import QtQuick 2.12
import QtGraphicalEffects 1.12

DropShadow {
    id: root

    property color shadowColor: "black"
    property real alpha: 0.35

    horizontalOffset: 0
    verticalOffset: 6
    radius: 12
    samples: 2 * radius + 1
    cached: true
    color: Qt.rgba(root.shadowColor.r,
                   root.shadowColor.g,
                   root.shadowColor.b,
                   root.alpha)
}
