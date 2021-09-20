import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    id:testmanageok
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property int dispWidth: 1200
    property int dispHeight: 660
    property int rightcontrol: 224
    property int showImageIndex: 4
    Rectangle{
        id:testmanageArea
        width: dispWidth
        height: dispHeight
        x:(testmanageok.width-testmanageArea.width)/2.0
        y:(testmanageok.height-testmanageArea.height)/2.0
        Rectangle{
            id:testmanageAreaHead
            width: testmanageArea.width
            height: 58
            color: "#003B42"
            Text{
                id:shibiesuccess
                text: qsTr("经络识别成功")
                x:32
                color: "#00D30F"
                width: 140
                font.pixelSize: 22
                height: testmanageAreaHead.height
                 verticalAlignment: Text.AlignVCenter
            }

            CusButton_Image{
                id:shibiesuccessExit
                x:testmanageAreaHead.width-30-20
                width: 30
                height: 30
                y:(testmanageAreaHead.height-shibiesuccessExit.height)/2.0
                btnImgUrl:imgaeshprefix+"images/ys-guanbi.png"
                onClicked: {
                    testmanageSuccess.visible=false

                }
            }
        }

        Rectangle{
            id:disprecognizeRect
            anchors.top: testmanageAreaHead.bottom
            anchors.topMargin: 14
            x:17
            width: testmanageAreaHead.width-224-disprecognizeRect.x
            height: testmanageArea.height-testmanageAreaHead.height-14*2
            Image {
                id: testmanagedispimg
                source: "file"
            }
            Connections{
                    target: CodeImage

                    onCallQmlRefeshImg:{
                         console.log("callonrefrsh11");
                        //theimage.source = ""
                        if ((eachid)==index){
                            testmanagedispimg.source = "image://CodeImg/"+index+ Math.random()
                        }


                    }
            }

        }
        Rectangle{
            id:disprightcontrol
            anchors.left: disprecognizeRect.right
            height: testmanageArea.height-testmanageAreaHead.height1-14
            width: 224
            CusButton_Image{
                id:startrecognize
                width: 155
                height: 155
                x:(disprightcontrol.width-startrecognize.width)/2.0
                y:209
                btnImgUrl:imgaeshprefix+"images/ys-kaishibiaoli.png"
                btnImgHovered:imgaeshprefix+"images/ys-kaishibiaoli-fz.png"
                //font.pointSize:20

                onClicked:{

                }
            }
            CusButton{
                id:toseeothers
                width: 155
                height: 40
                anchors.top: startrecognize.bottom
                anchors.topMargin: 30
                x:startrecognize.x
                radius: 20
                backgroundColorNormal: "#3AA3AF"
                backgroundColorHovered: "#afafaf"
                text: "查看其他经络"
                font.pixelSize: 18
                textColor: "white"
                onClicked: {
                    showImageIndex++
                    if (showImageIndex>7){
                        showImageIndex=4
                    }

                    CodeImage.initData(showImageIndex)
                }
            }
        }

    }
    onVisibleChanged: {
       if (visible){
            CodeImage.initData(4);
//            CodeImage.initData(5);
//            CodeImage.initData(6);
//            CodeImage.initData(7);
        }

    }
}
