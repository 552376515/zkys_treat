import QtQuick 2.0
import "../DoctorRoleQml"
import TaoQuick 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
Item {
    id:usermanage
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property int leftoffset: 36
    property int topoffset: 39

    property int inputwidth: 188
    property int chongzhiwidth: 54
    property int spacechongzhi: 12
    property int rightspace: 20
    property int alldoctorscount: 0
    property int bottomheight: 60
    Rectangle{
        id:usermanage1
        x:leftoffset
        y:topoffset
        width: usermanage.width-usermanage1.x*2
        height: usermanage.height-usermanage1.y
        Rectangle{
            id:usermanageheadRect
            width: usermanage1.width
            height: 63
            Image {
                id: usermanageHeadImg
                source:imgaeshprefix+ "images/ys-liebiao-bj"
                width: usermanageheadRect.width
                height: usermanageheadRect.height
            }
            Text{
                id:usermanageliebiaoname
                width: 90
                height: usermanageheadRect.height
                x:32
                verticalAlignment: Text.AlignVCenter
                text: qsTr("用户列表")
                color: "#0F7E8B"
                font.pixelSize: 19
            }
            Rectangle{
                id:usermanageheadRight
                x:usermanageheadRect.width-inputwidth-chongzhiwidth*2-spacechongzhi*2-rightspace
                width: inputwidth+chongzhiwidth*2+spacechongzhi+rightspace
                height: usermanageheadRect.height
                color: "transparent"
                TextField{
                    id:userInputName
                    width: inputwidth
                    height: 30
                    y:(usermanageheadRight.height-userInputName.height)/2.0
                    placeholderText: "点击输入姓名"
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

                CusButton_Image{
                    id:glsousuo
                    width:chongzhiwidth
                    height:36
                    anchors.left: userInputName.right
                    anchors.leftMargin: spacechongzhi
                    btnImgNormal:imgaeshprefix+"images/ys-sousuo.png"
                    btnImgHovered:imgaeshprefix+"images/ys-sousuo-fz.png"
                    y:(usermanageheadRight.height-glsousuo.height)/2.0
                   // text:"病情资料"
                    onClicked:{


                    }

                }

                CusButton_Image{
                    id:glchongzhi
                    width:chongzhiwidth
                    height:36
                    anchors.left: glsousuo.right
                    anchors.leftMargin: spacechongzhi
                    btnImgNormal:imgaeshprefix+"images/gl-chongzhi.png"
                    btnImgHovered:imgaeshprefix+"images/gl-chongzhi-fz.png"
                    y:(usermanageheadRight.height-glchongzhi.height)/2.0
                   // text:"病情资料"
                    onClicked:{
                        addUsermanager.visible=true
                    }
                }
            }

        }


        Rectangle{
            id:treatmanagerlist
            x:36
            anchors.top: usermanageheadRect.bottom
            anchors.topMargin: 10
            width: usermanage1.width-treatmanagerlist.x*2
            height: usermanage1.height-63-bottomheight
            PatientTableHeader{
                id: treatcaseHeader
                width: treatmanagerlist.width
                height: 60
                dataObj: gldoctorModel
                headerNames: gldoctorModel.tableHeaders;
                headerRoles: gldoctorModel.headerRoles
                widthList: caseView.widthList
                xList: caseView.xList
                property real avalidWidth
                property real eachtmpwidth
                updateWidthList: function() {
                    avalidWidth = width
                    eachtmpwidth=(width-101-77-87)/7
                   // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                     widthList = [eachtmpwidth,eachtmpwidth,eachtmpwidth,eachtmpwidth,eachtmpwidth,eachtmpwidth*2,101,77,87]
                }
            }
            Rectangle{
                id:treatbaseline
               // x:20
                y:treatcaseHeader.height
                width: treatcaseHeader.width
                height: 1
                color: "lightblue"
            }

        CusTableView {
            id: caseView
            y:treatcaseHeader.y+treatcaseHeader.height
            width: treatcaseHeader.avalidWidth
            height: treatmanagerlist.height - treatcaseHeader.height
            model: gldoctorModel
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
            onDoubleClicked: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }

                var tw = 0;
                var tw0=0;
                var indexX=0;
                for (var i = 0; i < treatcaseHeader.widthList.length; ++i) {

                    tw += treatcaseHeader.widthList[i]
                    if (mouseX>=tw0 &&mouseX<tw && i>5){
                        indexX=i
                        break;
                    }
                    tw0+=treatcaseHeader.widthList[i]
                }
                 var docdataObj = gldoctorModel.data(index)
                glselecteddoctor=docdataObj[gldoctorModel.headerRoles[1]]
                if (indexX==6){
                 userPasswdReset.visible=true;

                }

                if (indexX==7){
                    userPasswdModify.visible=true
                }
                if (indexX==8){
                    console.log("forbid doctorid="+glselecteddoctor)
                    gldoctorModel.forbidUser(glselecteddoctor)
                }

                //realpatient2.visible=true

                if (treatcaseHeader.xList[1] <= mouseX
                        && mouseX <= treatcaseHeader.xList[2]) {

                    editInput.x = treatcaseHeader.xList[1]
                    editInput.y = caseView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = treatcaseHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = gldoctorModel.data(index)
                    editInput.text = dataObj[gldoctorModel.headerRoles[0]]
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
                        var index = caseView.indexAt(mouseX, mouseY + caseView.contentY)
                        if (index < 0 || index >= caseView.count) {
                            return
                        }
                        if (caseHeader.xList[1] <= mouseX && mouseX <= caseHeader.xList[2]) {
                            editInput.x = treatcaseHeader.xList[1]
                            editInput.y = caseView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                            editInput.width = treatcaseHeader.widthList[1]
                            editInput.height = CusConfig.fixedHeight
                            editInput.index = index
                            var dataObj = gldoctorModel.data(index)
                            editInput.text = dataObj[gldoctorModel.headerRoles[0]]
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
                        var index = caseView.indexAt(mouseX, mouseY + caseView.contentY)
                        if (index < 0 || index >= caseView.count) {
                            return
                        }
                        gldoctorModel.insertBeforeRow(index)
                    }
                }
                MenuItem {
                    text: qsTr("Remov row")
                    onTriggered: {
                        var mouseX = casetableMenu.x
                        var mouseY = casetableMenu.y
                        var index = caseView.indexAt(mouseX, mouseY + caseView.contentY)
                        if (index < 0 || index >= caseView.count) {
                            return
                        }
                        gldoctorModel.removeRow(index)
                    }
                }
            }
            delegate: UserManageRow {
                width: caseView.width
                height: 50
                roles: caseView.model.headerRoles
                dataObj: model.display
                widthList: treatcaseHeader.widthList
                xList: treatcaseHeader.xList
                onCheckedChanged: {

                }
            }
        }
       }
        Rectangle{
            anchors.top: treatmanagerlist.bottom
            width: usermanage1.width
            height:bottomheight
            color: "#ededed"
            CusPageIndicator{
                anchors.centerIn: parent
                count: alldoctorscount
                currentIndex: 0
            }
        }

    }

    onVisibleChanged: {
        if (visible){
           alldoctorscount= gldoctorModel.rowCount()/10+gldoctorModel.rowCount()%10!==0?1:0


        }
    }

}
