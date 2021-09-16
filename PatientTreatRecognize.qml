import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import zmq.Components 1.0
Item {
    id:patienttreat
    width: parent
    height: parent
    anchors.fill: parent
    property string mydatastr: ""
    property int indexMess: 0

    property int censorCellHeight: 350
    property int rightCellWidth: 300
    property int leftcellOffset: 30
    property int topcellOffset: 20
    property int cellSpace: 15
    Rectangle{
        id:background

        x:leftcellOffset
        y:topcellOffset
        width: (realpatient2.width-background.x*2-rightCellWidth)
        height: (realpatient2.height-topcellOffset*2)
        color: "black"
    }

    Rectangle{
        id:treathead
        y:topcellOffset
        x:leftcellOffset
        width: background.width
        height: 35
        color: "#c4f1f8"
        Row{
            CusButton {
                id: treathead1
                x:10
                width: 110
                height: treathead.height
                text: qsTr("实时画面")
                backgroundColorNormal:"#70c0cc"
                backgroundColorPressed:"black"
                textColor:"white"
                onClicked: {

                }
            }
            CusButton{
                id:treathead2
                x:10+110+2
                width: 110
                height: treathead.height
                text: qsTr("识别画面")
                backgroundColorNormal:"#70c0cc"
                backgroundColorPressed:"black"
                textColor:"white"
                //selected:"true"
                onClicked: {
//                    CodeImage.initData(4);
//                                    CodeImage.initData(5);
//                                    CodeImage.initData(6);
                    //                CodeImage.initData(7);
                   /// sender.sendMessage(BAT.byteArrayfy("{\"msg\":\"img\",\"camera\":\""+indexMess+"\"}"));

                }
            }
            CusButton{
                id:treathead3
                x:10+220+4
                width: 110
                height: treathead.height
                text: qsTr("调理画面")
                backgroundColorNormal:"#70c0cc"
                backgroundColorPressed:"black"
                textColor:"white"
                onClicked: {

                }
            }
        }
    }
//    Rectangle{
//        id:spacewhite1
//        anchors.top: treathead.bottom
//        x:10
//        width: 1250
//        height: 10
//        color: "white"
//    }

    Rectangle{
    //        z:1
    //        anchors.horizontalCenter: parent.horizontalCenter
            id:patientscroll
            anchors.top: treathead.bottom
            anchors.topMargin: cellSpace
            anchors.bottom: parent.bottom
            anchors.bottomMargin: topcellOffset
         //   anchors.rightMargin: 10
//            anchors.left: parent.left
//            anchors.leftMargin: 10
            color: "transparent"
            width:background.width-cellSpace
            height: background.height-treathead.height-cellSpace
            x:leftcellOffset+cellSpace

            GridView {
                anchors.fill: patientscroll
                clip: true
                model:  ListModel {
                            id: theModel
                            ListElement {
                                eachname: "天\n眼\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
                                eachid:4
                            }
                            ListElement {
                                eachname: "头\n部\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:5
                            }
                            ListElement {
                                eachname: "左\n手\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:6
                            }
                            ListElement {
                                eachname: "右\n手\n相\n机"
                                eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                eachid:7
                            }
                        }
                cellWidth: patientscroll.width/2
                cellHeight: patientscroll.height/2
                delegate: numberDelegate

            Component {
                id: numberDelegate

                Rectangle {
                    id: wrapper
                    width: patientscroll.width/2-15
                    height: patientscroll.height/2-15
                    //x:5
//                    anchors.topMargin:10
//                    anchors.leftMargin: 10
                    color: "lightGreen"
                    border.color: "black"
                    border.width: 1

                    Rectangle{
                        id:leftname
                        width: 25
                        height:wrapper.height
                        color: "red"
                        Text {
                            id:landscape_name
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 20
                            font.pixelSize: 15
                            text: eachname
                            font.bold: true  		//字体是否加粗，缺省为false
                            verticalAlignment: Text.AlignTop 	//垂直居中，控件必须有height才可以使用
                            horizontalAlignment: Text.AlignVCenter 	//水平居中，控件必须有width才可以使用
                           // rotation: -90
                        }
                    }
                    Rectangle{  //使图片边角有圆弧
                        id:maskrect
                        radius: 10
                        color: "lightgray"
                        anchors.top: parent.top
                        anchors.left: leftname.right
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        Image {
                            id:theimage
                            anchors.fill: parent
                           // source: eachimage
                            visible: true
                        }
                        Connections{
                                target: CodeImage

                                onCallQmlRefeshImg:{
                                     console.log("callonrefrsh11");
                                    //theimage.source = ""
                                    if ((eachid)==index){
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

                    }
                   // radius: 10

                }
            }
            }

        }
        Component.onCompleted: {
          //  sender.connectSocket();

           // theModel.append({"eachname":"天眼相机","eachimage":"qrc:/new/prefix1/Image/obama2.jpg", "price":"¥60"})
        }//添加元素

        onVisibleChanged: {
           if (visible){
                CodeImage.initData(4);
                CodeImage.initData(5);
                CodeImage.initData(6);
                CodeImage.initData(7);
            }
        }

        Rectangle{
            id:rightdisp
            width: 300
            height: background.height+20
            anchors.left: patientscroll.right
            anchors.leftMargin: 30
            y:0
            color: "#90cfd8"
            CaseRightControl{
                id:caserightContrl
                width: 300
                height: background.height+20
            }

        }


}
