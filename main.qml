import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import TaoQuick 1.0
import QtMultimedia 5.12
import "DeviceManagerQml"
import "TreatManager"
//import zmq.Components 1.0
Window {
    id: window
    visible: true
    width: Screen.desktopAvailableWidth
    height:Screen.desktopAvailableHeight
    minimumHeight: 900
    minimumWidth: 1600
    maximumHeight: 1080
    maximumWidth: 1920
    title: qsTr("中科尚易系统"+window.width+"  "+window.height)
    color: "#ffffff"

    property int loginrole: -1 //0:普通医生 2:系统管理员
    property string imgaeshprefix:"file:///./Resource/"

    property string doctorloginname: "wang111"
    property int showIndex: 0
    property var musicArr: ["start_iden.mp3","start_care.mp3","relax_hand.mp3","relax_foot.mp3","pose1.mp3","pose2.mp3","pose3.mp3","pose4.mp3","keep_pose.mp3","bgm_gaoshanliushui.mp3"]
    property double screenWidth: 1600
    property double screenHeight: 900
    property string currpatientname: ""
    property string currpatientnum: ""
    property string currpatientSex: ""
    property string currpatientAge: ""
    property string currpatientPhone: ""
    property string currpatientRegtime: ""
    property string currglcasename: "痛风"
    property string currpatientcasename: "痛风"
    property string currgltreatmentname: "经络疗法1"
    Component.onCompleted: {
        if (typeof (mainImageResoucePath) != "undefined" && mainImageResoucePath !== null && mainImageResoucePath.length > 0) {
            imgaeshprefix = mainImageResoucePath
        }
    }

    function loadPatient(){
        loginrole=0
        deviceAddModel.initData()
        patientCaseModel.initCaseData()
        //showIndex=4;
        //realpatient2.visible=true;
       // playMusic.play()
        console.log("screen width="+Screen.desktopAvailableWidth +" height="+Screen.desktopAvailableHeight)

    }
    Rectangle{
        id:zhongkeheader
        width: window.width
        height: 75
       color: "#52bad6"
       visible: loginrole==0||loginrole==2
       Image{
           id:zhongketop
           source:imgaeshprefix+"images/top-bj.png"
           width: zhongkeheader.width
           height: zhongkeheader.height
       }



    CusButton {
        id: sub1
        text: "患者管理"
        //anchors.topMargin: 26
        //anchors.left: container.left
        visible:loginrole==0||loginrole==2
        x:32
        y:26
        height: zhongkeheader.height-sub1.y
        width: 122
        backgroundColorNormal:"transparent"
        backgroundColorPressed:"#ededed"
        selected:showIndex==1
        onClicked: {

        }
    }

    CusButton {
        id:sub2
        text: (loginrole==0)?"调理功能":"用户管理"
       // anchors.topMargin: 20
        anchors.left: sub1.right
        anchors.leftMargin: 20
        y:26
        height: zhongkeheader.height-sub2.y
        width: 122
        visible:loginrole==0 ||loginrole==2
        backgroundColorNormal:"transparent"
        backgroundColorPressed:"#ededed"
        selected:showIndex==2
        onClicked: {

        }
    }

    CusButton {
        id:sub3
        text: "设备管理"
       // anchors.topMargin: 20
        anchors.left: sub2.right
        anchors.leftMargin: 20
        y:26
        height: zhongkeheader.height-sub2.y
        width: 122
        visible:(loginrole==0||loginrole==2)
        backgroundColorNormal:"transparent"
        backgroundColorPressed:"#ededed"
        selected:showIndex==3
        onClicked: {
            showIndex=3
            deviceManagernew.visible=true
            realpatient.visible=false
            realpatient1.visible=false
            realpatient2.visible=false
        }
    }

    CusButton{
        id:sub4
        text: "处方管理"
       // anchors.topMargin: 20
        anchors.left: sub3.right
        anchors.leftMargin: 20
        y:26
        height: zhongkeheader.height-sub2.y
        width: 122
        visible:(loginrole==2)
        backgroundColorNormal:"transparent"
        backgroundColorPressed:"#ededed"
        selected:showIndex==4
        onClicked: {
            showIndex=4;
            treatmanagerment.visible=true;
            treatcaseModel.initTreatData();
        }
    }

    Image {
        id: doctorImg
        source: imgaeshprefix+"images/touxiang.png"
        anchors.left: sub2.right
        anchors.leftMargin: 890
        y:22
        width: 36
        height: 36
    }
    Text {
        id: doctorName
        anchors.left: doctorImg.right
        anchors.leftMargin: 5
        text: qsTr("医生:")+qsTr(doctorloginname)
        y:30
        font.pointSize: 15
        color: "#181818"
        width: 160
        height: 15
    }
    Image {
        id: exitimg
        source: imgaeshprefix+"images/signout.png"
        anchors.left: doctorName.right
        anchors.leftMargin: 10
        y:30
        width: 20
        height: 18
    }
    CusButton{
        id:exitBtn
        text:qsTr("退出登录")
        anchors.left:exitimg.right
        anchors.leftMargin:5
        backgroundColorNormal:"transparent"
        width:80
        y:30
        font.pointSize:15

        //color:"#181818"
        height:20
        onClicked:{
            showIndex=0
            login.visible=true
            realpatient.visible=false
            realpatient1.visible=false
            realpatient2.visible=false
           // deviceAddModel.initData()
        }
    }
    }
    Rectangle{
        id:loginRect
      //  x: ( Screen.desktopAvailableWidth-screenWidth)/2.0
      //  y: (Screen.desktopAvailableHeight-screenHeight)/2.0
        width: window.width
        height: window.height
        visible: showIndex==0
        PatientLogin{
            id:login

            width:loginRect.width
            height:loginRect.height
            visible:showIndex==0
    //        gradient: Gradient{
    //            GradientStop {position:0.0; color: "white"}
    //             GradientStop {position:1.0; color: "LightSalmon"}
    //        }
        }

    }
    Rectangle{
        x: ( Screen.desktopAvailableWidth-screenWidth)/2.0
        y: (Screen.desktopAvailableHeight-screenHeight)/2.0
        id:patientManagerRect
        visible: showIndex==1
        PatientTableView{
            id:patientManager
            width: screenWidth
            height: screenHeight
            visible: showIndex==1
        }
    }




    Rectangle{
        id:addnewpt

        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        AddNewPatient{
            width: addnewpt.width
            height: addnewpt.height
        }
    }

    Rectangle{
        id:realpatient
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: false
        PatientTreatCorrect{
            width: realpatient.width
            height: realpatient.height
        }
    }

    Rectangle{
        id:realpatient1
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: false
        PatientTreatRoutine{
            width: realpatient1.width
            height: realpatient1.height
        }
    }

    Rectangle{
        id:realpatient2
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: false
        PatientTreatRecognize{
            width: realpatient2.width
            height: realpatient2.height
        }
    }

    Rectangle{
        id:deviceManagernew
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: false
        DeviceManager{
            width: deviceManagernew.width
            height: deviceManagernew.height
        }

    }
    Rectangle{
        id:treatmanagerment
        width: window.width
        height: window.height-zhongkeheader.height
        y:zhongkeheader.height
        visible: false
        color: "transparent"
        TreatManager{
            width: treatmanagerment.width
            height: treatmanagerment.height
        }

    }

    Rectangle{
        id:patientdatacheck

        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        CaseDataList{
            width: patientdatacheck.width
            height: patientdatacheck.height
        }
    }

    Rectangle{
        id:addCaseTreatMent
//        x: (window.width-screenWidth)/2.0
//        y: (window.height-screenHeight)/2.0
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        AddCaseTreatment{
            width: addCaseTreatMent.width
            height: addCaseTreatMent.height
        }
    }

    Rectangle{
        id:choiseCaseTreatMent
        width: window.width
        height: window.height

        visible: false
        color: "transparent"
        ChoiseCaseTreatment{
            width: choiseCaseTreatMent.width
            height: choiseCaseTreatMent.height
        }
    }
    Rectangle{
        id:addTreatManager
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        AddTreatManagerCase{
            width: addTreatManager.width
            height: addTreatManager.height
        }
    }

    Rectangle{
        id:treatmanagerCheck
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        TreatManagerCheck{
            width: addTreatManager.width
            height: addTreatManager.height
        }
    }


    //设置音频
       MediaPlayer {
           id: playMusic
           source: imgaeshprefix+"audios/bgm_gaoshanliushui.mp3"
       }

       function toReconize(){
           console.log("to recognize")
           realpatient.visible=false
           realpatient2.visible=true
           console.log("to recognize1")

       }

}
