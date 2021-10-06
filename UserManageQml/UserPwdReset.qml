import QtQuick 2.0
import TaoQuick 1.0
import QtQuick.Controls 2.0
Rectangle {
    id:userpwdReset1
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: false
        hoverEnabled: true
        onClicked: {}

        onReleased: {}

        onPressed: {}
    }
    property int dispWidth: 528
    property int dispHeight: 372
    Rectangle{
        id:userpwdResetRect
        width: dispWidth
        height: dispHeight
        x:(userpwdReset1.width-userpwdResetRect.width)/2.0
        y:(userpwdReset1.height-userpwdResetRect.height)/2.0
        Rectangle{
            id:userpwdResetHead
            width: userpwdResetRect.width
            height: 94
            color: "#00C2D5"

            Text{
                id:userpwdResetLbl
                x:44
                text: qsTr("您确定要重置密码吗？")
                color: "#BF0000"
                font.pixelSize: 24
                height: userpwdResetHead.height
                verticalAlignment: Text.AlignVCenter
            }

        }
        Text{
            id:userpwdResetmes
            x:52
            anchors.top: userpwdResetHead.bottom
            anchors.topMargin: 30
            text: qsTr("重置密码后，该用户登录密码变为默认密码： ")
            color: "#000000"
            font.bold: true
            font.pixelSize: 16
        }
        //244,173,135 f4ad87 197 216 197
        Text {
            id: userpwdResetmess1
            x:52
            text: qsTr("111111")
            anchors.top: userpwdResetHead.bottom
            anchors.topMargin: 30
            anchors.left: userpwdResetmes.right
            color: "#BF0000"
            font.pixelSize: 16
        }
        Text {//#204 230 241
            id: userpwdResetmess2
            text: qsTr("提醒用户尽快修改个人密码")
            anchors.top: userpwdResetmess1.bottom
            anchors.topMargin: 20
            x:52
            color: "#cce6f1"
            font.pixelSize: 16
        }



        Button{
            id:suserpwdResetStop
            width: 155
            height: 39
            anchors.top:  userpwdResetmess2.bottom
            anchors.topMargin: 90
            x:72
            background: Rectangle{
                width: suserpwdResetStop.width
                height: suserpwdResetStop.height
                color: "transparent"
                Image {
                    id: suserpwdResetStopimg
                    source: suserpwdResetStop.hovered?imgaeshprefix+"images/gl-piliang-qvxiao-fz.png":imgaeshprefix+"images/gl-piliang-qvxiao.png"
                }
            }


            onClicked:{
                userPasswdReset.visible=false
            }
        }
        Button{
            id:userpwdResetContinue
            width: 155
            height: 39
            anchors.top:  userpwdResetmess2.bottom
            anchors.topMargin: 90
            anchors.left:suserpwdResetStop.right
            anchors.leftMargin: 72
            background: Rectangle{
                width: userpwdResetContinue.width
                height: userpwdResetContinue.height
                color: "transparent"
                Image {
                    id: userpwdResetContinueimg
                    width: userpwdResetContinue.width
                    height: userpwdResetContinue.height
                    source: userpwdResetContinue.hovered?imgaeshprefix+"images/gl-chongzhimima1-fz.png":imgaeshprefix+"images/gl-chongzhimima1.png"
                }
            }

            onClicked:{
                gldoctorModel.modifyDoctorPwd(glselecteddoctor,"111111")
//                if (canstartTiaoli){
//                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
//                }
            }
        }



    }

}
