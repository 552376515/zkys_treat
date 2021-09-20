import QtQuick 2.0
import QtQuick.Controls 2.5
import TaoQuick 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
import "../DoctorRoleQml"

Item {
    id:glpatientManagerLeft
    width: parent.width
    height: parent.height
    anchors.fill: parent

    property int glbuttonWidth: 133
    property int glbuttonHeight: 30
    property int leftoffset: 36
    property string starttime: ""
    property int bottomHeight: 60
    Rectangle{
        id:gpspaceControl
        height: 68
        width: glpatientManagerLeft.width
        color: "transparent"
        Row{
            width: glbuttonWidth*4+7*3
            x:gpspaceControl.width-glbuttonWidth*4-7*3-38
            CusButton_Image{
                id:glpatientimportBtn
                width: 133
                height: 39
                y:(gpspaceControl.height-glpatientimportBtn.height)/2.0
               // anchors.left: addcasedataheadButton.right
               // anchors.leftMargin: 60
                btnImgUrl:imgaeshprefix+"images/gl-hz-daoru.png"
                btnImgHovered:imgaeshprefix+"images/gl-hz-daoru-fz.png"
                onClicked: {
                         patientImport.visible=true
                }
            }
            Rectangle{
                width: 7
                height: 39
                color: "transparent"
            }
            CusButton_Image{
                id:glpatientdaochuBtn
                width: 133
                height: 39
                y:(gpspaceControl.height-glpatientdaochuBtn.height)/2.0
               // anchors.left: addcasedataheadButton.right
               // anchors.leftMargin: 60
                btnImgUrl:imgaeshprefix+"images/gl-hz-daochu.png"
                btnImgHovered:imgaeshprefix+"images/gl-hz-daochu-fz.png"
                onClicked: {

                }
            }
            Rectangle{
                width: 7
                height: 39
                color: "transparent"
            }
            CusButton_Image{
                id:glpatientbeifenBtn
                width: 133
                height: 39
                y:(gpspaceControl.height-glpatientbeifenBtn.height)/2.0
               // anchors.left: addcasedataheadButton.right
               // anchors.leftMargin: 60
                btnImgUrl:imgaeshprefix+"images/gl-hz-beifen.png"
                btnImgHovered:imgaeshprefix+"images/gl-hz-beifen-fz.png"
                onClicked: {

                }
            }
            Rectangle{
                width: 7
                height: 39
                color: "transparent"
            }
            CusButton_Image{
                id:glpatientshanchuBtn
                width: 133
                height: 39
                y:(gpspaceControl.height-glpatientshanchuBtn.height)/2.0
               // anchors.left: addcasedataheadButton.right
               // anchors.leftMargin: 60
                btnImgUrl:imgaeshprefix+"images/gl-hz-shanchu.png"
                btnImgHovered:imgaeshprefix+"images/gl-hz-shanchu-fz.png"
                onClicked: {

                }
            }
        }

    }
    Rectangle{
        id:glpatientManager
        x:leftoffset
        width: glpatientManagerLeft.width-leftoffset*2
        height: 63
        anchors.top: gpspaceControl.bottom
        anchors.topMargin: 0
        Image {
            id: glpatientheadimg
            width: glpatientManager.width
            height: glpatientManager.height
            source:imgaeshprefix+ "images/ys-liebiao-bj.png"
        }
        Text{
            id:patientHeadlbl
            text: qsTr("患者列表")
            x:leftoffset
            color: "#0F7E8B"
            height: glpatientManager.height
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
        }
        TextField{
            id:glinput
            width:188
            height:glbuttonHeight
            y:(glpatientManager.height-glinput.height)/2.0
            anchors.left: patientHeadlbl.right
            anchors.leftMargin: 360
            placeholderText: "手机号/患者"
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
        Text{
            id:patientTimelbl
            text: qsTr("注册时间：")
            color: "#000000"
            font.pixelSize: 16
            anchors.left: glinput.right
            anchors.leftMargin: 10
            height: glpatientManager.height
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
        }

        CusTextButton{
            id:pickstarttime
            width:98
            height:glbuttonHeight
            y:(glpatientManager.height-pickstarttime.height)/2.0
            anchors.left: patientTimelbl.right
            anchors.leftMargin: 0
            backgroundColorNormal:"white"
            backgroundColorHovered:"#ededed"
            text:starttime.length>0?starttime:"请选择日期"
            textColor:"#AFAFAF"
            font.pointSize:16
        }
        Text{
            id:starttoend
            text: "~"
            width: glbuttonHeight
            height: glpatientManager.height
            anchors.left: pickstarttime.right
            anchors.leftMargin: 0
            color: "black"
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
            horizontalAlignment: Text.AlignHCenter
        }
        CusTextButton{
            id:pickendtime
            width:98
            height:glbuttonHeight
            anchors.left: starttoend.right
            anchors.leftMargin: 0
            y:(glpatientManager.height-pickstarttime.height)/2.0
            backgroundColorNormal:"white"
            backgroundColorHovered:"#ededed"
            text:starttime.length>0?starttime:"请选择日期"
            textColor:"#AFAFAF"
            font.pointSize:16
        }

        Text{
            id:patientLastRegTimelbl
            text: qsTr("最后调理时间：")
            color: "#000000"
            font.pixelSize: 16
            anchors.left: pickendtime.right
            anchors.leftMargin: 10
            height: glpatientManager.height
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
        }

        CusTextButton{
            id:picklaststarttime
            width:98
            height:glbuttonHeight
            y:(glpatientManager.height-pickstarttime.height)/2.0
            anchors.left: patientLastRegTimelbl.right
            anchors.leftMargin: 0
            backgroundColorNormal:"white"
            backgroundColorHovered:"#ededed"
            text:starttime.length>0?starttime:"请选择日期"
            textColor:"#AFAFAF"
            font.pointSize:16
        }
        Text{
            id:laststarttoend
            text: "~"
            width: glbuttonHeight
            height: glpatientManager.height
            anchors.left: picklaststarttime.right
            anchors.leftMargin: 0
            color: "black"
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
            horizontalAlignment: Text.AlignHCenter
        }
        CusTextButton{
            id:lastpickendtime
            width:98
            height:glbuttonHeight
            y:(glpatientManager.height-pickstarttime.height)/2.0
            anchors.left: laststarttoend.right
            anchors.leftMargin: 0
            backgroundColorNormal:"white"
            backgroundColorHovered:"#ededed"
            text:starttime.length>0?starttime:"请选择日期"
            textColor:"#AFAFAF"
            font.pointSize:16
        }


        CusButton_Image{
            id:glsousuo
            width:54
            height:36
            anchors.left: lastpickendtime.right
            anchors.leftMargin: 12
            btnImgNormal:imgaeshprefix+"images/ys-sousuo.png"
            btnImgHovered:imgaeshprefix+"images/ys-sousuo-fz.png"
            y:(glpatientManager.height-glsousuo.height)/2.0
           // text:"病情资料"
            onClicked:{


            }

        }

        CusButton_Image{
            id:glchongzhi
            width:54
            height:36
            anchors.left: glsousuo.right
            anchors.leftMargin: 12
            btnImgNormal:imgaeshprefix+"images/gl-chongzhi.png"
            btnImgHovered:imgaeshprefix+"images/gl-chongzhi-fz.png"
            y:(glpatientManager.height-glchongzhi.height)/2.0
           // text:"病情资料"
            onClicked:{

            }
        }
    }
    property int listleftoffset: 40
    Rectangle{
        id:glpatientList
        x:leftoffset
        width: glpatientManagerLeft.width-leftoffset*2
        height: glpatientManagerLeft.height-glpatientManager.height-gpspaceControl.height
        anchors.top: glpatientManager.bottom
        anchors.topMargin: 0
        PatientTableHeader {
            id: cusHeader
            x:listleftoffset
            width: glpatientList.width-cusHeader.x*2
            height: 59

            dataObj: glpatientModel
            headerNames: glpatientModel.tableHeaders;
            headerRoles: glpatientModel.headerRoles
            widthList: cusView.widthList
            xList: cusView.xList
            property real avalidWidth
            updateWidthList: function() {
                avalidWidth = cusHeader.width/8
               // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                 widthList = [avalidWidth,avalidWidth,avalidWidth,avalidWidth,avalidWidth,avalidWidth,avalidWidth,avalidWidth]
            }
        }
        Rectangle{
            id:baseline
            x:cusHeader.x
            y:cusHeader.height
            width: cusHeader.width
            height: 1
            color: "lightblue"
        }
        CusTableView {
            id: cusView
            y:baseline.y+baseline.height
            x:listleftoffset
            width: cusHeader.avalidWidth*8
            height: glpatientList.height - cusHeader.height-1-bottomHeight
            model: glpatientModel
            onPressed: {
                doPress(mouseX, mouseY)
            }
            onRightPressed: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }
                tableMenu.popup(mouseX, mouseY)
            }
            onReleased: {

                doRelease()
            }
            onPositionChanged: {
                doPositionChanged(mouseX, mouseY)
            }
            onDoubleClicked: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }
                 var dataPobj=glpatientModel.data(index)
                currpatientname=dataPobj[glpatientModel.headerRoles[0]]
                currpatientnum=dataPobj[glpatientModel.headerRoles[1]]
                currpatientSex=dataPobj[glpatientModel.headerRoles[2]]
                currpatientAge=dataPobj[glpatientModel.headerRoles[3]]
                currpatientPhone=dataPobj[glpatientModel.headerRoles[4]]
                currpatientRegtime=dataPobj[glpatientModel.headerRoles[5]]
                if (cusHeader.xList[1] <= mouseX
                        && mouseX <= cusHeader.xList[2]) {

                    editInput.x = cusHeader.xList[1]
                    editInput.y = cusView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = cusHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = glpatientModel.data(index)
                    editInput.text = dataObj[glpatientModel.headerRoles[0]]
                    editInput.visible = true
                    editInput.focus = true
                }
            }
            Menu {
                id: tableMenu
                MenuItem {
                    text: qsTr("Edit row")
                    onTriggered: {
                        var mouseX = tableMenu.x
                        var mouseY = tableMenu.y
                        var index = cusView.indexAt(mouseX, mouseY + cusView.contentY)
                        if (index < 0 || index >= cusView.count) {
                            return
                        }
                        if (cusHeader.xList[1] <= mouseX && mouseX <= cusHeader.xList[2]) {
                            editInput.x = cusHeader.xList[1]
                            editInput.y = cusView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                            editInput.width = cusHeader.widthList[1]
                            editInput.height = CusConfig.fixedHeight
                            editInput.index = index
                            var dataObj = glpatientModel.data(index)
                            editInput.text = dataObj[glpatientModel.headerRoles[0]]
                            editInput.visible = true
                            editInput.focus = true
                        }
                    }
                }
                MenuItem {
                    text: qsTr("Insert before row")
                    onTriggered: {
                        var mouseX = tableMenu.x
                        var mouseY = tableMenu.y
                        var index = cusView.indexAt(mouseX, mouseY + cusView.contentY)
                        if (index < 0 || index >= cusView.count) {
                            return
                        }
                        glpatientModel.insertBeforeRow(index)
                    }
                }
                MenuItem {
                    text: qsTr("Remov row")
                    onTriggered: {
                        var mouseX = tableMenu.x
                        var mouseY = tableMenu.y
                        var index = cusView.indexAt(mouseX, mouseY + cusView.contentY)
                        if (index < 0 || index >= cusView.count) {
                            return
                        }
                        glpatientModel.removeRow(index)
                    }
                }
            }
            delegate: PatientTableRow {
                width: cusView.width
                roles: cusView.model.headerRoles
                dataObj: model.display
                widthList: cusHeader.widthList
                xList: cusHeader.xList
                onCheckedChanged: {
                    glpatientModel.check(index, checked)
                }
            }
        }
        Rectangle{
            anchors.top: cusView.bottom
            width: glpatientList.width
            height: bottomHeight
            color: "#ededed"
            CusPageIndicator{
                anchors.centerIn: parent
                count: 5
                currentIndex: 4
            }
        }


    }

}
