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
    //color: isSelected ? CusConfig.controlColor_pressed : ( isAlternate ? CusConfig.controlColor : Qt.lighter(CusConfig.controlColor, 1.1) )
    color: "transparent"
    Repeater {
        model: roles
        Loader {
            x: xList[index]
            width: widthList[index]
            height: parent.height
            asynchronous: true
            sourceComponent: Item {
                anchors.fill: parent
                CusLabel {
                    text: index<=1 && dataObj ? (qsTr(String(dataObj[roles[index]])) + CusConfig.transString) : ""
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    color: textColor
                    visible: index<=1
                }
                CusButton_Image{
                    width: 17
                    height: 17
                    btnImgUrl:imgaeshprefix+"images/cf-shangyi.png"
                    btnImgHovered:imgaeshprefix+"images/cf-shangyi-fz.png"
                    visible: index==3 && qsTr(String(dataObj[roles[index]]))=="1"
                    anchors.centerIn: parent
                    onClicked: {

                    }

                }
                CusButton_Image{
                    width: 17
                    height: 17
                    btnImgUrl:imgaeshprefix+"images/cf-xiayi.png"
                    btnImgHovered:imgaeshprefix+"images/cf-xiayi-fz.png"
                    visible: index==4 && qsTr(String(dataObj[roles[index]]))=="1"
                    anchors.centerIn: parent
                    onClicked: {

                    }

                }

                CusButton_Image{
                    width: 17
                    height: 17
                    x:5
                    y:7
                    btnImgUrl: imgaeshprefix+"images/cf-shanchu.png"
                    btnImgHovered: imgaeshprefix+"images/cf-shanchu-fz.png"
                    visible: index==5 && qsTr(String(dataObj[roles[index]]))=="1"

                    onClicked: {

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
