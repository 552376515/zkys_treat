import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle
{
    id:edit
    width: 540
    height: 380
    color: "#aa000000"
    property int year:2020
    property int month: 1
    property int day: 1
    property int hour: 1
    property int minute: 1
    property int second: 1
    function isLeapYear(year) {
        var cond1 = year % 4 == 0;
        var cond2 = year % 100 != 0;
        var cond3 = year % 400 ==0;
        var cond = cond1 && cond2 || cond3;
        if(cond) {
            return true;
        } else {
            return false;
        }
    }
    function timeChange(){
        var normalYear=[31,28,31,30,31,30,31,31,30,31,30,31];
        var leapYear=[31,29,31,30,31,30,31,31,30,31,30,31];
        if(isLeapYear(yearButton.current)){
            dayButton.last = leapYear[monthButton.current-1]
        }else{
            dayButton.last = normalYear[monthButton.current-1]
        }
    }
    Column{
        id: column
        width: parent.width
        height: parent.height
        spacing: 5
        //请选择时间
        Text{
            width: 515
            height: 30
            id:tipsText
            text: qsTr("请选择时间")
            anchors.horizontalCenterOffset: 0
            color: "red"
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        //line
        Rectangle{
            id:line1
            anchors.horizontalCenter: parent.horizontalCenter
            width: 515
            height: 1
            color: "#bcbbbb"
        }

        Row{
            id:row1
            width: parent.width
            height: 20
            Rectangle{
                color: "transparent"
                height: 20
                width: parent.width /6.0
                Text {
                    font.pointSize: 10
                    anchors.centerIn: parent
                    id: text1
                    color: "black"
                    text: qsTr("年")
                }
            }

            Rectangle{
                color: "transparent"
                height: 20;
                width: parent.width /6.0;
                Text {
                    font.pointSize: 10
                    anchors.centerIn: parent
                    id: text2
                    text: qsTr("月")
                }
            }
            Rectangle{
                color: "transparent"
                height: 20;
                width: parent.width /6.0;
                Text {
                    font.pointSize: 10
                    anchors.centerIn: parent
                    text: qsTr("日")
                }
            }
            Rectangle{
                color: "transparent"
                height: 20;
                width: parent.width /6.0;
                Text {
                    font.pointSize: 10
                    anchors.centerIn: parent
                    text: qsTr("时")
                }
            }
            Rectangle{
                color: "transparent"
                height: 20;
                width: parent.width /6.0;
                Text {
                    font.pointSize: 10
                    anchors.centerIn: parent
                    text: qsTr("分")
                }

            }
            Rectangle{
                color: "transparent"
                height: 20;
                width: parent.width /6.0;
                Text {
                    font.pointSize: 10
                    anchors.centerIn: parent
                    text: qsTr("秒")
                }

            }
        }


        Row{
            id: row2
            width:  parent.width
            height:  240
            ListButton{
                id: yearButton
                width:parent.width/6
                height:240
                first:2000
                last :3000
                current:2020
                //onSelectChange:console.log(value)
                onCurrentChanged: {
                    timeChange()
                }
            }
            ListButton{
                id:monthButton
                width:parent.width/6
                height:240
                first:1
                last :12
                current:12
                onCurrentChanged: {
                    timeChange()
                }
            }
            ListButton{
                id:dayButton
                width:parent.width/6
                height:240
                first:1
                last :31
                current:31
            }
            ListButton{
                width:parent.width/6
                height:240
                first:0
                last :59
                current:0
            }
            ListButton{
                width:parent.width/6
                height:240
                first:0
                last :59
                current:0
            }
            ListButton{
                width:parent.width/6
                height:240
                first:0
                last :59
                current:0
            }

        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            width: 515
            layoutDirection: Qt.RightToLeft

            ChangButton{//自定义按钮
                width: 100
                height: 40
                btntext:qsTr("确认")
                onClicked: console.log(width+" "+height)
            }
            ChangButton{
                width: 100
                height: 40
                btntext:qsTr("现在")
            }
            ChangButton{
                width: 100
                height: 40
                btntext:qsTr("今天")
            }

        }
    }


}

