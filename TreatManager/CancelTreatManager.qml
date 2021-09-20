import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    id:cancelTreat
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property int dispWidth: 528
    property int dispHeight: 372
    Rectangle{
        id:cancelTreatdispRect
        width: dispWidth
        height: dispHeight
        x:(cancelTreat.width-cancelTreatdispRect.width)/2.0
        y:(cancelTreat.height-cancelTreatdispRect.height)/2.0
        Rectangle{
            id:cancelTreatfailHead
            width: cancelTreatdispRect.width
            height: 94
            color: "#00C2D5"

            Text{
                id:shibiefailLbl
                x:44
                text: qsTr(" 您确定要删除列表中的患者数据吗？")
                color: "#DE0808"
                font.pixelSize: 23
                height: cancelTreatfailHead.height
                verticalAlignment: Text.AlignVCenter
            }

        }
        Text{
            id:cancelmess
            x:45
            anchors.top: cancelTreatfailHead.bottom
            anchors.topMargin: 20
            text: qsTr("此操作无法撤销！")
            color: "#BF0000"
            font.bold: true
            font.pixelSize: 16
        }
        //244,173,135 f4ad87 197 216 197
        Text {
            id: cancelmess1
            x:52
            text: qsTr("当前列表共  ")
            anchors.top: cancelmess.bottom
            anchors.topMargin: 25
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: cancelmess2
            text: qsTr("85")
            anchors.top: cancelmess.bottom
            anchors.topMargin: 25
            anchors.left: cancelmess1.right
            color: "#BF0000"
            font.pixelSize: 16
        }
        Text {
            id: cancelmess3
            text: qsTr("  条患者数据，")
            anchors.left: cancelmess2.right
            anchors.top: cancelmess.bottom
            anchors.topMargin: 25
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: cancelmess4
            x:52
            text: qsTr("包括患者信息、患者病情资料、患者处方记录及患者调理记录")
            anchors.top: cancelmess1.bottom
            anchors.topMargin: 10
            color: "#000000"
            font.pixelSize: 16
        }
        Text {
            id: shibieflaimess5
            text: qsTr("数据。")
            x:52
            anchors.top: cancelmess4.bottom
            anchors.topMargin: 10
            color: "#000000"
            font.pixelSize: 16
        }

        CusButton_Image{
            id:qvquxiao
            width: 155
            height: 39
            anchors.top:  shibieflaimess5.bottom
            anchors.topMargin: 50
            x:72
            btnImgUrl:imgaeshprefix+"images/ys-xingzeng-qvxiao.png"
            btnImgHovered:imgaeshprefix+"images/ys-xingzeng-qvxiao-fz.png"
            onClicked:{
                canceltreatManage.visible=false
            }
        }
        CusButton_Image{
            id:qvshanchu
            width: 155
            height: 39
            anchors.top:  shibieflaimess5.bottom
            anchors.topMargin: 50
            anchors.left:qvquxiao.right
            anchors.leftMargin: 70
            btnImgUrl:imgaeshprefix+"images/gl-qvrenshanchu.png"
            btnImgHovered:imgaeshprefix+"images/gl-qvrenshanchu-fz.png"
            onClicked:{
//                if (canstartTiaoli){
//                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
//                }
            }
        }



    }

}
