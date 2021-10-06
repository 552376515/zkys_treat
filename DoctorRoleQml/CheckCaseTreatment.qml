import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0

Rectangle {
    id:patientdata
    width: parent
    height: parent
    anchors.fill: patientdatacheck
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property int checkcaseWidth: ysCanModifyTreatment?580+220:285+580+220
    property int checkcaseHeight: 750
   // property int checkcaseWidth1: 580+220

    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: false
        hoverEnabled: true
        onClicked: {}

        onReleased: {}

        onPressed: {}
    }
    Rectangle{
        id:addcasedata1
        x:(checkCaseTreatment.width-checkcaseWidth)/2.0//(Screen.desktopAvailableWidth-890)/2.0
        y:(checkCaseTreatment.height-checkcaseHeight)/2.0+20
        width: checkcaseWidth
        height: checkcaseHeight
       // radius: 20
        border.color: "blue"
        border.width: 1
        color: "white"
        opacity: 1
        Rectangle{
            id:addcasedatahead
            width: addcasedata1.width
            height: 50
            opacity:1
            color: "#163a41"
            Rectangle{
                id:addLeftHeadname
                width: addcasename.contentWidth+20
                height: 50
                color: "transparent"
                Text {
                    id: addcasename
                    width: addLeftHeadname.width
                    height: 50
                    x:20
                    text: qsTr("张天 （001） 36岁 病症：")
                    color: "white"
                    font.pixelSize: 20 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
            }
            Button{
                id:addcaseQuitBtn
                width: 100
                height: 30
                x:addcasedatahead.width-addcaseQuitBtn.width-20
                y:(addcasedatahead.height-addcaseQuitBtn.height)/2.0
                text: "退出"
                onClicked: {
                      addCaseTreatMent.visible=false;
                }
            }



        }
        Rectangle{
            id:addcasedatalist
            x:0
            y:0
            width: 285
            height: addcasedata1.height-50
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "#97E4ED"
            opacity: 1
            Column{
                Rectangle{
                    id:addcasedataheadleft
                    x:20
                    width: addcasedatalist.width-addcasedataheadleft.x*2
                    height: 30
                    color: "transparent"

                }
                Text {
                    id: jinluolist
                    width: addcasedataheadleft.width-addcasedataheadleft.x*2
                    height: 20
                    x:22
                    text: qsTr("调理记录")
                    color: "white"
                    font.pixelSize: 20 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                   // verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                Rectangle{
                    id:spaceAdddataLeft
                    width: addcasedatalist.width-20
                    height: 10
                    x:10
                  //  anchors.top: addcasedataheadleft.bottom
                    color: "transparent"
                }
                Rectangle{
                    id:checkcaseHeadList
                    height: 44
                    x:20
                     width: addcasedatalist.width-checkcaseHeadList.x*2
                     color: "#3DA5B0"

                     Text {
                         id: checkcaseHeadListLbl
                         height: 44
                         width: addcasedatalist.width-20
                         text: qsTr("调理时间　　调理医生")
                         color: "white"
                         font.pixelSize: 16
                         verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                         horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                     }
                }

                Rectangle{
                    id:addcasedataleft

                    x:20
                    width: addcasedatalist.width-addcasedataleft.x*2
                   // y:spaceAdddataLeft.y+spaceAdddataLeft.height
                    height: addcasedatalist.height-addcasedataheadleft.height-jinluolist.height-spaceAdddataLeft.height-checkcaseHeadList.height-20
                  //  anchors.top: spaceAdddataLeft.bottom
                  //  anchors.topMargin: 0
                    color: "#d2f1f5"


                    ListView {
                        id:listLeftView
                        anchors.fill: addcasedataleft
                        clip: true
                        model:
                            ListModel {
                                    id: theModel
                                    ListElement {
                                        eachname: "20170910　　张医生"
                                    }
                                    ListElement {
                                        eachname: "20170907　　张医生"

                                    }

                                }

                        delegate: adddataDelegate
                    }
                    Component {
                        id: adddataDelegate

                        Rectangle {
                            id: wrapper
                            width: addcasedataleft.width-30
                            height: 40
                           // anchors.centerIn: gridview.Center
                           // anchors.fill: parent
                           // x:10
//                            anchors.topMargin:10
//                            anchors.leftMargin: 10
                            color: "transparent"
                            //border.color: "6aaeb9"
                           // border.width: 1

                            Rectangle{
                                id:leftname
                                width: wrapper.width
                                height:wrapper.height-10
                                x:15
                                y:5
                                color: "transparent"

                                Text {
                                    id:landscape_name
                                    anchors.horizontalCenter: parent.horizontalCenter
//                                    anchors.bottom: parent.bottom
//                                    anchors.bottomMargin: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 15
                                    text: eachname
                                    font.bold: true  		//字体是否加粗，缺省为false
                                    color: "#4A4A4A"
                                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                                    horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                                   // rotation: -90
                                }
                            }
                            Rectangle{
                                id:wrapperspace
                                width:  wrapper.width
                                x:15
                                height: 1
                                color: "#ededed"
                                anchors.top: leftname.bottom
                            }

                        }
                    }
                }
            }

        }
        Rectangle{
            id:middlecaselist

            width: 580
            height: addcasedata1.height-50
            x:addcasedata1.width-220-middlecaselist.width
//            anchors.left: addcasedatalist.right
//            anchors.leftMargin: 0
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "white"
            opacity: 1
            Column{
                Rectangle{
                    id:addcasemiddlehead
                    width: middlecaselist.width-20
                    x:10
                    height: 40
                    color: "white"
                    Text {
                        id: jinluoguihualist
                        width: addcasemiddlehead.width
                        height: addcasemiddlehead.height-1
                        text: qsTr("经络调理规划")
                        color: "#e2774c"
                        font.pixelSize: 20 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                    }
                    Rectangle{
                        id:jingluoSpace1
                        width: addcasemiddlehead.width
                        height: 1
                        color: "#97bec1"
                        anchors.top: jinluoguihualist.bottom
                    }
                }
                Rectangle{
                    id:middlejingluoplan
                    width: middlecaselist.width
                    height: middlecaselist.height-40

                    ListView {
                            anchors.fill: middlejingluoplan;
                            model:
                                ListModel{
                                id:jingluoplanCheckcaseModel
                                ListElement {
                                                    paraName: "综合方舱门"
                                                    paraCase: "green"
                                                }

                            }

                            delegate: delegatejingluo_list
                            spacing: 0;
                        }
                        //委托
                        Component {
                            id: delegatejingluo_list;
                            Rectangle {
                                id: jingluorect;
                                width: middlejingluoplan.width;
                                height: 40;
                                color: Qt.rgba(0,0,0,0)


                                Text {
                                    id: para_name;
                                    text: paraName + "      "+paraCase;
                                    font.pixelSize: 15;
                                    anchors.centerIn: parent;
                                    width: jingluorect.width
                                    height:jingluorect.height
                                    color: "#333333";
                                    horizontalAlignment: Text.AlignHCenter;
                                }
                                Rectangle {
                                    width: parent.width-20;
                                    height: 1;
                                    x:10
                                    color: "#ececec";
                                    anchors.bottom: parent.bottom;
                                }
                            }
                        }


                }
            }
        }
        Rectangle{
            id:rightcontrolbuttons
            width: 220
            height:addcasedata1.height-50
//            anchors.left: middlecaselist.right
//            anchors.leftMargin: 0
            x:addcasedata1.width-rightcontrolbuttons.width
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "#afafaf"
            Button{
                id:xiugaibtn
                width: 155
                height:40
                y:320
                x:(rightcontrolbuttons.width-xiugaibtn.width)/2.0
                visible: ysCanModifyTreatment
                background: Rectangle{
                    width: xiugaibtn.width
                    height:xiugaibtn.height
                    color: "#7DD1DA"
                    radius: 20
                    Text {
                        id: xiugaibtntxt
                        width:xiugaibtn.width
                        height: xiugaibtn.height
                        text: qsTr("修改处方")
                        color: "white"
                        font.pixelSize: 15
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用

                    }
                }
                onClicked: {
                   // addCaseTreatMent.visible=true
                    checkCaseTreatment.visible=false
                    //jingluoplannewModel.loadCaseDataByPatientNo(currpatientnum,currgltreatmentname);

                }

            }

            Button{
                id:cancelcasebutton
                width: 161
                height: 45
                x:(rightcontrolbuttons.width-cancelcasebutton.width)/2.0
                y:320+40+34

                background: Rectangle{
                    width: cancelcasebutton.width
                    height: cancelcasebutton.height
                    color: "transparent"
                    Image {
                        id: cancelbackimg
                        width: cancelcasebutton.width
                        height: cancelcasebutton.height
                        source: cancelcasebutton.hovered?imgaeshprefix+"images/ys-fanhui-fz.png":imgaeshprefix+"images/ys-fanhui.png"
                    }
                }
                onClicked:{
                    checkCaseTreatment.visible=false;
                }
            }


        }

    }

    onVisibleChanged: {
        if (visible){

               jingluoplanCheckcaseModel.clear();
            var tiwei="";
            jingluoplannewModel.loadCaseDataByPatientNo(currpatientnum,currgltreatmentname);
            for (var i=0;i<jingluoplannewModel.rowCount();i++){
                var datatmp=jingluoplannewModel.data(i);
                var jingluoname=datatmp[jingluoplannewModel.headerRoles[1]]
                var tiweiname=datatmp[jingluoplannewModel.headerRoles[0]]
                jingluoplanCheckcaseModel.append({"paraName":tiweiname,"paraCase":jingluoname})
            }

            theModel.clear()
            for (var i=0;i<patientTreatmentRecordModel.rowCount();i++){
                var datatmp1=patientTreatmentRecordModel.data(i);
                var time=datatmp1[patientTreatmentRecordModel.headerRoles[0]]
                var doctor=datatmp1[patientTreatmentRecordModel.headerRoles[1]]
                theModel.append({"eachname":time+"   " +doctor})
            }
        }
    }

//    property int inputX: 0 // 键盘x坐标(动态)
//    property int inputY: login.height // 键盘y坐标(动态)

//        // 嵌入式虚拟键盘
//    InputPanel {
//            id: inputPanel1
//            z: 99
//            //更改x,y即可更改键盘位置
//            x: inputdoctorname.x
//            y: 200

//            //更改width即可更改键盘大小
//            width: addcasedata1.width
//            visible: false

//            externalLanguageSwitchEnabled: false

//            states: State {
//                name: "visible"
//                when: inputPanel1.active
//                PropertyChanges {
//                    target: inputPanel1
//                    // 将键盘顶部放在屏幕底部会使其隐藏起来
//                    x: inputX
//                    y: inputY
//                }
//            }

//            Component.onCompleted: {
//                //VirtualKeyboardSettings.locale = "eesti" // 复古键盘样式
//                VirtualKeyboardSettings.wordCandidateList.alwaysVisible = true
//            }

//            // 这种集成方式下点击隐藏键盘的按钮是没有效果的，只会改变active，因此我们自己处理一下
//            onActiveChanged: {
//                if(!active) { visible = false }
//            }
//        }


}
