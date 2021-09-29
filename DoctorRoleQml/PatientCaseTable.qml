import QtQuick 2.0
import QtQuick.Controls 2.5
import TaoQuick 1.0
Item {
    id:patientcaselistall
    width: parent.width
    height: parent.height
    anchors.fill: parent
    Rectangle{
        id:listback
        width: caseList.width
        height: caseList.height
        border.color: "#f5f6f7"
        border.width: 1
        radius: 10
    }

    Rectangle{
        id:patientcaselisthead
        height: 63
        width: caseList.width-2
        x:1
      //  color: "#90cfd8"
        Image {
            id: patientListHeadImage
            source:imgaeshprefix+ "images/ys-liebiao-bj"
            width: caseList.width-2
            height: patientcaselisthead.height
        }
        Row{
            height:parent.height
            x:16
            width: parent.width-32
            Text {
                id: patientcaseName
                width: 128
                height: patientcaselisthead.height
                font.pixelSize: 20 		//字体像素大小，缺省为12
                font.bold: true  		//字体是否加粗，缺省为false
                font.underline: false 	//字体是否有下划线，缺省为false
                verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                color: "#0f7e8b"
                text: qsTr("调理记录")

            }
            Rectangle{
                width: 400
                height: patientcaselisthead.height
                color: "transparent"
            }

            Text {
                id: patientCasePname
                width: 214
                height: patientcaselisthead.height
                font.pixelSize: 18 		//字体像素大小，缺省为12
                font.bold: true  		//字体是否加粗，缺省为false
                font.underline: false 	//字体是否有下划线，缺省为false
                verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                color: "#ff0000"
                visible: currpatientname.length>0
                text: qsTr("患者："+currpatientname +"  年龄："+currpatientAge)
            }
           CusButton_Image{
               id:exittologin
               width:100
               height:42
               btnImgNormal:imgaeshprefix+"images/ys-binqingziliao.png"
               btnImgHovered:imgaeshprefix+"images/ys-binqingziliao-fz.png"
               y:10
              // text:"病情资料"
               onClicked:{
//                   showIndex=0
//                   login.visible=true
                   patientdatacheck.visible=true
               }

           }
        }
    }

    Rectangle{
        id:caserect1
        y:patientcaselisthead.height
        x:20
        width: caseList.width-40
        height: caseList.height-patientcaselisthead.height-caseRect2.height
        color: "white"


        //border.width: 1
        //border.color: "#f5f6f7"

        PatientTableHeader{
            id: caseHeader
            width: caserect1.width
            height: 60
            dataObj: patientCaseModel
            headerNames: patientCaseModel.tableHeaders;
            headerRoles: patientCaseModel.headerRoles
            widthList: caseView.widthList
            xList: caseView.xList
            property real avalidWidth
            updateWidthList: function() {
                avalidWidth = width
               // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                 widthList = [120,400,120,120,120,80]
            }
        }
        Rectangle{
            id:baseline
           // x:20
            y:caseHeader.height
            width: caserect1.width
            height: 1
            color: "lightblue"
        }

        CusTableView {
            id: caseView
            y:caseHeader.y+caseHeader.height
            width: caseHeader.avalidWidth
            height: caserect1.height - caseHeader.height-80
            model: patientCaseModel
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
                var curdataObj=patientCaseModel.data(index)

                currgltreatmentname=curdataObj[patientCaseModel.headerRoles[1]]
                console.log("treatmentname="+currgltreatmentname)
                jingluoplannewModel.loadCaseDataByPatientNo(currpatientnum,currgltreatmentname)
                realpatient.visible=true


                //realpatient2.visible=true

                if (caseHeader.xList[1] <= mouseX
                        && mouseX <= caseHeader.xList[2]) {

                    editInput.x = caseHeader.xList[1]
                    editInput.y = caseView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = caseHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = patientCaseModel.data(index)
                    editInput.text = dataObj[patientCaseModel.headerRoles[0]]
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
                            editInput.x = caseHeader.xList[1]
                            editInput.y = caseView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                            editInput.width = caseHeader.widthList[1]
                            editInput.height = CusConfig.fixedHeight
                            editInput.index = index
                            var dataObj = patientCaseModel.data(index)
                            editInput.text = dataObj[patientCaseModel.headerRoles[0]]
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
                        patientCaseModel.insertBeforeRow(index)
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
                        patientCaseModel.removeRow(index)
                    }
                }
            }
            delegate: PatientTableRow {
                width: caseView.width
                roles: caseView.model.headerRoles
                dataObj: model.display
                widthList: caseHeader.widthList
                xList: caseHeader.xList
                onCheckedChanged: {
                    patientCaseModel.check(index, checked)
                }
            }
        }

    }

    Rectangle{
        id:caseRect2Cha
        width: caserect1.width
        height: 70
        x:20
        y:caserect1.y+caserect1.height
        color: "#ededed"


    }
    Rectangle{
        id:caseRect2
        width: caseList.width
        height: 70
        y:caserect1.y+caserect1.height
        color: "#ededed"
        CusButton_Image{
            id:chakanCase
            width:155
            y:16
            x:282
            height:39
           // text:"开处方"
            btnImgNormal:imgaeshprefix+"images/ys-xuanzechufang.png"
            btnImgHovered:imgaeshprefix+"images/ys-xuanzechufang-fz.png"
            onClicked:{
                closeAllView()

                choiseCaseTreatMent.visible=true
                choisecaseModel.initCaseData();
            }

        }
        CusButton_Image{
            id:addnewp
            width:chakanCase.width
            anchors.left:chakanCase.right
            anchors.leftMargin: 105
            y:16
            height:chakanCase.height
          //  text:"开处方"
            btnImgNormal:imgaeshprefix+"images/ys-kaichufang.png"
            btnImgHovered:imgaeshprefix+"images/ys-kaichufang-fz.png"
            onClicked:{
                addCaseTreatMent.visible=true
                //jingluoplannewModel.initCaseData()
            }

        }

    }

    onVisibleChanged:{
        if (visible){
            showIndex=1
        }
    }

}
