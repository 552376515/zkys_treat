import QtQuick 2.0
import QtQuick.Controls 2.5

import TaoQuick 1.0

Rectangle {
    id: patientTableRow
    height: visible ? CusConfig.fixedHeight : 0
    visible: dataObj ? dataObj["isVisible"] : false

    property bool isSelected: dataObj ? dataObj["isSelected"] : false
    property bool isChecked: dataObj ? dataObj["isChecked"] : false
    property bool isAlternate: dataObj ? dataObj["isAlternate"] : false
    property bool isTheFirst: true
    onIsCheckedChanged: {
        checkBox.notify = false
        checkBox.checked = isChecked
        checkBox.notify = true
    }
    property var dataObj
    property var widthList
    property var xList
    property var roles
    property color textColor: CusConfig.textColor

    signal checkedChanged(bool checked)
    color: isSelected ?"#ededed":"transparent"

    //color: "transparent"
    Repeater {
        model: roles
        Loader {
            x: xList[index]
            width: widthList[index]
            height: parent.height
            asynchronous: true
            sourceComponent: Item {
                anchors.fill: parent
                Label {
                    text: index<5 && dataObj ? (qsTr(String(dataObj[roles[index]])) + CusConfig.transString) : ""
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    color: textColor
                }
                Button{
                    id:btn
                    width: 75
                    height: 29
                    y:5
                    //anchors.centerIn: parent.Center
                    visible: index===5 &&isTheFirst
                    background: Rectangle{
                        width: btn.width
                        height: btn.height
                        color: "transparent"
                        Image {
                            id: btnimg
                            width: btn.width
                            height: btn.height
                            source: btn.hovered? imgaeshprefix+"images/ys-jilu-kaishitiaoli-fz.png":imgaeshprefix+"images/ys-jilu-kaishitiaoli.png"
                        }
                    }

                }

                Rectangle{
                    width:widthList[index]
                    height: 1
                    y: parent.height-1
                    color: "lightblue"
                }
            }
        }

    }

}
