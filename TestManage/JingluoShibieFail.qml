import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    id:jingluoshibieFail
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property int dispWidth: 552
    property int dispHeight: 274
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
            Image {
                id: shibieshibaiIcon
                width: 27
                height: 27
                x:18
                y:(jingluofailHead.height-shibieshibaiIcon.height)/2.0
                source: imgaeshprefix+"images/ys-shibieshibai.png"
            }
            Text{
                id:shibiefailLbl
                anchors.left: shibieshibaiIcon.right
                anchors.leftMargin: 10
                y:19
                text: qsTr("识别失败")
                color: "white"
                font.pixelSize: 16
                height: shibieshibaiIcon.height
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
                    jingluoshibieshibai.visible=false

                }
            }
        }
        Text{
            id:sbibiefailmess
            x:52
            anchors.top: jingluofailHead.bottom
            anchors.topMargin: 30
            text: qsTr("经络识别失败")
            color: "#BF0000"
            font.bold: true
            font.pixelSize: 22
        }
        //244,173,135 f4ad87
        Text {
            id: shibieflaimess1
            x:52
            text: qsTr("请按【")
            anchors.top: sbibiefailmess.bottom
            anchors.topMargin: 20
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess2
            text: qsTr("识别经络")
            anchors.top: sbibiefailmess.bottom
            anchors.topMargin: 20
            anchors.left: shibieflaimess1.right
            color: "#f4ad87"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess3
            text: qsTr("】按钮，重新识别")
            anchors.left: shibieflaimess2.right
            anchors.top: sbibiefailmess.bottom
            anchors.topMargin: 20
            color: "#000000"
            font.pixelSize: 16
        }
        CusButton{
            id:shibiefailBtn
            text: qsTr("我知道了")
            x:215
            width:100
            height:30
            anchors.top: shibieflaimess3.bottom
            anchors.topMargin: 50
            backgroundColorNormal: "#BF0000"
            font.pixelSize: 18
            textColor: "white"
            radius: 4
            onClicked:{
                jingluoshibieshibai.visible=false
            }
        }
    }

}
