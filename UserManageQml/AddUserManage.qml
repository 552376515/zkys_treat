import QtQuick 2.0
import TaoQuick 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
Rectangle {
    id:userpwdReset1
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property int dispWidth: 528
    property int dispHeight: 215+52
    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: false
        hoverEnabled: true
        onClicked: {}

        onReleased: {}

        onPressed: {}
    }
    Rectangle{
        id:userpwdResetRect
        width: dispWidth
        height: dispHeight
        x:(userpwdReset1.width-userpwdResetRect.width)/2.0
        y:(userpwdReset1.height-userpwdResetRect.height)/2.0
        Rectangle{
            id:userpwdResetHead
            width: userpwdResetRect.width
            height: 52
            color: "#00C2D5"

            Text{
                id:userpwdResetLbl
                x:20
                text: qsTr("新增用户")
                color: "white"
                font.pixelSize: 24
                height: userpwdResetHead.height
                verticalAlignment: Text.AlignVCenter
            }

        }
        Rectangle{
            id:inputRect
            height: 32
            anchors.top: userpwdResetHead.bottom
            anchors.topMargin: 35
            x:116
            color: "transparent"
            Row{
                id:originname
                width: 208+70+7
                height: 32
                anchors.top: userpwdResetHead.bottom
                anchors.topMargin: 35
                Text {
                    id: leftLbl
                    text: qsTr("医生姓名：")
                    color: "black"
                    font.pixelSize: 16
                    height: originname.height
                    width: 70
                     verticalAlignment: Text.AlignVCenter
                }
                TextField{
                    id:inputoriginname
                    width: 208
                    height: originname.height
                  //  anchors.left: leftLbl.right
                    placeholderText: "点击输入"
                    focus: true
                    echoMode: TextInput.Normal
                    onAccepted: {
                        color:"#999999"
                    }
                    // 当选择输入框的时候才显示键盘
                    onPressed: {
    //                           inputX = x
    //                           inputY = y + height
    //                           inputPanel1.visible = true
                    }
                }
            }

        }






        Button{
            id:suserpwdResetStop
            width: 155
            height: 39
            anchors.top:  inputRect.bottom
            anchors.topMargin: 45
            x:72
            background: Rectangle{
                width: suserpwdResetStop.width
                height: suserpwdResetStop.height
                color: "transparent"
                Image {
                    id: suserpwdResetStopimg
                    width: suserpwdResetStop.width
                    height: suserpwdResetStop.height
                    source: suserpwdResetStop.hovered?imgaeshprefix+"images/gl-piliang-qvxiao-fz.png":imgaeshprefix+"images/gl-piliang-qvxiao.png"
                }
            }

            onClicked:{
                    addUsermanager.visible=false
            }
        }
        Button{
            id:userpwdResetContinue
            width: 155
            height: 39
            anchors.top:  inputRect.bottom
            anchors.topMargin: 45
            anchors.left:suserpwdResetStop.right
            anchors.leftMargin: 72
            background: Rectangle{
                width: userpwdResetContinue.width
                height: userpwdResetContinue.height
                color: "transparent"
                Image {
                    id: userpwdResetContinueimg
                    source: userpwdResetContinue.hovered?imgaeshprefix+"images/ys-xingzeng-baocun-fz.png":imgaeshprefix+"images/ys-xingzeng-baocun.png"
                }
            }
            onClicked:{
//                if (canstartTiaoli){
//                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
//                }
            }
        }



    }

}


