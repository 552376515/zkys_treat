import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import zmq.Components 1.0
Item {
    id:testrightcontrol
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property bool canstartTiaoli: false
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
            model: ["仰卧手向上", "仰卧手向下"]
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
            model: ["足少阴肾经(体前)", "足少阴肾经(体后)","手厥阴心包经","手少阳三焦经","足少阳胆经","足厥阴肝经","手太阴肺经","手阳明大肠经","足阳明胃经","足太阴脾经","手少阴心经","手太阳小肠经","足太阳膀胱经"]
            width: 200
            height: 30
            x:(whitedisp.width-cuscombox1.width)/2.0
            anchors.top: currentjinluo.bottom
            anchors.topMargin: 5
            displayText: qsTr(currentText)
        }

    }

    CusButton_Image{
        id:sbibiejingluo
        width: 249
        height: 92
        anchors.top:  whitedisp.bottom
        anchors.topMargin: 20
        x:(testrightcontrol.width-sbibiejingluo.width)/2.0
        btnImgUrl:imgaeshprefix+"images/distinguish.png"
        btnImgHovered:imgaeshprefix+"images/distinguish-fz.png"
        onClicked:{
            //zantingshibiemess.visible=true
            canceltreatManage.visible=true
            //jingluoshibieshibai.visible=true
            //testmanageSuccess.visible=true
            senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\"2号姿势\"}}"));
        }
    }

    CusButton_Image{
        id:starttiaoli
        width: 249
        height: 92
        anchors.top:  sbibiejingluo.bottom
        anchors.topMargin: 22
        x:(testrightcontrol.width-sbibiejingluo.width)/2.0
        btnImgUrl:canstartTiaoli ?imgaeshprefix+"images/start.png":imgaeshprefix+"images/start-cs.png"
        onClicked:{
            if (canstartTiaoli){
                senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
            }
        }
    }

//    CusButton{
//        id: regButton
//        width:250
//        height:60
//        x:15
//        anchors.top: whitedisp.bottom
//        anchors.topMargin: 20
//        text:"识别经络"
//        backgroundColorNormal:"#f5f6f7"
//        backgroundColorPressed:"#f5b750"
//        selected:true
//        onClicked:{
//               senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"identify\",\"args\":{\"therapybox\":\"疗法一\",\"posturebox\":\"2号姿势\"}}"));
//        }

//    }
//    CusButton{
//        id: regButton1
//        x:15
//        width:250
//        height:60
//        anchors.top: regButton.bottom
//        anchors.topMargin: 20
//        text:"开始调理"
//        backgroundColorNormal:"#f5f6f7"
//        backgroundColorPressed:"#f5b750"
//        selected:false
//        onClicked:{
//            senderright.sendMessage(BAT.byteArrayfy("{\"msg\":\"start_cure\",\"args\":{\"meridianbox\":\"shen_tiqian_r\",\"meridianbox_2\":\"shen_tiqian_l\"}}"));
//            realpatient1.visible=true;
//            realpatient2.visible=false;
//        }


//    }
    ZMQSocket {
        id: senderright
        type: ZMQSocket.Req
        addresses: ["tcp://192.168.1.59:9555"]

        onMessageReceived: {
           var ss=BAT.stringify(message)[0];

          //  rightcontrolTimer.running=true;

            if (ss==="identify_success"){
                 toReconize();
                console.log("in equal")
              //  realpatient.visible=false
               // realpatient2.visible=true;
             //  rightcontrolTimer.stop()
            }
            if (ss==="start_cure_success"){

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
             senderright.connectSocket();
        }else{
            //senderright.close();
        }
    }
}
