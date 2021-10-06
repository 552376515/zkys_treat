import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import TaoQuick 1.0
import QtMultimedia 5.12
import "DeviceManagerQml"
import "TreatManager"
import "PatientManager"

import "UserManageQml"
import "TestManage"
import "DoctorRoleQml"
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
    property string imgaeshprefix:mainImageResoucePath//
    //"file:///./Resource/"

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

    property int anicount: 1
    property string anibackimg1: "right_26_dan.png"
    property string anibackimg2: "left_26_dan.png"
    property string anibackimg3: "left_26_dan.png"

    property bool ysCanModifyTreatment: false
//    Component.onCompleted: {
//        if (typeof (mainImageResoucePath) != "undefined" && mainImageResoucePath !== null && mainImageResoucePath.length > 0) {
//            imgaeshprefix = mainImageResoucePath
//        }
//    }
    property string glselecteddoctor: ""

    function loadPatient(){
        loginrole=0


        if (loginrole==2){

            glpatientModel.initData();

            glpatientmanager.visible=true
        }else{
            patientManagerRect.visible=true
            deviceAddModel.initData()
            if (deviceAddModel.rowCount()>0){
                var thefirstpatient=deviceAddModel.data(0);
                currpatientname=thefirstpatient[deviceAddModel.headerRoles[0]];
                currpatientnum=thefirstpatient[deviceAddModel.headerRoles[1]];
                currpatientSex=thefirstpatient[deviceAddModel.headerRoles[2]]
                currpatientAge=thefirstpatient[deviceAddModel.headerRoles[3]]
                currpatientPhone=thefirstpatient[deviceAddModel.headerRoles[4]]
                currpatientRegtime=thefirstpatient[deviceAddModel.headerRoles[5]]

                //patientCaseModel.initCaseData()
                patientCaseModel.loadCaseByPatientId(currpatientnum)
            }


        }

       // playMusic.play()
        console.log("screen width="+Screen.desktopAvailableWidth +" height="+Screen.desktopAvailableHeight)

    }

    function closeAllView(){
        if (loginrole==0){
            realpatient.visible=false
            patientManagerRect.visible=false
            paramDeviceset.visible=false

        }
        if (loginrole==2){
            gldoctormanager.visible=false
            treatmanagerment.visible=false
            deviceManagernew.visible=false
            glpatientmanager.visible=false
            paramDeviceset.visible=false
            testmanage.visible=false
        }

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
            closeAllView();
            showIndex=1
            if (loginrole==2){

                glpatientmanager.visible=true
            }
            if (loginrole==0){
                patientManagerRect.visible=true
            }

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

            closeAllView();
            showIndex=2
            if (loginrole==2){

                gldoctorModel.initCaseData();
                 gldoctormanager.visible=true;
            }
            if (loginrole==0){
                realpatient.visible=true
            }

        }
    }

    CusButton {
        id:sub3
        text:loginrole==0 ? "设备管理":"处方管理"
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
            closeAllView()
            showIndex=3
            if (loginrole==2){

                treatcaseModel.initTreatData();
                treatmanagerment.visible=true;
            }

            if (loginrole==0){
                paramDeviceset.visible=true;
            }


        }
    }

    CusButton{
        id:sub4
        text: "设备管理"
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

            closeAllView();
            showIndex=4;
            deviceManagernew.visible=true

        }
    }

    CusButton{
        id:sub5
        text: "参数设置"
       // anchors.topMargin: 20
        anchors.left: sub4.right
        anchors.leftMargin: 20
        y:26
        height: zhongkeheader.height-sub5.y
        width: 122
        visible:(loginrole==2)
        backgroundColorNormal:"transparent"
        backgroundColorPressed:"#ededed"
        selected:showIndex==5
        onClicked: {

            closeAllView();
            showIndex=5;
            paramDeviceset.visible=true;

        }
    }

    CusButton{
        id:sub6
        text: "调理测试"
       // anchors.topMargin: 20
        anchors.left: sub5.right
        anchors.leftMargin: 20
        y:26
        height: zhongkeheader.height-sub5.y
        width: 122
        visible:(loginrole==2)
        backgroundColorNormal:"transparent"
        backgroundColorPressed:"#ededed"
        selected:showIndex==6
        onClicked: {

            closeAllView();
            showIndex=6;
            testmanage.visible=true;

        }
    }


    Image {
        id: doctorImg
        source: imgaeshprefix+"images/touxiang.png"
        anchors.left: sub2.right
        anchors.leftMargin: 890

        width: 36
        height: 36
        anchors.verticalCenter: zhongkeheader.verticalCenter
    }
    Text {
        id: doctorName
        anchors.left: doctorImg.right
        anchors.leftMargin: 5
        text: qsTr("医生:")+qsTr(doctorloginname)
        //y:30
        font.pointSize: 15
        color: "#181818"
        width: 160
        height: 20
        anchors.verticalCenter: zhongkeheader.verticalCenter
    }
    Image {
        id: exitimg
        source: imgaeshprefix+"images/signout.png"
        anchors.left: doctorName.right
        anchors.leftMargin: 10
       // y:30
        width: 20
        height: 20
        anchors.verticalCenter: zhongkeheader.verticalCenter
    }
    CusButton{
        id:exitBtn
        text:qsTr("退出登录")
        anchors.left:exitimg.right
        anchors.leftMargin:5
        backgroundColorNormal:"transparent"
        width:80
        height:20
        anchors.verticalCenter: zhongkeheader.verticalCenter
        font.pointSize:15

        //color:"#181818"

        onClicked:{
            closeAllView()
            showIndex=0
            login.visible=true

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
        visible: showIndex==1 && loginrole==0
        PatientTableView{
            id:patientManager
            width: screenWidth
            height: screenHeight
            visible: showIndex==1
        }
    }





    Rectangle{//新增患者
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

    Rectangle{//医生角色 实时画面
        id:realpatient
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: false
        PatientTreatManager{
            width: realpatient.width
            height: realpatient.height
        }

//        PatientTreatCorrect{
//            width: realpatient.width
//            height: realpatient.height
//        }
    }


    Rectangle{//管理角色患者管理
        id:glpatientmanager
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: showIndex==1 && loginrole==2
        color: "#ededed"
        GLPatientManager{
            width: glpatientmanager.width
            height: glpatientmanager.height
        }

    }

    Rectangle{//管理角色 用户管理
        id:gldoctormanager
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: showIndex==2 && loginrole==2
        color: "#ededed"
        UserManager{
            width: gldoctormanager.width
            height: gldoctormanager.height
        }

    }


    Rectangle{//设备管理 医生和管理角色都有此功能
        id:deviceManagernew
        y:zhongkeheader.height
        width: window.width
        height: window.height-zhongkeheader.height
        visible: showIndex==4
        DeviceManager{
            width: deviceManagernew.width
            height: deviceManagernew.height
        }

    }
    Rectangle{//管理角色 处方管理
        id:treatmanagerment
        width: window.width
        height: window.height-zhongkeheader.height
        y:zhongkeheader.height
        visible: showIndex==3
        color: "#ededed"
        TreatManager{
            width: treatmanagerment.width
            height: treatmanagerment.height
        }

    }
    Rectangle{//管理角色 参数设置
        id:paramDeviceset
        width: window.width
        height: window.height-zhongkeheader.height
        y:zhongkeheader.height
        visible: (showIndex==5&& loginrole==2) ||(loginrole==0 && showIndex==3)
        color: "transparent"
        DeviceParamSet{
            width: treatmanagerment.width
            height: treatmanagerment.height
        }

    }

    Rectangle{//管理角色 调理测试
        id:testmanage
        width: window.width
        height: window.height-zhongkeheader.height
        y:zhongkeheader.height
        visible: showIndex==6
        color: "transparent"
        TestManage{
            width: testmanage.width
            height: testmanage.height
        }

    }


    Rectangle{//查看病人资料
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

    Rectangle{ //开处方
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

    Rectangle{//选择处方
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
        id:checkCaseTreatment
        width: window.width
        height: window.height

        visible: false
        color: "transparent"
        CheckCaseTreatment{
            width: checkCaseTreatment.width
            height: checkCaseTreatment.height
        }
    }

    Rectangle{//管理界面添加处方
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

    Rectangle{//管理界面 查看处方
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

    Rectangle{// 经络识别成功
        id:testmanageSuccess
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        TestManageSuccess{
            width: testmanageSuccess.width
            height: testmanageSuccess.height
        }

    }

    Rectangle{//批量导入患者
        id:patientImport
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        PatientPiliangImport{
            width: patientImport.width
            height: patientImport.height
        }

    }

    Rectangle{ //经络识别失败
        id:jingluoshibieshibai
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        JingluoShibieFail{
            width: jingluoshibieshibai.width
            height: jingluoshibieshibai.height
        }

    }

    Rectangle{//暂停识别
        id:zantingshibiemess
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        ZantingTiaoliMess{
            width: zantingshibiemess.width
            height: zantingshibiemess.height
        }

    }

    Rectangle{//取消此次调理
        id:canceltreatManage
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        CancelTreatManager{
            width: canceltreatManage.width
            height: canceltreatManage.height
        }

    }

    Rectangle{
        id:addUsermanager
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        AddUserManage{
            width: addUsermanager.width
            height: addUsermanager.height
        }
    }

    Rectangle{ //密码重置
        id:userPasswdReset
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        UserPwdReset{
            width: userPasswdReset.width
            height: userPasswdReset.height
        }
    }

    Rectangle{ //密码重置
        id:userPasswdModify
        width: window.width
        height: window.height
        visible: false
        color: "transparent"
        UserPwdModify{
            width: userPasswdModify.width
            height: userPasswdModify.height
        }
    }

    //显示toast
    ToastMessage{
        id:toastmessage
    }
    function $toastmessage(data){
        if (data&&data.show){
            toastmessage.show=data.show
        }
        if (data&&data.message){
            toastmessage.text=data.message
        }
        if (data&&data.type){
            toastmessage.type=data.type
        }
        if (data&&data.type &&data.type!=='success'&&data.type!=='error'&&data.type!=='info'){
            return false
        }
        toastmessage.openTimer()
    }



    //设置音频
       MediaPlayer {
           id: playMusic
           source: imgaeshprefix+"audios/bgm_gaoshanliushui.mp3"
       }


}
