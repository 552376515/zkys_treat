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
//237,251,208
    signal checkedChanged(bool checked)
    //color: isSelected ? CusConfig.controlColor_pressed : ( isAlternate ? CusConfig.controlColor : Qt.lighter(CusConfig.controlColor, 1.1) )//207,235,250
    color: dataObj ?qsTr(String(dataObj[roles[0]]))==="仰卧手向上"?"#f9e4c6": qsTr(String(dataObj[roles[0]]))==="俯卧手向下" ?"#edfbd0":"#cfe7fa":"transparent"
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
                    color: "#333333"
                    visible: index<=1

                }
                CusButton_Image{

                    width: 17
                    height: 17

                    visible: index===3 && dataObj && qsTr(String(dataObj[roles[index]]))==="1"
                    anchors.centerIn: parent
                    btnImgUrl:imgaeshprefix+"images/cf-shangyi.png"
                    btnImgHovered:imgaeshprefix+"images/cf-shangyi-fz.png"


                    onClicked: {

                    }

                }
                CusButton_Image{

                    width: 17
                    height: 17

                    visible:index===4 && dataObj && qsTr(String(dataObj[roles[index]]))==="1"
                    anchors.centerIn: parent
                    btnImgUrl:imgaeshprefix+"images/cf-xiayi.png"
                    btnImgHovered:imgaeshprefix+"images/cf-xiayi-fz.png"
//                    background: Rectangle{
//                        width: btn2.width
//                        height: btn2.height
//                        color: "transparent"
//                        Image {
//                            id: btn2img
//                            source: btn2.hovered?imgaeshprefix+"images/cf-xiayi-fz.png":imgaeshprefix+"images/cf-xiayi.png"
//                        }
//                    }

                    onClicked: {

                    }

                }

                CusButton_Image{

                    width: 17
                    height: 17
                    x:5
                    y:7
                    visible:index===5 && dataObj && qsTr(String(dataObj[roles[index]]))==="1"
                    btnImgUrl:imgaeshprefix+"images/cf-shanchu.png"
                    btnImgHovered:imgaeshprefix+"images/cf-shanchu-fz.png"
//                    background: Rectangle{
//                        width: btn3.width
//                        height: btn3.height
//                        color: "transparent"
//                        Image {
//                            id: btn3img
//                            source: btn3.hovered?imgaeshprefix+"images/cf-shanchu-fz.png":imgaeshprefix+"images/cf-shanchu.png"
//                        }
//                    }

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
