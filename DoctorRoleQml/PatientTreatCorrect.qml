import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import zmq.Components 1.0
Item {
    id:patienttreat
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property bool qmlVisible: false
    property int censorCellHeight: 350
    property int rightCellWidth: 300
    property int leftcellOffset: 30
    property int topcellOffset: 27
    property int cellSpace: 15

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
            id:patientscroll
            y:cellSpace
            color: "transparent"
            width:patienttreat.width-cellSpace
            height: patienttreat.height-cellSpace-topcellOffset
            x:leftcellOffset+cellSpace

            GridView {
                anchors.fill: patientscroll
                clip: true
                model:  ListModel {
                            id: theModel
                            ListElement {
                                eachname: "天\n眼\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
                                eachid:0
                            }
                            ListElement {
                                eachname: "头\n部\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:1
                            }
                            ListElement {
                                eachname: "左\n手\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:2
                            }
                            ListElement {
                                eachname: "右\n手\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:3
                            }
                        }
                cellWidth: patientscroll.width/2.0
                cellHeight: patientscroll.height/2.0

                delegate: numberDelegate
            }
            Component {
                id: numberDelegate

                Rectangle {
                    id: wrapper
                    width: patientscroll.width/2-15
                    height: patientscroll.height/2.0-15
                    //x:5
                 //   anchors.topMargin:10
                 //   anchors.leftMargin: 10
                    color: "lightGreen"
                    border.color: "black"
                    border.width: 1

                    Rectangle{
                        id:leftname
                        width: 25
                        height:wrapper.height
                        color: "#363636"
                        Text {
                            id:landscape_name
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 20
                            font.pixelSize: 16
                            text: eachname
                            font.bold: true  		//字体是否加粗，缺省为false
                            color: "#E3E3E3"
                            verticalAlignment: Text.AlignTop 	//垂直居中，控件必须有height才可以使用
                            horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                           // rotation: -90
                        }
                    }
                    Rectangle{  //使图片边角有圆弧
                        id:maskrect
                       // radius: 10
                        color: "lightgray"
                        anchors.top: parent.top
                        anchors.left: leftname.right
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

                        Rectangle{
                            id:themask
                            anchors.fill: parent
                            radius: 10
                            visible: false
                        }
//                        OpacityMask{
//                            source: theimage
//                            maskSource: themask
//                            anchors.fill: theimage
//                            visible: true
//                        }
                    }
                  //  radius: 10

                }
            }

        }

        Component.onCompleted: {
            console.log("oncompleted")
//            receive1.connectSocket();
//            receive2.connectSocket();
//            receive3.connectSocket();
//            receive4.connectSocket();
           // theModel.append({"eachname":"天眼相机","eachimage":"qrc:/new/prefix1/Image/obama2.jpg", "price":"¥60"})
        }//添加元素


        onVisibleChanged: {// This is available in all editors.
            qmlVisible=visible;
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
