import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Rectangle {
    id:patientdata
    width: parent
    height: parent
    anchors.fill: patientdatacheck
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    Rectangle{
        id:addcasedata1
        x:(1600-1130)/2.0//(Screen.desktopAvailableWidth-890)/2.0
        y:(900-750)/2.0+20
        width: 1130
        height: 750
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
            Row{
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
                    y:10
                    anchors.left: addLeftHeadname.right
                    anchors.leftMargin: 60
                    text: "退出"
                    onClicked: {
                          addCaseTreatMent.visible=false;
                    }
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
            color: "#a7e2eb"
            opacity: 1
            Column{
                Rectangle{
                    id:addcasedataheadleft
                    width: addcasedatalist.width-20
                    x:10
                    y:10
                    height: 40
                    color: "#5aa3be"
                    Text {
                        id: jinluolist
                        width: addcasedataheadleft.width
                        height: addcasedataheadleft.height
                        text: qsTr("调理记录")
                        color: "white"
                        font.pixelSize: 20 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                    }
                }
                Rectangle{
                    id:spaceAdddataLeft
                    width: addcasedatalist.width-20
                    height: 10
                    x:10
                    anchors.top: addcasedataheadleft.bottom
                    color: "#d2f1f5"
                }
                Rectangle{
                    id:addcasedataleft
                    width: addcasedatalist.width-20
                    x:10

                   // y:spaceAdddataLeft.y+spaceAdddataLeft.height
                    height: addcasedatalist.height-addcasedataheadleft.height-20
                    anchors.top: spaceAdddataLeft.bottom
                    anchors.topMargin: 0
                    color: "#d2f1f5"


                    ListView {
                        id:listLeftView
                        anchors.fill: addcasedataleft
                        clip: true
                        model:  ListModel {
                                    id: theModel
                                    ListElement {
                                        eachname: "足少阴肾经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
                                    }
                                    ListElement {
                                        eachname: "手厥阴心包经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "手少阳三焦经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "足少阳胆经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "足厥阴肝经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "手太阴肺经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "手阳明大肠经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "足阳明胃经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "足太阴脾经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "手少阴心经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "手太阳小肠经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                    ListElement {
                                        eachname: "足太阳膀胱经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"
                                    }
                                }

                        delegate: adddataDelegate
                    }
                    Component {
                        id: adddataDelegate

                        Rectangle {
                            id: wrapper
                            width: addcasedataleft.width/2-30
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
                                height:wrapper.height
                                x:10
                                color: "#6aaeb9"
                                radius: 10
                                Text {
                                    id:landscape_name
                                    anchors.horizontalCenter: parent.horizontalCenter
//                                    anchors.bottom: parent.bottom
//                                    anchors.bottomMargin: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 15
                                    text: eachname
                                    font.bold: true  		//字体是否加粗，缺省为false
                                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                                    horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                                   // rotation: -90
                                }
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
            anchors.left: addcasedatalist.right
            anchors.leftMargin: 0
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
                            model: jingluoplanModel;
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
            anchors.left: middlecaselist.right
            anchors.leftMargin: 0
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "#afafaf"
            CusButton_Image{
                id:starttreatbutton

            }
            CusButton_Image{
                id:savecasebutton
            }
            CusButton_Image{
                id:cancelcasebutton
            }
        }

    }

    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: login.height // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel1
            z: 99
            //更改x,y即可更改键盘位置
            x: inputdoctorname.x
            y: 200

            //更改width即可更改键盘大小
            width: addcasedata1.width
            visible: false

            externalLanguageSwitchEnabled: false

            states: State {
                name: "visible"
                when: inputPanel1.active
                PropertyChanges {
                    target: inputPanel1
                    // 将键盘顶部放在屏幕底部会使其隐藏起来
                    x: inputX
                    y: inputY
                }
            }

            Component.onCompleted: {
                //VirtualKeyboardSettings.locale = "eesti" // 复古键盘样式
                VirtualKeyboardSettings.wordCandidateList.alwaysVisible = true
            }

            // 这种集成方式下点击隐藏键盘的按钮是没有效果的，只会改变active，因此我们自己处理一下
            onActiveChanged: {
                if(!active) { visible = false }
            }
        }


}
