import QtQuick 2.0
import QtQuick.Controls 2.5
import TaoQuick 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Item {
    id:patientManagerLeft
    width: parent
    height: parent
    anchors.fill: parent
    Rectangle{
        id:patientlisthead
        height: 63
        width: patientlist.width
        //color: "#90cfd8"
        Image {
            id: patientListHeadImage
            source:imgaeshprefix+ "images/ys-liebiao-bj"
        }

        Row{
            height: patientlisthead.height
            x:20
            width:patientlist.width
            Text {
                id: patientListName
                width: 90
                height: patientlisthead.height-20
                y:10
                font.pixelSize: 20 		//字体像素大小，缺省为12
                font.bold: true  		//字体是否加粗，缺省为false
                font.underline: false 	//字体是否有下划线，缺省为false
                verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用

                text: qsTr("患者列表")
                color: "#0f7e8b"

            }
            Rectangle{
                width: 130
                height: patientlisthead.height
                color: "transparent"
            }

            Rectangle{
                id: searchRect
                y:13
                width: 200
                height: patientlisthead.height-searchRect.y*2
                radius: 10
                color: "white"

                TextField{
                    id:searchInput
                    width: searchRect.width
                    height: searchRect.height
                    //anchors.margins: 4
                    font.pointSize: 14
                    focus: true
                    placeholderText:qsTr("姓名/手机号")
                    placeholderTextColor: "#afafaf"
                    echoMode: TextInput.Normal

                    onAccepted: {

                    }
                    // 当选择输入框的时候才显示键盘
                    onPressed: {
                               inputX = x
                               inputY = y + height
                               inputPanel.visible = true
                    }
                }
            }
            Rectangle{
                id:watchpatient1
                y:13
                height: 36
                width: 54
                color: "transparent"

                CusButton_Image {
                    width: watchpatient1.width
                    height: watchpatient1.height
                   // btnImgUrl: imgPath + (hovered || pressed ? "Window/minimal_white.png" : "Window/minimal_gray.png")
                    btnImgUrl: imgaeshprefix+ "images/ys-sousuo.png"
                    onClicked: {
                        view.showMinimized()
                    }
                }
            }


        }
    }
    Rectangle{
        id:prect1
        y:patientlisthead.height
        width:  patientlist.width
        height: patientlist.height-patientlisthead.height-patientManagerBottom.height
        color: "#ebfcfe"
        //border.color: "f5f6f7"
       // y:patientlisthead.bottom
        PatientTableHeader {
            id: cusHeader
            x:20
            width: prect1.width-cusHeader.x*2
            height: 60

            dataObj: deviceAddModel
            headerNames: deviceAddModel.tableHeaders;
            headerRoles: deviceAddModel.headerRoles
            widthList: cusView.widthList
            xList: cusView.xList
            property real avalidWidth
            updateWidthList: function() {
                avalidWidth = width
               // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                 widthList = [90,70,50,50,120,90]
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
            x:20
            width: cusHeader.avalidWidth-0
            height: prect1.height - cusHeader.height-1
            model: deviceAddModel
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
                 var dataPobj=deviceAddModel.data(index)
                currpatientname=dataPobj[deviceAddModel.headerRoles[0]]
                currpatientnum=dataPobj[deviceAddModel.headerRoles[1]]
                currpatientSex=dataPobj[deviceAddModel.headerRoles[2]]
                currpatientAge=dataPobj[deviceAddModel.headerRoles[3]]
                currpatientPhone=dataPobj[deviceAddModel.headerRoles[4]]
                currpatientRegtime=dataPobj[deviceAddModel.headerRoles[5]]
                if (cusHeader.xList[1] <= mouseX
                        && mouseX <= cusHeader.xList[2]) {

                    editInput.x = cusHeader.xList[1]
                    editInput.y = cusView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = cusHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = deviceAddModel.data(index)
                    editInput.text = dataObj[deviceAddModel.headerRoles[0]]
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
                            var dataObj = deviceAddModel.data(index)
                            editInput.text = dataObj[deviceAddModel.headerRoles[0]]
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
                        deviceAddModel.insertBeforeRow(index)
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
                        deviceAddModel.removeRow(index)
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
                    deviceAddModel.check(index, checked)
                }
            }
        }
    }

    Rectangle{
        id:patientManagerBottom
        height:70
        y:prect1.y+prect1.height
        width: patientlisthead.width
        color: "#ededed"

        CusButton_Image{
            id:addnewpatient
            width: 155
            height:39
            x:(patientlisthead.width-addnewpatient.width)/2.0
            y:(patientManagerBottom.height-addnewpatient.height)/2.0
            //text: "退出"
            btnImgNormal:imgaeshprefix+"images/ys-xingzenghuanzhe.png"
            btnImgHovered:imgaeshprefix+"images/ys-xingzenghuanzhe-fz.png"
            onClicked: {
                  addnewpt.visible=true;;
            }
        }
    }

}
