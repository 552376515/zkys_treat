import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    id:userpwdReset1
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property int dispWidth: 528
    property int dispHeight: 285+52
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
                text: qsTr("修改密码")
                color: "white"
                font.pixelSize: 24
                height: userpwdResetHead.height
                verticalAlignment: Text.AlignVCenter
            }

        }
        Row{
            id:originpwd
            width: 208+70+7
            height: 32
            anchors.top: userpwdResetHead.bottom
            anchors.topMargin: 35
            Text {
                id: leftLbl
                text: qsTr("原始密码：")
                color: "black"
                font.pixelSize: 16
                height: originpwd.height
                width: 70
                 verticalAlignment: Text.AlignVCenter
            }
            TextField{
                id:inputoriginname
                width: 208
                height: originpwd.height
                anchors.left: leftLbl.right
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

        Row{
            id:newpwd
            width: 208+70+7
            height: 32
            anchors.top: originpwd.bottom
            anchors.topMargin: 10
            Text {
                id: leftLbl1
                text: qsTr("新 密 码：")
                color: "black"
                font.pixelSize: 16
                height: newpwd.height
                width: 70
                 verticalAlignment: Text.AlignVCenter
            }
            TextField{
                id:inputnewname
                width: 208
                height: newpwd.height
                anchors.left: leftLbl1.right
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

        Row{
            id:renewpwd
            width: 208+70+7
            height: 32
            anchors.top: newpwd.bottom
            anchors.topMargin: 10
            Text {
                id: leftLbl2
                text: qsTr("重新输入：")
                color: "black"
                font.pixelSize: 16
                height: renewpwd.height
                width: 70
                 verticalAlignment: Text.AlignVCenter
            }
            TextField{
                id:inputrenewname
                width: 208
                height: renewpwd.height
                anchors.left: leftLbl1.right
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





        CusButton_Image{
            id:suserpwdResetStop
            width: 155
            height: 39
            anchors.top:  renewpwd.bottom
            anchors.topMargin: 90
            x:72
            btnImgUrl:imgaeshprefix+"images/gl-piliang_qvxiao.png"
            btnImgHovered:imgaeshprefix+"images/ys-piliang_qvxiao-fz.png"
            onClicked:{

            }
        }
        CusButton_Image{
            id:userpwdResetContinue
            width: 155
            height: 39
            anchors.top:  renewpwd.bottom
            anchors.topMargin: 90
            anchors.left:suserpwdResetStop.right
            anchors.leftMargin: 72
            btnImgUrl:imgaeshprefix+"images/gl-xingzeng-baocun.png"
            btnImgHovered:imgaeshprefix+"images/gl-xingzeng-baocun-fz.png"
            onClicked:{
//                if (canstartTiaoli){
//                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
//                }
            }
        }



    }

}

