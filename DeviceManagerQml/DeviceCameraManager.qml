import QtQuick 2.0
import TaoQuick 1.0
Item {
    id:devicecameramanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property int rightCellWidth: 420
    property int leftcellOffset: 30
    property int topcellOffset: 20
    property int cellSpace: 15
    property int startbuttonwidth: 209
    property int startbuttonheight: 186
    Timer {
        id: corrtimer1
        interval: 15
        running: false
        repeat: false
        onTriggered: {
           CodeImage.initData(0)
           corrtimer1.running=false;
            corrtimer2.running=true;
        }
    }
    Timer {
        id: corrtimer2
        interval: 15
        running: false
        repeat: false
        onTriggered: {
           CodeImage.initData(1)
           corrtimer2.running=false;
            corrtimer3.running=true;
        }
    }
    Timer {
        id: corrtimer3
        interval: 15
        running: false
        repeat: false
        onTriggered: {
           CodeImage.initData(2)
           corrtimer3.running=false;
            corrtimer4.running=true;
        }
    }

    Timer {
        id: corrtimer4
        interval: 15
        running: false
        repeat: false
        onTriggered: {
           CodeImage.initData(3)
           corrtimer4.running=false;
           corrtimer1.running=true;
        }
    }
    Rectangle{
    //        z:1
    //        anchors.horizontalCenter: parent.horizontalCenter
            id:camerascroll
            anchors.bottom: parent.bottom
            anchors.bottomMargin: topcellOffset

            color: "transparent"
            width:devicecameramanager.width-cellSpace-rightCellWidth-leftcellOffset*2
            height: devicecameramanager.height-topcellOffset*2-cellSpace
            x:leftcellOffset+cellSpace

            GridView {
                anchors.fill: camerascroll
                clip: true
                model:  ListModel {
                            id: cameraModel
                            ListElement {
                                eachname: "天眼相机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
                                eachid:0
                            }
                            ListElement {
                                eachname: "头部相机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:1
                            }
                            ListElement {
                                eachname: "左手相机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:2
                            }
                            ListElement {
                                eachname: "右手相机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:3
                            }
                        }
                cellWidth: camerascroll.width/2.0
                cellHeight: camerascroll.height/2.0

                delegate: cameraDelegate
            }
            Component {
                id: cameraDelegate

                Rectangle {
                    id: wrappercamera
                    width: camerascroll.width/2-15
                    height: camerascroll.height/2.0-15

                    color: "lightGreen"
                    border.color: "black"
                    border.width: 1

                    Rectangle{
                        id:topname
                        width: wrappercamera.width
                        height:25
                        color: "#363636"
                        Text {
                            id:camera_name
                            width: topname.width
                            height: topname.height
                            font.pixelSize: 16
                            text: eachname
                            font.bold: true  		//字体是否加粗，缺省为false
                            color: "#E3E3E3"
                            verticalAlignment: Text.AlignTop 	//垂直居中，控件必须有height才可以使用
                            horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                        }
                    }
                    Rectangle{  //使图片边角有圆弧
                        id:maskrect
                       // radius: 10
                        color: "lightgray"
                        anchors.top: topname.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        Image {
                            id:theimage
                            anchors.fill: parent
                            //source: eachimage
                            visible: true
                        }
                        Connections{
                                target: CodeImage

                                onCallQmlRefeshImg:{
                                    // console.log("callonrefrshcorrect");
                                    //theimage.source = ""
                                    if (eachid==index){
                                        theimage.source = "image://CodeImg/"+index+ Math.random()
                                    }


                                }
                        }

                    }

                }
            }

        }
    Rectangle{
        id:camerastartRect
        width: rightCellWidth
        height: camerascroll.height
        anchors.left: camerascroll.right
        anchors.leftMargin: 0
        CusButton_Image{
            id:camerestartbtn
            width:startbuttonwidth
            height:startbuttonheight
            x:(camerastartRect.width-camerestartbtn.width)/2.0
            y:(camerastartRect.height-camerestartbtn.height)/2.0
            btnImgUrl:imgaeshprefix+"images/gl-yijianqidong.png"
            btnImgHovered:imgaeshprefix+"images/gl-yijianqidong-fz.png"
            onClicked:{

            }
        }

    }

    onVisibleChanged: {// This is available in all editors.
        //qmlVisible=visible;
        if (!visible){ //不可见时，把timer 关掉
            corrtimer1.stop();
            corrtimer2.stop();
            corrtimer3.stop();
            corrtimer4.stop();

        }else{
            corrtimer1.start();
        }
    }
}
