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
    property variant rshenqian: [Qt.point(218,414),Qt.point(229,422),Qt.point(279,416),Qt.point(327,422),
                                Qt.point(367,388),Qt.point(399,355),Qt.point(427,389),Qt.point(446,413),
                                Qt.point(470,414),Qt.point(490,402),Qt.point(512,421),Qt.point(597,430),
                                Qt.point(710,430),Qt.point(766,430),Qt.point(809,439),Qt.point(1027,439),
                                Qt.point(1098,395),Qt.point(1110,384)]
   //三焦
    property variant rsanjiao: [Qt.point(582,555),Qt.point(620,549),Qt.point(672,544),Qt.point(796,498),Qt.point(979,457),Qt.point(981,401),Qt.point(989,334)]
    property variant lsanjiao: [Qt.point(596,93),Qt.point(631,99),Qt.point(684,115),Qt.point(805,175),Qt.point(980,213),Qt.point(981,275),Qt.point(989,334)]

   //大肠
    property variant rdachang: [Qt.point(589,584),Qt.point(621,572),Qt.point(650,570),Qt.point(677,548),Qt.point(804,508),Qt.point(899,486),Qt.point(977,464),Qt.point(991,333)]
    property variant ldachang: [Qt.point(610,60),Qt.point(642,78),Qt.point(668,85),Qt.point(686,105),Qt.point(812,159),Qt.point(887,182),Qt.point(978,209),Qt.point(991,333)]

    //小肠
    property variant rxiaochang: [Qt.point(592,539),Qt.point(622,538),Qt.point(669,534),Qt.point(791,484),Qt.point(905,451),Qt.point(956,434),Qt.point(880,418),Qt.point(955,397),Qt.point(916,380),Qt.point(970,362),Qt.point(971,345),Qt.point(991,334)]
    property variant lxiaochang: [Qt.point(599,110),Qt.point(632,111),Qt.point(677,120),Qt.point(800,182),Qt.point(911,219),Qt.point(948,226),Qt.point(881,251),Qt.point(949,259),Qt.point(916,291),Qt.point(966,304),Qt.point(970,322),Qt.point(991,334)]

    //胃
    property variant rwei: [Qt.point()]

    property variant allpoints: {"rshenqian":rshenqian}
    property variant jingluo0: ["L-shen-1:1110,384"]
    property int startX: 0
    property int startY: 0
    property int endX: 0
    property int endY: 0
  //  property int drawWidth: 0
    //property int drawHeight: 0

    property int drawStyle: -1 //1 直线 2 圆

    Rectangle {
            id:patientscroll
            y:cellSpace
            width:patienttreatani.width-cellSpace
            height: patienttreatani.height-cellSpace-topcellOffset
            x:leftcellOffset+cellSpace
            Image {
                id: backimage
                source: imgaeshprefix+"right_26_dan.jpg"
                width: 1216
                height: 701
                x:50
                y:5
            }
            Canvas{
                id:mycanvas
                anchors.fill: parent
                antialiasing: false
                onPaint: {
                    var ctx=getContext('2d')
                    ctx.fillStyle = Qt.rgba(1, 1, 0, 0);
                    ctx.fillRect(50, 5, backimage.width, backimage.height);
                    ctx.strokeStyle="green"
                    ctx.lineWidth=4
                    ctx.beginPath()
                    if (drawStyle==1){
                        ctx.moveTo(startX+50,startY+5);
                        ctx.lineTo(endX+50,endY+5);
                    }else{

                        ctx.arc(startX+50,startY+5,10,Math.PI*2)
                    }
                    ctx.stroke();
                    ctx.closePath()
                }
            }
        }

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
                    var rights=obj.point_right.split("-")
                    console.log("routine aaaaa"+obj.point_right+"count="+rights.length);
                    var count=rights.length;
                    //if (count===3)
                    {
                        currentIndex++
                        if (currentIndex<serpointsX.length){

                            if (currentIndex>=1){
                                var points=rights[0].toLowerCase()+rights[1]+"qian";
                                console.log("x="+allpoints[points][(currentIndex-1)%serpointsX.length].x )
                                startX=allpoints[points][(currentIndex-1)%serpointsX.length].x;
                                startY=allpoints[points][(currentIndex-1)%serpointsX.length].y;
                                endX=allpoints[points][currentIndex%serpointsX.length].x;
                                endY=allpoints[points][currentIndex%serpointsY.length].y;
                                drawStyle=1
                                mycanvas.requestPaint()
                            }else if (currentIndex==0){

                               startX=serpointsX[currentIndex%serpointsX.length];
                                startY=serpointsY[currentIndex%serpointsY.length];
                                drawStyle=2
                                mycanvas.requestPaint()

                            }


                        }
                    }



                    console.log("routine "+BAT.stringify(message));
                }
            }


}
