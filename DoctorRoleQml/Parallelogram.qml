import QtQuick 2.12

Item {
    property real xs: 0
    property real ys: 0
    property alias radius: rect.radius
    property alias text: title.text
    property alias color: rect.color

    Rectangle{
        id: rect
        anchors.fill: parent
        color: "lightblue"

        transform: Matrix4x4{
            matrix: Qt.matrix4x4(1, xs, 0, 0,
                                 ys, 1, 0, 0,
                                 0,  0, 1, 0,
                                 0,  0, 0, 1)

        }

        Text {
            id: title
            anchors.centerIn: rect
            text: "0"
        }
    }

}
