import QtQuick 2.0
import QtQuick.Controls 2.2
import TaoQuick 1.0
import zmq.Components 1.0
import QtMultimedia 5.12
Item {
    id:testrightcontrol
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property bool canstartTiaoli: false
    property bool startrecognize: false
    property string soundname: ""
    property string posturebox: ""
    property string musicname: ""
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
        id:testrightmess
        width: testrightcontrol.width
        height: 60
        color: "#B9F3F9"
        Text {
            id: ptestrightmessname
            text: qsTr("单经络调理")
            color: "#242424"
            width: testrightmess.width
            height: testrightmess.height
            font.pixelSize: 15
            font.bold: true  		//字体是否加粗，缺省为false
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
            horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
        }
    }
    Rectangle{
        id:whitedisp
        width: 250
        height: 480
        anchors.top: testrightmess.bottom
        anchors.topMargin: 20
        x:(testrightmess.width-whitedisp.width)/2.0
        y:20
        color: "white"
        Text{
            id:currentTiwei
            x:12
            y:20
            text: qsTr("当前体位：")
            font.pixelSize: 16
            color: "#000000"
        }

        CusComboBox{
            id:cuscombox
            model: ["仰卧手向上", "仰卧手向下","俯卧手向下","俯卧脚内八"]
            width: 200
            height: 30
            x:(whitedisp.width-cuscombox.width)/2.0
            anchors.top: currentTiwei.bottom
            anchors.topMargin: 5
            displayText: qsTr(currentText)
        }

        Text{
            id:currentjinluo
            x:12
            anchors.top: cuscombox.bottom
            anchors.topMargin: 40
            text: qsTr("当前经络：")
            font.pixelSize: 16
            color: "#000000"
        }
        CusComboBox{
            id:cuscombox1
            model: ["足少阴肾经(体前)", "足少阴肾经(体后)","手厥阴心包经","手少阳三焦经","足少阳胆经","足厥阴肝经","手太阴肺经","手阳明大肠经","足阳明胃经","足太阴脾经2","足太阴脾经2","手少阴心经","手太阳小肠经","足太阳膀胱经1","足太阳膀胱经2"]
            width: 200
            height: 30
            x:(whitedisp.width-cuscombox1.width)/2.0
            anchors.top: currentjinluo.bottom
            anchors.topMargin: 5
            displayText: qsTr(currentText)
        }

    }

    Button{
        id:sbibiejingluo
        width: 249
        height: 92
        anchors.top:  whitedisp.bottom
        anchors.topMargin: 20
        x:(testrightcontrol.width-sbibiejingluo.width)/2.0
        background:Rectangle{
            width: sbibiejingluo.width
            height: sbibiejingluo.height
            color: "transparent"
            Image {
                id: sbibiejingluoimg
                source: sbibiejingluo.hovered?imgaeshprefix+"images/distinguish-fz.png":imgaeshprefix+"images/distinguish.png"
            }
       }
        onClicked:{
                    if (cuscombox.displayText==="仰卧手向上"){
                        soundname="pose1.mp3"
                        posturebox="1号姿势"
                    }
                    if (cuscombox.displayText==="仰卧手向下"){
                        soundname="pose2.mp3"
                        posturebox="2号姿势"
                    }
                    if (cuscombox.displayText==="俯卧手向下"){
                        soundname="pose3.mp3"
                        posturebox="3号姿势"
                    }
                    if (cuscombox.displayText==="俯卧脚内八"){
                        soundname="pose4.mp3"
                        posturebox="4号姿势"
                    }
                    musicname=imgaeshprefix+"audios/"+soundname
                    playtesttiaolimusic.play();
                    startrecognize=false

                    var sendstr="{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\""+posturebox+"\"}}"
                    console.log("socket sendstr="+sendstr)
                    senderright.sendMessage(BAT.byteArrayfy(sendstr))

           // senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\"2号姿势\"}}"));
        }
    }

    Button{
        id:starttiaoli
        width: 249
        height: 92
        anchors.top:  sbibiejingluo.bottom
        anchors.topMargin: 22
        x:(testrightcontrol.width-sbibiejingluo.width)/2.0
        background:Rectangle{
            width: starttiaoli.width
            height: starttiaoli.height
            color: "transparent"
            Image{
                id:starttiaoliimg
                width: starttiaoli.width
                height: starttiaoli.height
                source: canstartTiaoli ?imgaeshprefix+"images/start.png":imgaeshprefix+"images/start-cs.png"
            }

        }

        onClicked:{
        //    if (canstartTiaoli){
                closeAllStatus()
                realtimeRoutine.visible=true
                currTreatState=3
                musicname=imgaeshprefix+"audios/start_care.mp3"
                playtesttiaolimusic.play();
                startrecognize=true
                tiaoliAction()
                //senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
          //  }
        }
    }




    function recognizeAction(){
        musicname=imgaeshprefix+"audios/start_iden.mp3"
        playtesttiaolimusic.play();

        if (!realtimeCorrect.visible){
            closeAllStatus()
            realtimeCorrect.visible=true
            currTreatState=1
        }
    }

    function toReconize(){
       // console.log("to recognize")
        closeAllStatus()
        realtimeRecognize.visible=true
        currTreatState=2
       // console.log("to recognize1")

    }

    function tiaoliAction(){

        var meridianbox=tianliformR[ cuscombox1.displayText]
        var meridianbox_2=tianliformL[cuscombox1.displayText]
        var pics=picnames[cuscombox1.displayText];
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

    }
    ZMQSocket {
        id: senderright
        type: ZMQSocket.Req
        addresses: ["tcp://192.168.1.59:9555"]

        onMessageReceived: {
           var ss=BAT.stringify(message)[0];

            if (ss==="identify_success"){
                 toReconize();
                canstartTiaoli=true
                console.log("in equal")

            }
            if (ss==="start_cure_success"){

            }

            console.log("right control onMessageReceived +"+message +" "+ss)
        }
    }

    Component.onCompleted: {
       // senderright.connectSocket();
       // theModel.append({"eachname":"天眼相机","eachimage":"qrc:/new/prefix1/Image/obama2.jpg", "price":"¥60"})
    }
    onVisibleChanged: {
        if (visible){
             senderright.connectSocket();
        }else{
            //senderright.close();
        }
    }

    //设置音频
       MediaPlayer {
           id: playtesttiaolimusic
           source: musicname
           onStatusChanged: {
               console.log("playstatus "+playbackState)

           }

           onStopped: {
               console.log("shibie jieshu")
                   if (!startrecognize){
                       recognizeAction()
                       startrecognize=true
                   }




           }
       }
}
