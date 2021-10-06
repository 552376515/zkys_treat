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
    //胆
    property variant rdan: [Qt.point(302,345),Qt.point(314,354),Qt.point(364,351),Qt.point(411,355),
                                Qt.point(453,323),Qt.point(483,288),Qt.point(511,323),Qt.point(530,347),
                                Qt.point(554,348),Qt.point(573,335),Qt.point(596,353),Qt.point(681,363),
                                Qt.point(795,363),Qt.point(851,364),Qt.point(893,374),Qt.point(1109,374),
                                Qt.point(1193,329),Qt.point(1199,318)]
    property variant ldan: [Qt.point(998,345),Qt.point(986,354),Qt.point(936,351),Qt.point(889,355),
                                Qt.point(847,323),Qt.point(817,288),Qt.point(789,323),Qt.point(770,347),
                                Qt.point(746,348),Qt.point(725,335),Qt.point(704,353),Qt.point(619,363),
                                Qt.point(505,363),Qt.point(449,364),Qt.point(407,374),Qt.point(191,374),
                                Qt.point(117,329),Qt.point(101,318)]

   //三焦
    property variant rsanjiao: [Qt.point(582,555),Qt.point(620,549),Qt.point(672,544),Qt.point(796,498),Qt.point(979,457),Qt.point(981,401),Qt.point(989,334)]
    property variant lsanjiao: [Qt.point(596,93),Qt.point(631,99),Qt.point(684,115),Qt.point(805,175),Qt.point(980,213),Qt.point(981,275),Qt.point(989,334)]

   //大肠
    property variant rdachang: [Qt.point(589,584),Qt.point(621,572),Qt.point(650,570),Qt.point(677,548),Qt.point(804,508),Qt.point(899,486),Qt.point(977,464),Qt.point(991,333)]
    property variant ldachang: [Qt.point(610,60),Qt.point(642,78),Qt.point(668,85),Qt.point(686,105),Qt.point(812,159),Qt.point(887,182),Qt.point(978,209),Qt.point(991,333)]

    //小肠
    property variant rxiaochang: [Qt.point(592,539),Qt.point(622,538),Qt.point(669,534),Qt.point(791,484),Qt.point(905,451),Qt.point(956,434),Qt.point(880,418),Qt.point(955,397),Qt.point(916,380),Qt.point(970,362),Qt.point(971,345),Qt.point(991,334)]
    property variant lxiaochang: [Qt.point(599,110),Qt.point(632,111),Qt.point(677,120),Qt.point(800,182),Qt.point(911,219),Qt.point(948,226),Qt.point(881,251),Qt.point(949,259),Qt.point(916,291),Qt.point(966,304),Qt.point(970,322),Qt.point(991,334)]

    //肾体前
    property variant rshentiqian: [Qt.point(621,322),Qt.point(741,322),Qt.point(855,322),Qt.point(873,311),Qt.point(952,313),Qt.point(968,326)]
    property variant lshentiqian: [Qt.point(621,349),Qt.point(741,349),Qt.point(855,349),Qt.point(874,363),Qt.point(953,360),Qt.point(968,345)]
    //肾体后
    property variant rshentihou: [Qt.point(123,409),Qt.point(154,417),Qt.point(169,440),Qt.point(208,433),
                                  Qt.point(279,435),Qt.point(338,430),Qt.point(381,422),Qt.point(543,363),Qt.point(595,335)]
    property variant lshentihou: [Qt.point(112,299),Qt.point(143,289),Qt.point(155,272),Qt.point(200,266),
                                  Qt.point(267,260),Qt.point(326,253),Qt.point(374,264),Qt.point(543,304),Qt.point(595,335)]
    //胃
    property variant rwei: [Qt.point(984,328),Qt.point(984,317),Qt.point(901,266),Qt.point(876,294),Qt.point(739,300),
                            Qt.point(705,300),Qt.point(680,279),Qt.point(652,264),Qt.point(574,258),Qt.point(434,253),
                            Qt.point(406,258),Qt.point(370,253),Qt.point(220,272),Qt.point(122,303),Qt.point(118,296),Qt.point(214,267)]
    property variant lwei: [Qt.point(984,342),Qt.point(984,353),Qt.point(905,405),Qt.point(876,379),Qt.point(739,372),
                            Qt.point(705,372),Qt.point(679,393),Qt.point(652,405),Qt.point(574,416),Qt.point(434,420),
                            Qt.point(406,415),Qt.point(372,423),Qt.point(220,410),Qt.point(122,394),Qt.point(122,401),Qt.point(214,415)]

   //肺
    property variant rfei: [Qt.point(944,270),Qt.point(984,266),Qt.point(978,213),Qt.point(887,183),
                            Qt.point(805,151),Qt.point(683,104),Qt.point(669,78),Qt.point(652,56)]
    property variant lfei: [Qt.point(943,402),Qt.point(982,401),Qt.point(974,454),Qt.point(876,487),
                            Qt.point(792,514),Qt.point(669,551),Qt.point(649,574),Qt.point(624,591)]

    //心包
    property variant rxinbao: [Qt.point(892,260),Qt.point(930,216),Qt.point(882,198),Qt.point(804,168),
                              Qt.point(676,113),Qt.point(643,91),Qt.point(589,73),Qt.point(625.94),Qt.point(589,91)]
    property variant lxinbao: [Qt.point(894,414),Qt.point(930,447),Qt.point(868,472),Qt.point(797,498),
                                Qt.point(669,542),Qt.point(631,561),Qt.point(572,567),Qt.point(612,554),Qt.point(573,554)]
    // 膀胱1
    property variant lpangguang1: [Qt.point(520,161.5),Qt.point(501.5,170),Qt.point(488,162.5),Qt.point(315.5,160.5),Qt.point(322.5,166),Qt.point(308,166),Qt.point(282,152.5),Qt.point(188.5,124.5),Qt.point(187.5,133)]
    property variant rpangguang1: [Qt.point(520,178.5),Qt.point(501.5,170),Qt.point(488.5,177.5),Qt.point(315.5,181),Qt.point(322.5,175),Qt.point(308,174.5),Qt.point(282,187.5),Qt.point(189,217),Qt.point(188,208)]

    // 膀胱2
    property variant lpangguang2: [Qt.point(520,161.5),Qt.point(503,156),Qt.point(486.5,143.5),Qt.point(376,144),Qt.point(348,125.5),Qt.point(281,125),Qt.point(127,138),Qt.point(75,145.5),Qt.point(52.5,109.5)]
    property variant rpangguang2: [Qt.point(520,178.5),Qt.point(503.5,184),Qt.point(487,195),Qt.point(377,195),Qt.point(348,210),Qt.point(281,215.5),Qt.point(124,201.5),Qt.point(74.5,196),Qt.point(51.5,232)]


    // 脾2
    property variant lpi2: [Qt.point(640, 339),Qt.point(728, 339),Qt.point(748, 350),Qt.point(802, 338),Qt.point(802, 353)]
    property variant rpi2: [Qt.point(640, 331),Qt.point(728, 331),Qt.point(748, 320),Qt.point(802, 331),Qt.point(802, 316)]

    // 脾1
    property variant lpi1: [Qt.point(159, 228),Qt.point(169, 243),Qt.point(219, 270),Qt.point(266, 286),Qt.point(333, 269),Qt.point(405, 258),Qt.point(162, 232),Qt.point(503, 256),Qt.point(626, 250),Qt.point(832, 347),Qt.point(862, 355),Qt.point(928, 344),Qt.point(867, 372)]
    property variant rpi1: [Qt.point(1130, 227),Qt.point(1120, 242),Qt.point(1070, 269),Qt.point(1023, 285),Qt.point(956, 268),Qt.point(884, 257),Qt.point(832, 252),Qt.point(786, 255),Qt.point(663, 249),Qt.point(249, 346),Qt.point(427, 354),Qt.point(354, 343),Qt.point(422, 371)]

    //手少阴心
    property variant lxin: [Qt.point(889,398),Qt.point(918,442),Qt.point(983,537),Qt.point(1103,453),Qt.point(1130,446),Qt.point(1192,443)]
    property variant rxin: [Qt.point(399,400),Qt.point(370,444),Qt.point(305,539),Qt.point(185,455),Qt.point(158,448),Qt.point(96,445)]

    property variant lgan: [Qt.point(128,392),Qt.point(201,376),Qt.point(270,287),Qt.point(378,278),Qt.point(382,262),Qt.point(405,257),
                            Qt.point(417,272),Qt.point(467,264),Qt.point(511,267),Qt.point(561,269),Qt.point(549,283),Qt.point(617,285),
                            Qt.point(618,300),Qt.point(619,315),Qt.point(687,312),Qt.point(708,334),Qt.point(731,369),Qt.point(769,344),Qt.point(808,342)]
    property variant rgan: [Qt.point(1162,392),Qt.point(1089,376),Qt.point(1020,287),Qt.point(912,278),Qt.point(908,262),Qt.point(885,257),
                            Qt.point(873,272),Qt.point(823,264),Qt.point(779,267),Qt.point(741,283),Qt.point(488,260),Qt.point(673,285),
                            Qt.point(672,300),Qt.point(671,315),Qt.point(603,312),Qt.point(582,334),Qt.point(559,369),Qt.point(521,344),Qt.point(482,342)]

    property variant allpoints: {"rdan":rdan,"ldan":ldan,"rsanjiao":rsanjiao,"lsanjiao":lsanjiao,
                                "rdachang":rdachang,"ldachang":ldachang,"rxiaochang":rxiaochang,"lxiaochang":lxiaochang,
                                "rshentiqian":rshentiqian,"lshentiqian":lshentiqian,"rshentihou":rshentihou,"lshentihou":lshentihou,
                                "rwei":rwei,"lwei":lwei,"rfei":rfei,"lfei":lfei,"rxinbao":rxinbao,"lxinbao":lxinbao,
                                "lpangguang1":lpangguang1,"rpangguang1":rpangguang1,"lpangguang2":lpangguang2,"rpangguang2":rpangguang2,
                                "lpi2":lpi2,"rpi2":rpi2,"lpi1":lpi1,"rpi1":rpi1,
                                "lxin":lxin,"rxin":rxin,"lgan":lgan,"rgan":rgan}
    property variant jingluo0: ["L-shen-1:1110,384"]
    property int startX: 0
    property int startY: 0
    property int endX: 0
    property int endY: 0

    property int startX1: 0
    property int startY1: 0
    property int endX1: 0
    property int endY1: 0

    property int drawWidth: 1310
    property int drawHeight: 655

    property int drawStyle: -1 //1 直线 2 圆
    property string last_point: ""

    Rectangle {
            id:patientscroll
            y:cellSpace
            width:patienttreatani.width-cellSpace
            height: patienttreatani.height-cellSpace-topcellOffset
            x:leftcellOffset+cellSpace
            color: "transparent"
            Image {
                id: backimage
                source: imgaeshprefix+"bgimage/"+anibackimg1
                width: drawWidth
                height: drawHeight
                x:0//(patientscroll.width-drawWidth)/2.0
                y:0//(patientscroll.height-drawHeight)/2.0
            }
            Canvas{
                id:mycanvas
                anchors.fill: parent
                antialiasing: false
                onPaint: {
                    var ctx=getContext('2d')
                    ctx.fillStyle = Qt.rgba(1, 1, 0, 0);
                    ctx.fillRect(backimage.x, backimage.y, backimage.width, backimage.height);
                    ctx.strokeStyle="green"
                    ctx.lineWidth=4
                    ctx.beginPath()
                    if (drawStyle==1){
                        ctx.moveTo(startX+backimage.x,startY+backimage.y+2);
                        ctx.lineTo(endX+backimage.x,endY+backimage.y+2);
                        if (anicount===1){
                            ctx.moveTo(startX1+backimage.x,startY1+backimage.y+2);
                            ctx.lineTo(endX1+backimage.x,endY1+backimage.y+2);
                        }
                    }else{

                        ctx.arc(startX+backimage.x,startY+backimage.y,10,Math.PI*2)
                        if (anicount===1){
                            ctx.arc(startX1+backimage.x,startY1+backimage.y,10,Math.PI*2)
                        }
                    }
                    ctx.stroke();
                    ctx.closePath()
                }
            }
        }

    Rectangle {
            id:patientscroll1
            y:cellSpace
            width:(patienttreatani.width-cellSpace)/4
            height: (patienttreatani.height-cellSpace-topcellOffset)/4
            x:leftcellOffset+cellSpace
            color: "green"
            visible: anicount===2|| anicount===3
            Image {
                id: backimage1
                source: imgaeshprefix+"bgimage/" +anibackimg2
                width: drawWidth/4
                height: drawHeight/4
                fillMode: Image.PreserveAspectFit
                x:(patientscroll1.width-backimage1.width)/2.0
                y:(patientscroll1.height-backimage1.height)/2.0
            }
            Canvas{
                id:mycanvas1
                anchors.fill: parent
                antialiasing: false
                onPaint: {
                    var ctx=getContext('2d')
                    ctx.fillStyle = Qt.rgba(1, 1, 0, 0);
                    ctx.fillRect(backimage1.x, backimage1.y, backimage1.width, backimage1.height);
                    ctx.strokeStyle="red"
                    ctx.lineWidth=4
                    ctx.beginPath()
                    if (drawStyle==1){
                        ctx.moveTo(startX1+backimage1.x,startY1+backimage1.y);
                        ctx.lineTo(endX1+backimage1.x,endY1+backimage1.y);
                    }else{

                        ctx.arc(startX1+backimage1.x,startY1+backimage1.y,10,Math.PI*2)
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
                    if (last_point===ss){
                        return
                    }

                  //
                    var subs=ss.substr(1,ss.length-2)
                   // console.log("routine "+obj.point_right)
                    console.log("routine1 "+subs )
                    var obj = JSON.parse(subs);

                    console.log("routine aaaaa"+obj.point_right);
                    var lefts=obj.point_left.split("-");
                    var rights=obj.point_right.split("-")

                    console.log("routine aaaaa"+obj.point_right+"count="+rights.length);
                    var count=rights.length;
                    if (count===3)
                    {
                        console.log("right pic_name" +backimage.source)
                       // console.log("left image name="+backimage1.source)
                        currentIndex++
                        var indexpoint=rights[2]
                        var points=rights[0].toLowerCase()+rights[1]; //获取图片数组名 右侧图片
                        var points_left=lefts[0].toLowerCase()+lefts[1] //获取图片数组名  左侧图片

                        if (indexpoint<14 && rights[1]==="shen") {
                           points=rights[0].toLowerCase()+rights[1]+"tihou"
                             points_left=lefts[0].toLowerCase()+lefts[1]+"tihou" //获取图片数组名  左侧图片
                        }
                        if (indexpoint>=14 && rights[1]==="shen") {
                           points=rights[0].toLowerCase()+rights[1]+"tiqian"
                            points_left=lefts[0].toLowerCase()+lefts[1]+"tiqian" //获取图片数组名  左侧图片
                        }

                        if (currentIndex<allpoints[points].length){
                            if (currentIndex>=1){
                                console.log("x="+allpoints[points][(currentIndex-1)%allpoints[points].length].x )
                                startX=allpoints[points][(currentIndex-1)%allpoints[points].length].x;
                                startY=allpoints[points][(currentIndex-1)%allpoints[points].length].y;
                                endX=allpoints[points][currentIndex%allpoints[points].length].x;
                                endY=allpoints[points][currentIndex%allpoints[points].length].y;
                                drawStyle=1

                                if (anicount===1){ //左边点，右边点在同一张图上
                                    startX1=allpoints[points_left][(currentIndex-1)%allpoints[points_left].length].x;
                                    startY1=allpoints[points_left][(currentIndex-1)%allpoints[points_left].length].y;
                                    endX1=allpoints[points_left][currentIndex%allpoints[points_left].length].x;
                                    endY1=allpoints[points_left][currentIndex%allpoints[points_left].length].y;
                                    mycanvas.requestPaint()
                                }

                                if (anicount===2){//左边点/右边点在两张图上

                                    mycanvas.requestPaint()
                                    startX1=allpoints[points_left][(currentIndex-1)%allpoints[points_left].length].x/4;
                                    startY1=allpoints[points_left][(currentIndex-1)%allpoints[points_left].length].y/4;
                                    endX1=allpoints[points_left][currentIndex%allpoints[points_left].length].x/4;
                                    endY1=allpoints[points_left][currentIndex%allpoints[points_left].length].y/4;
                                    mycanvas1.requestPaint()
                                }




                            }else if (currentIndex==0){

                               startX=allpoints[points][currentIndex%allpoints[points].length];
                                startY=allpoints[points][currentIndex%allpoints[points].length];

                                startX1=allpoints[points_left][currentIndex%allpoints[points_left].length];
                                 startY1=allpoints[points_left][currentIndex%allpoints[points_left].length];
                                drawStyle=2
                                mycanvas.requestPaint()
                                if (anicount===2){
                                    mycanvas1.requestPaint()
                                }

                            }


                        }
                    }



                    console.log("routine "+BAT.stringify(message));
                }
            }


}
