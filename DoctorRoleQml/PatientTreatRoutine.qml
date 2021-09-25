import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import QtCharts 2.2
import zmq.Components 1.0

Item {
    property int timer: 0
    id:patienttreatani
    width: parent
    height: parent
    anchors.fill: parent
    property int indexxuewei: 0
    property int indexall: 20
    property int leftcellOffset: 30
    property int topcellOffset: 20
    property int cellSpace: 15
    property int rightCellWidth: 300

     property int currentIndex: -1
    property variant serpointsX: [1110,1098,1027,809,766,710,597,512,490,470,446,427,399,367,327,279,229,218]
    property variant serpointsY: [384,395,439,439,430,430,430,421,402,414,413,389,355,388,422,416,422,414]
    property variant jingluo0: ["L-shen-1:1110,384"]
//    Rectangle{
//        id:background
//        x:leftcellOffset
//        y:topcellOffset
//        width: (realpatient1.width-background.x*2-rightCellWidth)
//        height: (realpatient1.height-topcellOffset*2)
//        color: "black"
//    }



//    Rectangle{
//        id:treathead
//        y:topcellOffset
//        x:leftcellOffset
//        width: background.width
//        height: 35
//        color: "#c4f1f8"
//        Row{
//            CusButton {
//                id: treathead1
//                x:10
//                width: 110
//                height: treathead.height
//                text: qsTr("实时画面")
//                backgroundColorNormal:"#70c0cc"
//                backgroundColorPressed:"black"
//                textColor:"white"

//                onClicked: {

//                }
//            }
//            CusButton{
//                id:treathead2
//                x:10+110+2
//                width: 110
//                height: treathead.height
//                text: qsTr("识别画面")
//                backgroundColorNormal:"#70c0cc"
//                backgroundColorPressed:"black"
//                textColor:"white"
//                onClicked: {

//                }
//            }
//            CusButton{
//                id:treathead3
//                x:10+220+4
//                width: 110
//                height: treathead.height
//                text: qsTr("调理画面")
//                backgroundColorNormal:"#70c0cc"
//                backgroundColorPressed:"black"
//                textColor:"white"
//                //selected:"true"

//                onClicked: {

//                }
//            }
//        }
//    }
//    Rectangle{
//        id:spacewhite1
//        anchors.top: treathead.bottom
//        x:10
//        width: 1250
//        height: 10
//        color: "white"
//    }

    Rectangle{
//            id:patientscroll
//            anchors.top: treathead.bottom
//            anchors.topMargin: cellSpace-5
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: topcellOffset
//            y:treathead.height+topcellOffset+cellSpace
//         //   anchors.rightMargin: 10
////            anchors.left: parent
////            anchors.leftMargin: 10
////            color: "green"
//            width:1216+75
//            height: 701+126
//            x:45
            id:patientscroll
            y:cellSpace
            color: "transparent"
            width:patienttreat.width-cellSpace
            height: patienttreat.height-cellSpace-topcellOffset
            x:leftcellOffset+cellSpace
            Image {
                id: backimage
                source: imgaeshprefix+"right_26_dan.jpg"
                width: 1216
                height: 701
                x:50
                y:5
            }
            ChartView {
                id: chartView
                title: "穴位调理"
                antialiasing: true
                backgroundColor: "transparent"
                animationOptions: ChartView.SeriesAnimations
                titleColor: "#ccffff"
                titleFont.bold: true
                titleFont.family: "方正粗倩_GBK"
                titleFont.pointSize: 15
                legend.visible:true
                legend.alignment: Qt.AlignTop
                margins.left: 0
                margins.right: 0
                margins.top: 0
                margins.bottom: 0
                anchors.fill: patientscroll


                LineSeries {
                    name: "LineSeries"
                    id:lineSeries
                    color: Qt.rgba(1, 0, 0, 1)
                    width: 4
                    axisX: ValueAxis {
                        min:0
                        max:1216
                        tickCount: 5

                    }
                    axisY: ValueAxis {
                        min: 0
                        max: 701
                    }

                }
          }


        }

//        Rectangle{
//            id:rightdisp
//            width: 300
//            height: background.height+20
//            anchors.left: patientscroll.right
//            anchors.leftMargin: 30
//            y:0
//            color: "#90cfd8"
//            CaseRightControl{
//                width: 300
//                height: background.height+20
//            }

//        }


        onVisibleChanged: {
            if (visible){
             senderroutine.connectSocket();

            }else{

            }

         }
            ZMQSocket {
                id: senderroutine
                type: ZMQSocket.Sub
                subscriptions: [""]
                //addresses: ["tcp://192.168.1.59:9570"]
                addresses: ["tcp://127.0.0.1:9570"]
                onMessageReceived: {
                    var data='{"name":"yubao"}'
                   // var json =JSON.stringify(data);
                    var ss=BAT.stringify(message)[0];

                    ss=ss.replace(/[\'\\\/\b\f\n\r\t]/g,"");
                  //
                    var subs=ss.substr(1,ss.length-2)
                   // console.log("routine "+obj.point_right)
                    console.log("routine1 "+subs )
                    var obj = JSON.parse(subs);
                    console.log("routine aaaaa"+obj.point_right);
                    var left=obj.point_right;
                    currentIndex++
                    if (currentIndex<serpointsX.length){
                        lineSeries.append(serpointsX[currentIndex%serpointsX.length],patientscroll.height- serpointsY[currentIndex%serpointsY.length]-10)
                    }

                    console.log("routine "+BAT.stringify(message));
                }
            }


}
