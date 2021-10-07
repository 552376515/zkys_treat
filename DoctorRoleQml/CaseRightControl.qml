import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import TaoQuick 1.0
import zmq.Components 1.0
import QtMultimedia 5.12
Item {
    id:rightcontrol
    width: parent
    height: parent
    anchors.fill: parent
    property bool startrecognize: false
    property bool isrecognizesuccess: false
    property bool starttiaoli: false
    property variant tianliformR: { "足少阴肾经(体前)":"shen_tiqian_r","手厥阴心包经":"xinbao_r","手少阳三焦经":"sanjiao_r","足少阳胆经":"dan_r","足厥阴肝经":"gan_r", "手太阴肺经":"fei_r", "手阳明大肠经":"dachang_r","足阳明胃经":"wei_r", "足太阴脾经1":"pi_r","足太阴脾经2":"pis2_r", "手少阴心经":"xin_r",  "手太阳小肠经":"xiaochang_r", "足太阳膀胱经1":"pangguangs1_r","足太阳膀胱经2":"pangguangs2_r", "足少阴肾经(体后)":"shen_tihou_r" }
    property variant tianliformL: { "足少阴肾经(体前)":"shen_tiqian_l","手厥阴心包经":"xinbao_l","手少阳三焦经":"sanjiao_l","足少阳胆经":"dan_l","足厥阴肝经":"gan_l", "手太阴肺经":"fei_l", "手阳明大肠经":"dachang_l","足阳明胃经":"wei_l", "足太阴脾经1":"pi_l","足太阴脾经2":"pis2_l", "手少阴心经":"xin_l",  "手太阳小肠经":"xiaochang_l", "足太阳膀胱经1":"pangguangs1_l","足太阳膀胱经2":"pangguangs2_l", "足少阴肾经(体后)":"shen_tihou_l" }

    property variant picnames:{ "足少阴肾经(体前)":"middle_026_shentiqian.png","手厥阴心包经":"middle_026_xinbao.png",
                                "手少阳三焦经":"middle_027_sanjiao.png","足少阳胆经":"right_26_dan.png,left_26_dan.png",
                                "足厥阴肝经":"right_25_gan.png,left_25_gan.png", "手太阴肺经":"middle_026_fei.png",
                                "手阳明大肠经":"middle_027_dachang","足阳明胃经":"middle_026_wei.png",
                                "足太阴脾经1":"right_25_pi.png,left_25_pi.png","足太阴脾经2":"middle_025_pi.png", "手少阴心经":"right_25_xin.png,left_25_xin.png",
                                "手太阳小肠经":"middle_027_xiaochang.png", "足太阳膀胱经1":"middle_027_pangguang.png","足太阳膀胱经2":"middle_027_pangguang.png",
                                "足少阴肾经(体后)":"middle_028_shentihou.png" }
    Rectangle{
        id:patientmess
        width: 300
        height: 60
        color: "#c4f1f8"
        Text {
            id: patienttreatname
            text: qsTr("患者：001 张小 36岁")
            color: "#333333"
            width: patientmess.width
            height: patientmess.height
            font.pixelSize: 15
            font.bold: true  		//字体是否加粗，缺省为false
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
            horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
        }
    }
    Rectangle{
        id:whitedisp
        width: 250
        height: 350
        anchors.top: patientmess.bottom
        anchors.topMargin: 20
        x:(patientmess.width-whitedisp.width)/2.0
        color: "white"
        ListView{
            id: listView
            clip: true
            width: parent.width-1;
            height: parent.height;
            spacing :0
//            highlight: Rectangle {
//            width: listView.width
//            height: 50
//            color: "transparent"
//            radius: 5
//                Behavior on y {
//                    SpringAnimation {
//                       spring: 3
//                       damping: 0.2
//                    }
//                }
//            }
            highlightFollowsCurrentItem: true
            focus: true
            delegate: Rectangle {
                      id:listviewcell
                     property color tempcolor: "transparent"
                     color: tempcolor
                     width: listView.width
                     height: 60
                     Rectangle{
                         id:listLeftLine
                         x:14
                         y:index===0?listviewcell.height/2.0:0
                         width: 8
                         height: index===0 || jingluoplanStep.rowCount()-1==index? listviewcell.height/2.0: listviewcell.height
                         color: "#ededed"
                     }

                     Rectangle{
                         id:rightText
                         width: zishi.contentWidth+iconimg.width+10
                         height: 20
                         color: zishiname===""?"transparent":"#5e5e5e"
                         anchors.left: listLeftLine.right
                         anchors.leftMargin: 10
                         Text {
                             id: zishi
                             text: zishiname
                             color: "white"
                             font.pixelSize: 14

                         }
                         Image {
                             id: iconimg
                             anchors.left: zishi.right
                             anchors.leftMargin: 10
                             source: imgaeshprefix+"images/ys-laba.png"
                             visible: zishiname===""?false:true
                         }

                     }


                     Row {
                            id: row1
                            anchors.fill: parent
                            spacing: 10
                            anchors.top: rightText.bottom
                            anchors.leftMargin: 10
                            height: 40

                            Rectangle {
                                x:listView.currentIndex === index ?0:4
                                width: listView.currentIndex === index ?18:10
                                height: listView.currentIndex === index ?18:10
                                color: listView.currentIndex === index ?"#e48839":"#999999"
                                radius: width/2;
                               anchors.verticalCenter: row1.verticalCenter

                            }
                            //228 136 57 e48839
                            Text {
                                text: name
                                height: row1.height
                                verticalAlignment: Text.AlignVCenter

                                font.bold: true
                                font.pointSize: listView.currentIndex === index ? 18 : 14
                                color: listView.currentIndex === index?"#e48839":"#999999"
                            }
                        }


                     MouseArea{
                         anchors.fill: parent
                         hoverEnabled: true
                         onClicked: {
                             listView.currentIndex = index;
                         }
                         onEntered: {
                             tempcolor = "#a7e094"
                         }

                         onExited: {
                             tempcolor = "transparent"
                         }
                     }
                 }
                        model:
                            ListModel{
                            id:jingluoplanStep
                            ListElement {
                                                name: "综合方舱门"
                                                colorCode: "green"
                                                zishiname:""
                                                soundname:""
                                                posturebox:""
                                            }

                        }


        }
    }

    function closeAllTiaoli(){
        realtimeCorrect.visible=false;
        realtimeRecognize.visible=false;
        realtimeRoutine.visible=false;
    }


    function recognizeAction(){
        musicname=imgaeshprefix+"audios/start_iden.mp3"
        playtiaolimusic.play();
        var currmodel=jingluoplanStep.get(listView.currentIndex)
        var posture=currmodel.posturebox
        var soundname=currmodel.soundname
        console.log("regstart posture="+posture)
        if (posture!==""){ //有体位信息 发送socket 信息 先放音-》发送socket
            var sendstr="{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\""+posture+"\"}}"
            console.log("socket sendstr="+sendstr)
            senderright.sendMessage(BAT.byteArrayfy(sendstr))

        }
        if (!realtimeCorrect.visible){
            closeAllTiaoli()
            realtimeCorrect.visible=true
        }
    }

    function recognizeActionPlay(){//开始识别 跳到实时画面

        var currmodel=jingluoplanStep.get(listView.currentIndex)
        var posture=currmodel.posturebox
        var soundname=currmodel.soundname
        console.log("regstart posture="+posture)
        if (posture!==""){ //有体位信息 发送socket 信息 先放音-》发送socket
            musicname=imgaeshprefix+"audios/"+soundname
            playtiaolimusic.play();
        }

//       senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\"2号姿势\"}}"));
    }

    function tiaoliAction(){
        var currmodel=jingluoplanStep.get(listView.currentIndex)
        var posture=currmodel.posturebox
        var meridianbox=tianliformR[ currmodel.name]
        var meridianbox_2=tianliformL[currmodel.name]
        var pics=picnames[currmodel.name];
        var picsArr=pics.split(",")
        anibackimg1=picsArr[0];
        if (picsArr.length===2){
            anibackimg2=picsArr[1]
        }
        if (picsArr.length===3){
            anibackimg2=picsArr[1];
            anibackimg3=picsArr[2];
        }
        anicount=picsArr.length

            var rightbox="{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\""+meridianbox+"\",\"meridianbox_2\":\""+meridianbox_2+"\"}}"
            senderright.sendMessage(BAT.byteArrayfy(rightbox))
        listView.currentIndex++

       //  senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));

    }

    function tiaoliActionNext(){
        var currmodel=jingluoplanStep.get(listView.currentIndex)
        var posture=currmodel.posturebox
        var meridianbox=tianliformR[ currmodel.name]
        var meridianbox_2=tianliformL[currmodel.name]
        if (listView.currentIndex<listView.count){
            if (posture===""){
                var rightbox="{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\""+meridianbox+"\",\"meridianbox_2\":\""+meridianbox_2+"\"}}"
                senderright.sendMessage(BAT.byteArrayfy(rightbox))
                listView.currentIndex++
            }else{//识别放音
                recognizeAction()
            }
        }


    }


    CusButton{
        id: regButton
        width:250
        height:60
        x:15
        anchors.top: whitedisp.bottom
        anchors.topMargin: 20
        text:"识别经络"
        backgroundColorNormal:"#f5f6f7"
        backgroundColorPressed:"#f5b750"

        selected:true
        onClicked:{//开始识别 先要播放声音 ，声音播放完成，再去识别体位
            recognizeActionPlay()
            startrecognize=false
            starttiaoli=false
            closeAllStatus()
            realtimeCorrect.visible=true
            currTreatState==1
        }

    }
    CusButton{
        id: regButton1
        x:15
        width:250
        height:60
        anchors.top: regButton.bottom
        anchors.topMargin: 20
        text:starttiaoli?"停止调理":"开始调理"
        backgroundColorNormal:(isrecognizesuccess)?"#f5b750":"#ededed"
        backgroundColorPressed:"#f5b750"
        selected:false
        onClicked:{
        //    if (isrecognizesuccess){
                tiaoliAction()
                 musicname=imgaeshprefix+"audios/start_care.mp3"
                playtiaolimusic.play();
                closeAllTiaoli()
                realtimeRoutine.visible=true
                currTreatState=3;
            starttiaoli=true
          //  }


        }


    }
    ZMQSocket {
        id: senderright
        type: ZMQSocket.Req
        addresses: ["tcp://192.168.1.59:9555"]

        onMessageReceived: {
           var ss=BAT.stringify(message)[0];



            if (ss==="identify_success"){ //识别成功 到识别成功画面
                //rightcontrolTimer.running=true;
                 toReconize();
                console.log("in equal")
                if(starttiaoli){ //识别成功，如果在调理，发送调理信息
                    var currmodel=jingluoplanStep.get(listView.currentIndex)
                    var posture=currmodel.posturebox
                    var meridianbox=tianliformR[ currmodel.name]
                    var meridianbox_2=tianliformL[currmodel.name]
                    var rightbox="{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\""+meridianbox+"\",\"meridianbox_2\":\""+meridianbox_2+"\"}}"
                    senderright.sendMessage(BAT.byteArrayfy(rightbox))
                    listView.currentIndex++
                }
            }
            if (ss==="start_cure_success"){//调理信息获得成功，进入调理页面
                closeAllTiaoli()
                    realtimeRoutine.visible=true
                currTreatState=3;
            }

            if (ss==="end_cure_success"){
                  //  tiaoliActionNext()
            }

            console.log("right control onMessageReceived +"+message +" "+ss)
        }
    }

    Timer {
        id: rightcontrolTimer
        interval: 4
        running: false
        repeat: false
        onTriggered: {
            console.log("right control timer")
            toReconize();
           rightcontrolTimer.stop()
        }
    }
    Component.onCompleted: {
       // senderright.connectSocket();
       // theModel.append({"eachname":"天眼相机","eachimage":"qrc:/new/prefix1/Image/obama2.jpg", "price":"¥60"})
    }
    onVisibleChanged: {
        if (visible){
               jingluoplanStep.clear();
            var tiwei="";
            for (var i=0;i<jingluoplannewModel.rowCount();i++){
                var datatmp=jingluoplannewModel.data(i);
                var jingluoname=datatmp[jingluoplannewModel.headerRoles[1]]
                var tiweiname=datatmp[jingluoplannewModel.headerRoles[0]]
                if (tiweiname!==tiwei){
                    console.log("jingluonewmodel tiweiname="+tiweiname)
                    var soundname="";
                    var posturebox=""
                    if (tiweiname==="仰卧手向上"){
                        soundname="pose1.mp3"
                        posturebox="1号姿势"
                    }
                    if (tiweiname==="仰卧手向下"){
                        soundname="pose2.mp3"
                        posturebox="2号姿势"
                    }
                    if (tiweiname==="俯卧手向下"){
                        soundname="pose3.mp3"
                        posturebox="3号姿势"
                    }
                    if (tiweiname==="俯卧脚内八"){
                        soundname="pose4.mp3"
                        posturebox="4号姿势"
                    }
                    tiwei=tiweiname
                    jingluoplanStep.append({"name":jingluoname,"colorCode":"green","soundname":soundname,"zishiname":tiweiname,"posturebox":posturebox})
                }else{
                    jingluoplanStep.append({"name":jingluoname,"colorCode":"green","soundname":"","zishiname":"","posturebox":""})
                }


            }

             senderright.connectSocket();
        }else{
            //senderright.close();
        }
    }

    //设置音频
       MediaPlayer {
           id: playtiaolimusic
           source: musicname
           onStatusChanged: {
               console.log("playstatus "+playbackState)

           }

           onStopped: {
               console.log("shibie jieshu")
               if (!startrecognize){
                   console.log("shibie jieshu1")
                   recognizeAction()
                   startrecognize=true
               }

           }
       }

}
