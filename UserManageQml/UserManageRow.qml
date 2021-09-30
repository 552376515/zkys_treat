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
                    text: index<=5 && dataObj ? (qsTr(String(dataObj[roles[index]])) + CusConfig.transString) : ""
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    color: textColor
                    visible: index<=5
                }
                CusButton_Image{
                    width: 91
                    height: 36
                    btnImgUrl:imgaeshprefix+"images/gl-chongzhimima.png"
                    btnImgHovered:imgaeshprefix+"images/gl-chongzhimima-fz.png"
                    visible: index===6
                    anchors.centerIn: parent
                    onClicked: {

                    }

                }
                CusButton_Image{
                    width: 67
                    height: 36
                    btnImgUrl:imgaeshprefix+"images/gl-xiugai.png"
                    btnImgHovered:imgaeshprefix+"images/gl-xiugai-fz.png"
                    visible: index===7
                    anchors.centerIn: parent
                    onClicked: {

                    }

                }

                CusButton_Image{
                    width: 67
                    height: 36
                    x:5
                    y:7
                    btnImgUrl: (qsTr(String(dataObj[roles[index]]))===qsTr("禁用")) ? imgaeshprefix+"images/gl-jinyong.png":imgaeshprefix+"images/gl-qiyong.png"
                    btnImgHovered:qsTr(String(dataObj[roles[index]]))===qsTr("禁用") ? imgaeshprefix+"images/gl-jinyong-fz.png":imgaeshprefix+"images/gl-qiyong-fz.png"
                    visible: index==8

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
