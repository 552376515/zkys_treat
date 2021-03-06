import QtQuick 2.0
import TaoQuick 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import "../DoctorRoleQml"
Item {
    id:treatmanager
    width: parent
    height: parent
    anchors.fill: parent
    property int bottomHeight: 60
    property int alltreatmentcount: 0
    Rectangle{
        id:treatmanager1
        x:36
        y:36
        width: treatmanager.width-treatmanager1.x*2
        height: treatmanager.height-treatmanager1.y
        Rectangle{
            id:treatmanagerheadRect
            width: treatmanager1.width
            height: 63
            Image {
                id: treatmanagerheadbg
                source:imgaeshprefix+ "images/ys-liebiao-bj"
                width: treatmanagerheadRect.width
                height: treatmanagerheadRect.height
            }
            Text{
                id:treatliebiaoname
                width: 90
                height: treatmanagerheadRect.height
                x:32
                verticalAlignment: Text.AlignVCenter
                text: qsTr("处方管理")
                color: "#0F7E8B"
                font.pixelSize: 19
            }
            Button{
                id:treataddnewcase
                width:102
                height:36
                y:(treatmanagerheadRect.height-treataddnewcase.height)/2.0
                x:treatmanagerheadRect.width-treataddnewcase.width-44
                background: Rectangle{
                    width:treataddnewcase.width
                    height: treataddnewcase.height
                    color: "transparent"
                    Image {
                        id: treataddnewcaseimg
                        source: treataddnewcase.hovered?imgaeshprefix+"images/gl-xinzengchufang-fz.png":imgaeshprefix+"images/gl-xinzengchufang.png"
                    }
                }

                onClicked: {
                    //treatmanagerment.visible=false
                    addTreatManager.visible=true
                }
            }
        }
        Rectangle{
            id:treatmanagerlist
            x:40
            anchors.top: treatmanagerheadRect.bottom
            anchors.topMargin: 10
            width: treatmanager1.width-treatmanagerlist.x*2
            height: treatmanager1.height-63-bottomHeight
            PatientTableHeader{
                id: treatcaseHeader
                width: treatmanagerlist.width
                height: 60
                dataObj: treatcaseModel
                headerNames: treatcaseModel.tableHeaders;
                headerRoles: treatcaseModel.headerRoles
                widthList: caseView.widthList
                xList: caseView.xList
                property real avalidWidth
                updateWidthList: function() {
                    avalidWidth = width
                   // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                     widthList = [treatcaseHeader.width*2/11,treatcaseHeader.width*2/11,treatcaseHeader.width*2/11,treatcaseHeader.width*2/11,treatcaseHeader.width*1/11,treatcaseHeader.width*1/11,treatcaseHeader.width*1/11]
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
            model: treatcaseModel
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
                for (var i = 0; i < treatcaseHeader.widthList.length; ++i) {

                    tw += treatcaseHeader.widthList[i]
                    if (mouseX>=tw0 &&mouseX<tw && i>3){
                        indexX=i
                        break;
                    }
                    tw0+=treatcaseHeader.widthList[i]
                }
                if (indexX==4){
                 treatmanagerCheck.visible=true;
                }

            }

            onDoubleClicked: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }


                //realpatient2.visible=true

                if (treatcaseHeader.xList[1] <= mouseX
                        && mouseX <= treatcaseHeader.xList[2]) {

                    editInput.x = treatcaseHeader.xList[1]
                    editInput.y = caseView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = treatcaseHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = treatcaseModel.data(index)
                    editInput.text = dataObj[treatcaseModel.headerRoles[0]]
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
                            var dataObj = treatcaseModel.data(index)
                            editInput.text = dataObj[treatcaseModel.headerRoles[0]]
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
                        treatcaseModel.insertBeforeRow(index)
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
                        treatcaseModel.removeRow(index)
                    }
                }
            }
            delegate: TreatManagerRow {
                width: caseView.width
                roles: caseView.model.headerRoles
                dataObj: model.display
                widthList: treatcaseHeader.widthList
                xList: treatcaseHeader.xList
                onCheckedChanged: {
                    treatcaseModel.check(index, checked)
                }
            }
        }
        }

        Rectangle{
            anchors.top: treatmanagerlist.bottom
            width: treatmanager1.width
            height: bottomHeight
            color: "#ededed"
            CusPageIndicator{
                anchors.centerIn: parent
                count: alltreatmentcount
                currentIndex: 0
            }
        }

    }
    onVisibleChanged: {
        if (visible){
           alltreatmentcount= treatcaseModel.rowCount()/10+treatcaseModel.rowCount()%10!==0?1:0
            console.log("alltreatmentcount="+alltreatmentcount+" rowcount="+treatcaseModel.rowCount())

        }
    }
}
