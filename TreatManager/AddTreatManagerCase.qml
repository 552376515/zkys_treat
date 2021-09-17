import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import zmq.Components 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1

Rectangle {
    id:patientdata
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    Rectangle{
        id:addcasedata1
        x:(addCaseTreatMent.width-1130)/2.0
        y:(addCaseTreatMent.height-750)/2.0+20
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
            height: 58
            opacity:1
            color: "#003b42"
            Row{
                Rectangle{
                    id:addLeftHeadname
                    width: 80
                    height: addcasedatahead.height
                    color: "transparent"
                    Text {
                        id: addcasename
                        width: addLeftHeadname.width
                        height: addcasedatahead.height
                        text: qsTr("病症:")
                        color: "white"
                        font.pixelSize: 16 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignRight 	//水平居中，控件必须有width才可以使用
                    }
                }


                TextField{
                    id:inputcasename
                    width: 196
                    height: 30
                    y:(addcasedatahead.height-inputcasename.height)/2.0

                    placeholderText: "点击输入病症名称"
                    focus: true
                    echoMode: TextInput.Normal
                    onAccepted: {
                        color:"#999999"
                    }
                    // 当选择输入框的时候才显示键盘
                    onPressed: {
                               inputX = x
                               inputY = y + height
                               inputPanel1.visible = true
                    }
                }

                Text {
                    id: addcasemanager1
                    width: 114
                    height: addcasedatahead.height
                    text: qsTr("处方名称:")
                    color: "white"
                    font.pixelSize: 16 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignRight 	//水平居中，控件必须有width才可以使用
                }
                TextField{
                    id:inputtreatname
                    width: 196
                    height: 30
                    y:(addcasedatahead.height-inputtreatname.height)/2.0

                    placeholderText: "点击输入处方名称"
                    focus: true
                    echoMode: TextInput.Normal
                    onAccepted: {
                        color:"#999999"
                    }
                    // 当选择输入框的时候才显示键盘
                    onPressed: {
                               inputX = x
                               inputY = y + height
                               inputPanel1.visible = true
                    }
                }



                Rectangle{
                    id:addspace2
                    width: addcasedatahead.width-addLeftHeadname.width-inputcasename.width-addcasemanager1.width-inputtreatname.width-addcaseQuitBtn.width
                    height: addcasedatahead.height
                    color: "transparent"
                }

                CusButton_Image{
                    id:addcaseQuitBtn
                    width: 30
                    height: 30
                    y:(addcasedatahead.height-addcaseQuitBtn.height)/2.0
                   // anchors.left: addcasedataheadButton.right
                   // anchors.leftMargin: 60
                    btnImgUrl:imgaeshprefix+"images/ys-guanbi.png"
                    btnImgHovered:imgaeshprefix+"images/sy-guanbi-fz.png"
                    onClicked: {
                          addTreatManager.visible=false;
                    }
                }

            }

        }
        Rectangle{
            id:addcasedatalist
            x:0
            y:0
            width: 325
            height: addcasedata1.height-addcasedatahead.height
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "#97E4ED"
            opacity: 1
            Column{
                Rectangle{
                    id:addcaseLeft1
                    width: addcasedatalist.width
                    height: 10
                    color: "transparent"
                }

                Rectangle{
                    id:addcasedataheadleft
                    width: addcasedatalist.width-20
                    x:10
                    height: 40
                    color: "#3DA5B0"
                    Text {
                        id: jinluolist
                        width: addcasedataheadleft.width
                        height: addcasedataheadleft.height
                        text: qsTr("经络调理配伍")
                        color: "white"
                        font.pixelSize: 18 		//字体像素大小，缺省为12
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

                    color:"#d2f1f5"
                    //"#6aaeb9"
                }
                Rectangle{
                    id:addcasedataleft
                    width: addcasedatalist.width-20
                    x:10

                   // y:spaceAdddataLeft.y+spaceAdddataLeft.height
                    height: addcasedatalist.height-addcasedataheadleft.height-addcaseLeft1.height-spaceAdddataLeft.height-15
//                    anchors.top: spaceAdddataLeft.bottom
//                    anchors.topMargin: 0
                    color: "#d2f1f5"


                    GridView {
                        id:gridview

                        anchors.fill: addcasedataleft
                        clip: true
                        model:  ListModel {
                                    id: theModel
                                    ListElement {
                                        eachname: "足少阴肾经(体前)"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
                                    }
                                    ListElement {
                                        eachname: "足少阴肾经(体后)"
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
                        cellWidth: addcasedataleft.width/2
                        cellHeight: 50
                        delegate: adddataDelegate

                    }
                    Component {
                        id: adddataDelegate

                        Rectangle {
                            id: wrapper
                            width: addcasedataleft.width/2-30
                            height: gridview.cellHeight-20
                            anchors.centerIn: gridview.Center
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
                                color: "#7dbbc4"
                                radius: 10
                                Text  {
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
                                MouseArea {
                                           anchors.fill: parent
                                           onClicked: {


                                                if (landscape_name.text=="足太阴脾经"||landscape_name.text=="手少阴心经" ||landscape_name.text=="足厥阴肝经"){
                                                    jingluoplanModel.addCaseData("仰卧手向上 "+landscape_name.text)
                                                    console.log("enter to selected")
                                                }
                                                if (landscape_name.text=="足少阴肾经(体前)"||landscape_name.text=="手厥阴心包经" ||landscape_name.text=="手太阴肺经" || landscape_name.text=="足阳明胃经"|| landscape_name.text=="足少阳胆经"){
                                                    jingluoplanModel.addCaseData("仰卧手向上下 "+landscape_name.text)
                                                    console.log("enter to selected")
                                                }
                                                if (landscape_name.text=="手少阳三焦经"||landscape_name.text=="手阳明大肠经" ||landscape_name.text=="手太阳小肠经" || landscape_name.text=="足太阳膀胱经"){
                                                    jingluoplanModel.addCaseData("俯卧手向上下 "+landscape_name.text)
                                                    console.log("enter to selected")
                                                }
                                                if (landscape_name.text=="足少阴肾经(体后)"){
                                                    jingluoplanModel.addCaseData("俯卧脚内八 "+landscape_name.text)
                                                    console.log("enter to selected")
                                                }

                                           }

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
            height: addcasedata1.height-addcasedatahead.height
            anchors.left: addcasedatalist.right
            anchors.leftMargin: 0
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "white"
            opacity: 1
            Column{
                Rectangle{
                    id:addcasemiddlehead
                    width: middlecaselist.width
                    //x:10
                    height: 40
                    color: "white"
                    Text {
                        id: jinluoguihualist
                        x:10
                        width: addcasemiddlehead.width-jinluoguihualist.x*2
                        height: addcasemiddlehead.height-1
                        text: qsTr("经络调理规划")
                        color: "#EF6001"
                        font.pixelSize: 20 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                    }
                    Rectangle{
                        id:jingluoSpace1
                        x:10
                        width: addcasemiddlehead.width-jinluoguihualist.x*2
                        height: 1
                        color: "#3DA5B0"
                        anchors.top: jinluoguihualist.bottom
                    }
                }
                Rectangle{
                    id:middlejingluoplan
                   // x:10
                    width: middlecaselist.width
                    height: middlecaselist.height-40
                    color: "white"
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
                                x:20
                                width: middlejingluoplan.width-40;
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
                                    horizontalAlignment: Text.AlignLeft;
                                    verticalAlignment: Text.AlignVCenter
                                }
                                Rectangle {
                                    width: jingluorect.width
                                    height: 1;
                                    x:0
                                    color: "#ececec";
                                    anchors.bottom: parent.bottom;
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {

                                        addCaseTreatMent.visible=false;
                                    }

                                }
                            }

                        }


                }
            }
        }
        Rectangle{
            id:rightcontrolbuttons
            width: 220
            height:addcasedata1.height-addcasedatahead.height
            anchors.left: middlecaselist.right
            anchors.leftMargin: 0
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "#dddddd"
            CusButton_Image{
                id:starttreatbutton
                width: 155
                height: 155
                x:(rightcontrolbuttons.width-starttreatbutton.width)/2.0
                y:320
                btnImgUrl:imgaeshprefix+"images/ys-kaishibiaoli.png"
                btnImgHovered:imgaeshprefix+"images/ys-kaishibiaoli-fz.png"
                //font.pointSize:20

                onClicked:{

                }

            }
            CusButton_Image{
                id:savecasebutton
                width: 161
                height: 45
                x:28
                y:starttreatbutton.y+starttreatbutton.height+34
                btnImgUrl:imgaeshprefix+"images/ys-tianjiazhihuanzhe.png"
                btnImgHovered:imgaeshprefix+"images/ys-tianjiazhihuanzhe-fz.png"
                onClicked:{
                    if (jingluoplanModel.rowCount()>0){

                    }
                }
            }
            CusButton_Image{
                id:cancelcasebutton
                width: 161
                height: 45
                x:28
                y:savecasebutton.y+savecasebutton.height+34
                btnImgUrl:imgaeshprefix+"images/ys-fanhui.png"
                btnImgHovered:imgaeshprefix+"images/ys-fanhui-fz.png"
                onClicked:{
                    addCaseTreatMent.visible=false;
                }
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
            x: inputcasename.x
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

//    MouseArea{
//        id:addCaseMoueseArea
//        anchors.fill: patientdata
//        onClicked: {

//            if ((mouseX>(addcasedata1.x+addcasedata1.width) || mouseX<addcasedata1.x) ||(mouseY>(addcasedata1.y+addcasedata1.width) || mouseY<addcasedata1.y) )
//            {
//                addCaseTreatMent.visible=false;
//            }else{
//                if ((mouseX>inputdoctorname.x &&mouseX<inputdoctorname.x+inputdoctorname.width) || (mouseY>inputdoctorname.y && mouseY<inputdoctorname.y+inputdoctorname.height)){
//                    inputX=mouseX
//                    inputY=mouseY
//                    inputPanel1.visible=true
//                }
//            }
//        }
//    }

}
