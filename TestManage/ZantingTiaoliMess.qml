import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    id:jingluoshibieFail
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
    property int dispWidth: 552
    property int dispHeight: 346+52
    Rectangle{
        id:jingluodispRect
        width: dispWidth
        height: dispHeight
        x:(jingluoshibieFail.width-jingluodispRect.width)/2.0
        y:(jingluoshibieFail.height-jingluodispRect.height)/2.0
        Rectangle{
            id:jingluofailHead
            width: jingluodispRect.width
            height: 52
            color: "#00C2D5"

            Text{
                id:shibiefailLbl
                x:18
                y:19
                text: qsTr("暂停调理")
                color: "white"
                font.pixelSize: 16
                height: jingluofailHead.height
                verticalAlignment: Text.AlignVCenter
            }
            CusButton_Image{
                id:shibiefailExit
                x:jingluofailHead.width-30-20
                width: 30
                height: 30
                y:(jingluofailHead.height-shibiefailExit.height)/2.0
                btnImgUrl:imgaeshprefix+"images/ys-guanbi.png"
                onClicked: {
                    zantingshibiemess.visible=false

                }
            }
        }
        Text{
            id:sbibiefailmess
            x:52
            anchors.top: jingluofailHead.bottom
            anchors.topMargin: 30
            text: qsTr("调理暂停中...")
            color: "#BF0000"
            font.bold: true
            font.pixelSize: 22
        }
        //244,173,135 f4ad87 197 216 197
        Text {
            id: shibieflaimess1
            x:52
            text: qsTr("排除异常后，可以直接【")
            anchors.top: sbibiefailmess.bottom
            anchors.topMargin: 20
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess2
            text: qsTr("继续调理")
            anchors.top: sbibiefailmess.bottom
            anchors.topMargin: 20
            anchors.left: shibieflaimess1.right
            color: "#c5d8c5"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess3
            text: qsTr("】;")
            anchors.left: shibieflaimess2.right
            anchors.top: sbibiefailmess.bottom
            anchors.topMargin: 20
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess4
            x:52
            text: qsTr("或调整患者体位并【")
            anchors.top: shibieflaimess1.bottom
            anchors.topMargin: 20
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess5
            text: qsTr("重新识别")
            anchors.top: shibieflaimess1.bottom
            anchors.topMargin: 20
            anchors.left: shibieflaimess4.right
            color: "#f4ad87"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess6
            text: qsTr("】后进行调理。")
            anchors.left: shibieflaimess5.right
            anchors.top: shibieflaimess1.bottom
            anchors.topMargin: 20
            color: "#000000"
            font.pixelSize: 16
        }

        CusButton_Image{
            id:shibieStop
            width: 125
            height: 36
            anchors.top:  shibieflaimess4.bottom
            anchors.topMargin: 120
            x:25
            btnImgUrl:imgaeshprefix+"images/ys-zhongzhi.png"
            btnImgHovered:imgaeshprefix+"images/ys-zhongzhi-fz.png"
            onClicked:{

            }
        }
        CusButton_Image{
            id:resbibie
            width: 155
            height: 39
            anchors.top:  shibieflaimess4.bottom
            anchors.topMargin: 114
            anchors.left:shibieStop.right
            anchors.leftMargin: 30
            btnImgUrl:imgaeshprefix+"images/ys-reshibie.png"
            btnImgHovered:imgaeshprefix+"images/ys-reshibie-fz.png"
            onClicked:{
                if (canstartTiaoli){
                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
                }
            }
        }
        CusButton_Image{
            id:rconbibie
            width: 155
            height: 39
            anchors.top:  shibieflaimess4.bottom
            anchors.topMargin: 114
            anchors.left:resbibie.right
            anchors.leftMargin: 30
            btnImgUrl:imgaeshprefix+"images/ys-continueshibie.png"
            btnImgHovered:imgaeshprefix+"images/ys-continueshibie-fz.png"
            onClicked:{
                if (canstartTiaoli){
                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
                }
            }
        }


    }

}
