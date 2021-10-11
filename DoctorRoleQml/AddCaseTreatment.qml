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
    property int curentLiaofaIndex: 0
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
                    width: 240
                    height: addcasedatahead.height
                    color: "transparent"
                    Text {
                        id: addcasename
                        width: addLeftHeadname.width
                        height: addcasedatahead.height
                        x:20
                        text: qsTr(currpatientname+"  ("+currpatientnum+")  "+currpatientAge+"岁  病症:")
                        color: "white"
                        font.pixelSize: 18 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                    }
                }


                TextField{
                    id:inputdoctorname
                    width: 360
                    height: 30
                    y:(addcasedatahead.height-inputdoctorname.height)/2.0

                    placeholderText: "病症名/病名"
                    focus: true
                    echoMode: TextInput.Normal
                   // anchors.left: addLeftHeadname.right
                   // anchors.leftMargin: 20
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
                    id:addspace1
                    width: 10
                    height: 58
                    color: "transparent"
                }

//                Button{
//                    id:addcasedataheadButton
//                    width: 100
//                    height: 30
//                    y:(addcasedatahead.height-addcasedataheadButton.height)/2.0

//                   // anchors.left: inputdoctorname.right
//                   // anchors.leftMargin: 30
//                    text: "常见病症库"
//                    onClicked: {
//                        patientdatacheck.visible=false
//                    }
//                }
                Rectangle{
                    id:addspace2
                    width: 470
                    height: 58
                    color: "transparent"
                }

                Button{
                    id:addcaseQuitBtn
                    width: 30
                    height: 30
                    y:(addcasedatahead.height-addcaseQuitBtn.height)/2.0
                   background: Rectangle{
                       width: addcaseQuitBtn.width
                       height: addcaseQuitBtn.height
                       color: "transparent"
                       Image {
                           id: addcaseQuitBtnimg
                           width: addcaseQuitBtn.width
                           height: addcaseQuitBtn.height
                           source:addcaseQuitBtn.hovered ? imgaeshprefix+"images/sy-guanbi-fz.png":imgaeshprefix+"images/ys-guanbi.png"
                       }

                   }

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
                                        eachname: "足少阴肾经"
                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
                                    }
//                                    ListElement {
//                                        eachname: "足少阴肾经(体后)"
//                                        eachimage:"qrc:/new/prefix1/Image/xxx.jpg"//加载图片资源
//                                    }
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
                                    color: gridview.currentIndex===index ?"orange":"black"


                                }
                                MouseArea {
                                           anchors.fill: parent


                                           onClicked: {

                                                gridview.currentIndex=index
                                                if (landscape_name.text=="手少阴心经" ||landscape_name.text=="足厥阴肝经"){
                                                    jingluoplannewModel.addCaseData("仰卧手向上 "+landscape_name.text,curentLiaofaIndex)
                                                  //  console.log("enter to selected")
                                                }
                                                if (landscape_name.text=="手厥阴心包经" ||landscape_name.text=="手太阴肺经" || landscape_name.text=="足阳明胃经"|| landscape_name.text=="足少阳胆经"){
                                                    jingluoplannewModel.addCaseData("仰卧手向下 "+landscape_name.text,curentLiaofaIndex)
                                                   // console.log("enter to selected")
                                                }
                                                if (landscape_name.text=="手少阳三焦经"||landscape_name.text=="手阳明大肠经" ||landscape_name.text=="手太阳小肠经" ){
                                                    jingluoplannewModel.addCaseData("俯卧手向下 "+landscape_name.text,curentLiaofaIndex)
                                                   // console.log("enter to selected")
                                                }
                                                if (landscape_name.text=="足太阴脾经"){
                                                    jingluoplannewModel.addCaseData("仰卧手向上 "+landscape_name.text+"1",curentLiaofaIndex)
                                                    jingluoplannewModel.addCaseData("仰卧手向上 "+landscape_name.text+"2",curentLiaofaIndex)
                                                }

                                                if (landscape_name.text=="足太阳膀胱经"){
                                                     jingluoplannewModel.addCaseData("俯卧手向下 "+landscape_name.text+"1",curentLiaofaIndex)
                                                    jingluoplannewModel.addCaseData("俯卧手向下 "+landscape_name.text+"2",curentLiaofaIndex)
                                                }

                                                if (landscape_name.text=="足少阴肾经"){
                                                    jingluoplannewModel.addCaseData("仰卧手向下 "+landscape_name.text+"(体前)",curentLiaofaIndex)
                                                    jingluoplannewModel.addCaseData("俯卧脚内八 "+landscape_name.text+"(体后)",curentLiaofaIndex)
                                                   // console.log("enter to selected")
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
            id:middlecaselistadd

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
                    width: middlecaselistadd.width
                    //x:10
                    height: 40
                    color: "white"
                    Text {
                        id: jinluoguihualistadd
                        x:10
                        width: addcasemiddlehead.width-jinluoguihualistadd.x*2
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
                        width: addcasemiddlehead.width-jinluoguihualistadd.x*2
                        height: 1
                        color: "#3DA5B0"
                        anchors.top: jinluoguihualistadd.bottom
                    }
                }
                Rectangle{
                    id:middlejingluoplanadd
                   // x:10
                    width: middlecaselistadd.width
                    height: middlecaselistadd.height-40
                    color: "white"

                    PatientTableHeader{
                        id: caseAddHeader
                        x:25
                        width: middlejingluoplanadd.width-caseAddHeader.x*2
                        height: 10
                        dataObj: jingluoplannewModel
                        headerNames: jingluoplannewModel.tableHeaders;
                        headerRoles: jingluoplannewModel.headerRoles
                        widthList: caseAddView.widthList
                        xList: caseAddView.xList
                        property real avalidWidth
                        updateWidthList: function() {
                            avalidWidth = width
                           // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                             widthList = [avalidWidth*3/15,avalidWidth*3/15,avalidWidth*6/15,avalidWidth/15,avalidWidth/15,avalidWidth/15]
                        }
                    }
                    CusTableView {
                        id: caseAddView
                        x:caseAddHeader.x
                        y:caseAddHeader.y+caseAddHeader.height
                        width: caseAddHeader.avalidWidth
                        height: middlejingluoplanadd.height - caseAddHeader.height-80
                        model: jingluoplannewModel

                        onPressed: {
                            doPress(mouseX, mouseY)
                        }
                        onRightPressed: {
                            var index = indexAt(mouseX, mouseY + contentY)
                            if (index < 0 || index >= count) {
                                return
                            }
                            casetableMenu.popup(mouseX, mouseY)

                        }
                        onReleased: {

                            doRelease()
                        }
                        onPositionChanged: {
                            doPositionChanged(mouseX, mouseY)
                        }

                        onSingleClicked:{

                            var index = indexAt(mouseX, mouseY + contentY)
                            if (index < 0 || index >= count) {
                                return
                            }
                            var tw = 0;
                            var tw0=0;
                            var indexX=0;
                            for (var i = 0; i < caseAddHeader.widthList.length; ++i) {

                                tw += caseAddHeader.widthList[i]
                                if (mouseX>=tw0 &&mouseX<tw && i>=3){
                                    indexX=i
                                    break;
                                }
                                tw0+=caseAddHeader.widthList[i]
                            }


                            if (indexX==3){

                                jingluoplannewModel.swapRow(index,index-1);

                            }
                            if (indexX==4){

                                jingluoplannewModel.swapRow(index,index+1);

                            }
                            if (indexX==5){

                                jingluoplannewModel.removeRow(index);
                            }


                        }

                        onDoubleClicked: {
                            var index = indexAt(mouseX, mouseY + contentY)
                            if (index < 0 || index >= count) {
                                return
                            }


                            if (caseAddHeader.xList[1] <= mouseX
                                    && mouseX <= caseAddHeader.xList[2]) {

                                editInput.x = caseAddHeader.xList[1]
                                editInput.y = caseAddView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                                editInput.width = caseAddHeader.widthList[1]
                                editInput.height = CusConfig.fixedHeight
                                editInput.index = index
                                var dataObj = jingluoplannewModel.data(index)
                                editInput.text = dataObj[jingluoplannewModel.headerRoles[0]]
                                editInput.visible = true
                                editInput.focus = true
                            }
                        }
                        Menu {
                            id: casetableMenu
                            MenuItem {
                                text: qsTr("Edit row")
                                onTriggered: {
                                    var mouseX = tableMenu.x
                                    var mouseY = tableMenu.y
                                    var index = caseAddView.indexAt(mouseX, mouseY + caseAddView.contentY)
                                    if (index < 0 || index >= caseAddView.count) {
                                        return
                                    }
                                    if (caseAddHeader.xList[1] <= mouseX && mouseX <= caseAddHeader.xList[2]) {
                                        editInput.x = caseAddHeader.xList[1]
                                        editInput.y = caseAddView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                                        editInput.width = caseAddHeader.widthList[1]
                                        editInput.height = CusConfig.fixedHeight
                                        editInput.index = index
                                        var dataObj = jingluoplannewModel.data(index)
                                        editInput.text = dataObj[jingluoplannewModel.headerRoles[0]]
                                        editInput.visible = true
                                        editInput.focus = true
                                    }
                                }
                            }
                            MenuItem {
                                text: qsTr("Insert before row")
                                onTriggered: {
                                    var mouseX = casetableMenu.x
                                    var mouseY = casetableMenu.y
                                    var index = caseAddView.indexAt(mouseX, mouseY + caseAddView.contentY)
                                    if (index < 0 || index >= caseAddView.count) {
                                        return
                                    }
                                    jingluoplannewModel.insertBeforeRow(index)
                                }
                            }
                            MenuItem {
                                text: qsTr("Remov row")
                                onTriggered: {
                                    var mouseX = casetableMenu.x
                                    var mouseY = casetableMenu.y
                                    var index = caseAddView.indexAt(mouseX, mouseY + caseAddView.contentY)
                                    if (index < 0 || index >= caseAddView.count) {
                                        return
                                    }
                                    jingluoplannewModel.removeRow(index)
                                }
                            }
                        }
                        delegate: AddCaseManageRow {
                            width: caseAddView.width
                            roles: caseAddView.model.headerRoles
                            dataObj: model.display
                            widthList: caseAddHeader.widthList
                            xList: caseAddHeader.xList
                            textColor: "black"
                            onCheckedChanged: {
                            }
                        }
                    }
                        //委托



                }
            }
        }
        Rectangle{
            id:rightcontrolbuttons
            width: 220
            height:addcasedata1.height-addcasedatahead.height
            anchors.left: middlecaselistadd.right
            anchors.leftMargin: 0
            anchors.top: addcasedatahead.bottom
            anchors.topMargin: 0
            color: "#dddddd"
            CusComboBox {
                id:casecombox
                width: 120
                model: ["手选模式", "姿势模式", "生息模式"]
                y:27
                x:(rightcontrolbuttons.width-casecombox.width)/2.0

                displayText: qsTr(currentText)
                onAccepted: {

                }
                onActivated: {
                    curentLiaofaIndex=index;
                    console.log("addcase combox index=="+index)

                    jingluoplannewModel.changeDataByIndex(index);

                }
            }

            Button{
                id:starttreatbutton
                width: 155
                height: 155
                x:(rightcontrolbuttons.width-starttreatbutton.width)/2.0
                y:320

                background: Rectangle{
                    width: starttreatbutton.width
                    height: starttreatbutton.height
                    color: "transparent"
                    Image {
                        id: backImage
                        width: starttreatbutton.width
                        height: starttreatbutton.height
                        source: starttreatbutton.hovered?imgaeshprefix+"images/ys-kaishibiaoli-fz.png":imgaeshprefix+"images/ys-kaishibiaoli.png"
                        anchors.centerIn: parent
                    }

                }
                onClicked:{

                    if (inputdoctorname.text.length>0){
                        currgltreatmentname=inputdoctorname.text+Qt.formatDate(new Date(),"yyyy-MM-dd")
                        addCaseTreatMent.visible=false;
                        if (jingluoplannewModel.rowCount()>0){
                            jingluoplannewModel.addToPatientCaseGl(currpatientnum,currgltreatmentname);
                            patientCaseModel.addToPatientCase(currpatientname,currpatientnum,currpatientcasename,currgltreatmentname,doctorloginname);
                        }
                        realpatient.visible=true;
                    }else{
                        $toastmessage({
                                      "message":"请输入病症名称！",
                                       "type":'info',
                                       "show":true
                                      }
                                     )
                    }


                }
            }

            Button{
                id:savecasebutton
                width: 161
                height: 45
                x:28
                y:starttreatbutton.y+starttreatbutton.height+34

                background:Rectangle{
                    width: savecasebutton.width
                    height:savecasebutton.height
                    color: "transparent"
                    Image {
                        id: savebackimg
                        width: savecasebutton.width
                        height: savecasebutton.height
                        source: savecasebutton.hovered?imgaeshprefix+"images/ys-tianjiazhihuanzhe-fz.png":imgaeshprefix+"images/ys-tianjiazhihuanzhe.png"
                    }
                }

                onClicked:{
                    if (inputdoctorname.text.length>0){
                        currgltreatmentname=inputdoctorname.text+Qt.formatDate(new Date(),"yyyy-MM-dd")
                        if (jingluoplannewModel.rowCount()>0){
                            jingluoplannewModel.addToPatientCaseGl(currpatientnum,currgltreatmentname);
                            patientCaseModel.addToPatientCase(currpatientname,currpatientnum,currpatientcasename,currgltreatmentname,doctorloginname);

                        }
                        addCaseTreatMent.visible=false;
                    }else{
                        $toastmessage({
                                      "message":"请输入病症名称！",
                                       "type":'info',
                                       "show":true
                                      }
                                     )
                    }

                }
            }
            Button{
                id:cancelcasebutton
                width: 161
                height: 45
                x:28
                y:savecasebutton.y+savecasebutton.height+34

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
                    addCaseTreatMent.visible=false;
                }
            }
        }

    }

    Component.onCompleted:{
       // if (visible){
        //    jingluoplannewModel.initCaseData()
       // }
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
    onVisibleChanged: {
        if (visible){
                if (ysCanModifyTreatment){
                    jingluoplannewModel.loadCaseDataByPatientNo(currpatientnum,currgltreatmentname);
                }
        }
    }



}
