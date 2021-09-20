import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import zmq.Components 1.0
Item {
    id:rightcontrol
    width: parent
    height: parent
    anchors.fill: parent
    Rectangle{
        id:patientmess
        width: 300
        height: 60
        color: "#c4f1f8"
        Text {
            id: patienttreatname
            text: qsTr("患者：001 张小 36岁")
            color: "#333333"
            width: patientmess.width
            height: patientmess.height
            font.pixelSize: 15
            font.bold: true  		//字体是否加粗，缺省为false
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
            horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
        }
    }
    Rectangle{
        id:whitedisp
        width: 250
        height: 350
        anchors.top: patientmess.bottom
        anchors.topMargin: 20
        x:(patientmess.width-whitedisp.width)/2.0
        color: "white"
        ListView{
            id: listView
            clip: true
            width: parent.width-1;
            height: parent.height;
            spacing :0
            highlight: Rectangle {
            width: listView.width
            height: 40
            color: "lightsteelblue"
            radius: 5
                Behavior on y {
                    SpringAnimation {
                       spring: 3
                       damping: 0.2
                    }
                }
            }
            highlightFollowsCurrentItem: true
            focus: true
            delegate: Rectangle {
                     property color tempcolor: "transparent"
                     color: tempcolor
                     width: listView.width
                     height: 60
                     Row {
                            id: row1
                            anchors.fill: parent
                            spacing: 10
                            anchors.leftMargin: 10

                            Rectangle {
                                width: 10
                                height: 10
                                color: colorCode
                                radius: width/2;
                                anchors.verticalCenter: parent.verticalCenter

                            }
                            Text {
                                text: name
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                font.pointSize: listView.currentIndex == index ? 14 : 11
                                color: "#999999"
                            }
                        }

                     MouseArea{
                         anchors.fill: parent
                         hoverEnabled: true
                         onClicked: {
                             listView.currentIndex = index;
                         }
                         onEntered: {
                             tempcolor = "#a7e094"
                         }

                         onExited: {
                             tempcolor = "transparent"
                         }
                     }
                 }
                        model: ListModel{
                            ListElement {
                                                name: "综合方舱门"
                                                colorCode: "green"
                                            }

                                            ListElement {
                                                name: "网络交换机"
                                                colorCode: "red"
                                            }

                                            ListElement {
                                                name: "设备"
                                                 colorCode: "green"
                                            }
                        }
                        Rectangle {
                                   width: 1;
                                   height: parent.height;
                                   color: "gray";
                                   anchors.right: parent.right;
                               }

        }
    }

    CusButton{
        id: regButton
        width:250
        height:60
        x:15
        anchors.top: whitedisp.bottom
        anchors.topMargin: 20
        text:"识别经络"
        backgroundColorNormal:"#f5f6f7"
        backgroundColorPressed:"#f5b750"
        selected:true
        onClicked:{
               senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\"2号姿势\"}}"));
        }

    }
    CusButton{
        id: regButton1
        x:15
        width:250
        height:60
        anchors.top: regButton.bottom
        anchors.topMargin: 20
        text:"开始调理"
        backgroundColorNormal:"#f5f6f7"
        backgroundColorPressed:"#f5b750"
        selected:false
        onClicked:{
            senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
            realpatient1.visible=true;
            realpatient2.visible=false;
        }


    }
    ZMQSocket {
        id: senderright
        type: ZMQSocket.Req
        addresses: ["tcp://192.168.1.59:9555"]

        onMessageReceived: {
           var ss=BAT.stringify(message)[0];

          //  rightcontrolTimer.running=true;

            if (ss==="identify_success"){
                 toReconize();
                console.log("in equal")
              //  realpatient.visible=false
               // realpatient2.visible=true;
             //  rightcontrolTimer.stop()
            }
            if (ss==="start_cure_success"){

            }

            console.log("right control onMessageReceived +"+message +" "+ss)
        }
    }

    Timer {
        id: rightcontrolTimer
        interval: 4
        running: false
        repeat: false
        onTriggered: {
            console.log("right control timer")
            toReconize();
           rightcontrolTimer.stop()
        }
    }
    Component.onCompleted: {
       // senderright.connectSocket();
       // theModel.append({"eachname":"天眼相机","eachimage":"qrc:/new/prefix1/Image/obama2.jpg", "price":"¥60"})
    }
    onVisibleChanged: {
        if (visible){
             senderright.connectSocket();
        }else{
            //senderright.close();
        }
    }
}
