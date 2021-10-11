import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
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
    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: false
        hoverEnabled: true
        onClicked: {}

        onReleased: {}

        onPressed: {}
    }
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

        Button {
            id:qvquxiao
            width: 155
            height: 39
            anchors.top:  shibieflaimess5.bottom
            anchors.topMargin: 50
            x:72
            background:Rectangle{
                width: qvquxiao.width
                height: qvquxiao.height
                color: "transparent"
                Image{
                    id:qvquxiaoimg
                    width: qvquxiao.width
                    height: qvquxiao.height
                    source: qvquxiao.hovered?imgaeshprefix+"images/ys-xingzeng-qvxiao-fz.png":imgaeshprefix+"images/ys-xingzeng-qvxiao.png"
                }
            }

            onClicked:{
                canceltreatManage.visible=false
            }
        }
        Button{
            id:qvshanchu
            width: 155
            height: 39
            anchors.top:  shibieflaimess5.bottom
            anchors.topMargin: 50
            anchors.left:qvquxiao.right
            anchors.leftMargin: 70
            background:Rectangle{
                width: qvshanchu.width
                height: qvshanchu.height
                color: "transparent"
                Image{
                    id:qvshanchuimg
                    width: qvshanchu.width
                    height: qvshanchu.height
                    source: qvshanchu.hovered?imgaeshprefix+"images/gl-qvrenshanchu-fz.png":imgaeshprefix+"images/gl-qvrenshanchu.png"
                }
            }

            onClicked:{
//                if (canstartTiaoli){
//                    senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
//                }
                canceltreatManage.visible=false
            }
        }



    }

}
