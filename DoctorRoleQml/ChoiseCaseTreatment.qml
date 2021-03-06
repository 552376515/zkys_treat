import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import zmq.Components 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1

Rectangle {
    id:choisepatientdata
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    property string currCaseName: "痛风"
    property string currTreatment: "轻度痛风调理"
    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: false
        hoverEnabled: true
        onClicked: {}

        onReleased: {}

        onPressed: {}
    }
    Rectangle{
        id:choisecasedata1
        x:(choiseCaseTreatMent.width-1130)/2.0
        y:(choiseCaseTreatMent.height-750)/2.0+20
        width: 1130
        height: 750
       // radius: 20
        border.color: "blue"
        border.width: 1
        color: "white"
        opacity: 1
        Rectangle{
            id:choisecasedatahead
            width: choisecasedata1.width
            height: 58
            opacity:1
            color: "#003b42"
            Row{
                Rectangle{
                    id:choiseLeftHeadname
                    width: 1086
                    height: choisecasedatahead.height
                    color: "transparent"
                    Text {
                        id: choisecasename
                        x:20
                        width: choiseLeftHeadname.width-choisecasename.x*2
                        height: choisecasedatahead.height

                        text: qsTr("选择处方")
                        color: "white"
                        font.pixelSize: 18 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                    }
                }

                Button{
                    id:choisecaseQuitBtn
                    width: 30
                    height: 30
                    y:(choisecasedatahead.height-choisecaseQuitBtn.height)/2.0
                   // anchors.left: addcasedataheadButton.right
                   // anchors.leftMargin: 60
                    background: Rectangle{
                        width: choisecaseQuitBtn.width
                        height: choisecaseQuitBtn.height
                        color: "transparent"
                        Image {
                            id: choisecaseQuitBtnimg
                            width: choisecaseQuitBtn.width
                            height: choisecaseQuitBtn.height
                            source: choisecaseQuitBtn.hovered?imgaeshprefix+"images/sy-guanbi-fz.png":imgaeshprefix+"images/ys-guanbi.png"
                        }
                    }


                    onClicked: {
                          choiseCaseTreatMent.visible=false;
                    }
                }
            }

        }
        Rectangle{
            id:choisecasedatalist
            x:0
            y:0
            width: 325
            height: choisecasedata1.height-choisecasedatahead.height
            anchors.top: choisecasedatahead.bottom
            anchors.topMargin: 0
            color: "#97E4ED"
            opacity: 1
            Column{
                Rectangle{
                    id:choisecaseLeft1
                    width: choisecasedatalist.width
                    height: 40
                    color: "transparent"
                }

                Rectangle{
                    id:choisecasedataheadleft
                    width: choisecasedatalist.width-20
                    height: 20
                    color: "transparent"
                    Text {
                        id: choiselist
                        x:24
                        width: choisecasedataheadleft.width-choiselist.x*2
                        height: choisecasedataheadleft.height

                        text: qsTr("处方列表")
                        color: "white"
                        font.pixelSize: 18 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                    }
                }
                Rectangle{
                    id:spaceAdddataLeft
                    width: choisecasedatalist.width-20
                    height: 10
                  //  x:10

                    color:"transparent"
                    //"#6aaeb9"
                }
                Rectangle{
                    id:choisecasedataleft
                    width: choisecasedatalist.width-50
                    x:20

                   // y:spaceAdddataLeft.y+spaceAdddataLeft.height
                    height: choisecasedatalist.height-70-24
//                    anchors.top: spaceAdddataLeft.bottom
//                    anchors.topMargin: 0
                    color: "#d2f1f5"
                    Rectangle{
                        id:choiseHeaderLeft
                        width: choisecasedataleft.width
                        height: 44
                        color: "#3DA5B0"
                        PatientTableHeader{
                            id: choiseHeader
                            width: choiseHeaderLeft.width
                            height: choiseHeaderLeft.height
                            dataObj: choisecaseModel
                            headerNames: choisecaseModel.tableHeaders;
                            headerRoles: choisecaseModel.headerRoles
                            widthList: choiseView.widthList
                            isChoise: true
                            xList: choiseView.xList
                            property real avalidWidth
                            updateWidthList: function() {
                                avalidWidth = width
                               // widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
                                 widthList = [choiseHeader.width/3,choiseHeader.width*2/3]
                            }
                        }
                    }


                    CusTableView {
                        id: choiseView
                        y:choiseHeader.y+choiseHeader.height
                        width: choiseHeader.avalidWidth
                        height: choisecasedataleft.height - choiseHeader.height
                        model: choisecaseModel
                        onPressed: {
                            doPress(mouseX, mouseY)
                        }
                        onRightPressed: {
                            var index = indexAt(mouseX, mouseY + contentY)
                            if (index < 0 || index >= count) {
                                return
                            }
                            choisetableMenu.popup(mouseX, mouseY)
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
                            var dataObj1 = choisecaseModel.data(index)
                            var casename=dataObj1[choisecaseModel.headerRoles[0]];
                            var treatment=dataObj1[choisecaseModel.headerRoles[1]];
                            if (casename!==currCaseName || treatment!==currTreatment){
                                currCaseName=casename
                                currTreatment=treatment
                                //console.log("treatment="+treatment)
                                jingluoplanModel.loadCaseDataByCaseTreatment(casename,treatment)
                                //console.log("treatment1="+treatment)
                                choisejingluoplanlist.clear()
                                //console.log("treatment2="+treatment)
                                for (var i=0;i<jingluoplanModel.rowCount();i++){
                                    var datatmp=jingluoplanModel.data(i);
                                    var jingluoname=datatmp[jingluoplanModel.headerRoles[1]]
                                    var tiweiname=datatmp[jingluoplanModel.headerRoles[0]]
                                    choisejingluoplanlist.append({"layName":tiweiname,"jingluoName":jingluoname})
                                }
                            }


                        }


                        delegate: PatientTableRow {
                            width: choiseView.width
                            roles: choiseView.model.headerRoles
                            dataObj: model.display
                            widthList: choiseHeader.widthList
                            xList: choiseHeader.xList
                            onCheckedChanged: {
                                choisecaseModel.check(index, checked)
                            }
                        }
                    }



                }
            }
        }
        Rectangle{
            id:middlechoiselist

            width: 580
            height: choisecasedata1.height-choisecasedatahead.height
            anchors.left: choisecasedatalist.right
            anchors.leftMargin: 0
            anchors.top: choisecasedatahead.bottom
            anchors.topMargin: 0
            color: "white"
            opacity: 1
            Column{
                Rectangle{
                    id:choiseCaseplanHeader
                    width: middlechoiselist.width
                    height: 22
                }
                Rectangle{
                    id:choiseCaseplanHeader1
                    width: middlechoiselist.width
                    height: 50
                    //color: "white"
                    Text {
                        id: choiseCaseName1
                        text: qsTr("病症："+currCaseName)
                        font.pixelSize: 19 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                        width: middlechoiselist.width
                        height: 25
                        x:36
                    }
                    Text {
                        id: choiseCaseName2
                        text: qsTr("处方名称："+currTreatment)
                        font.pixelSize: 19 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                        width: middlechoiselist.width
                        height: 25
                        x:36
                        y:25
                    }
                }



                Rectangle{
                    id:choiseCaseplanHeader2
                    width: middlechoiselist.width
                    height: 20
                }
                Rectangle{
                    id:choiseCaseplanHeader3
                    x:30
                    width: middlechoiselist.width-choiseCaseplanHeader3.x*2
                    height: 1
                    color: "black"
                }

                Rectangle{
                    id:choisecasemiddlehead
                    width: middlechoiselist.width
                    //x:10
                    height: 40
                    color: "white"
                    Text {
                        id: jinluoguihualist
                        x:10
                        width: choisecasemiddlehead.width-jinluoguihualist.x*2
                        height: choisecasemiddlehead.height
                        text: qsTr("经络调理规划")
                        color: "#EF6001"
                        font.pixelSize: 20 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                    }
//                    Rectangle{
//                        id:jingluoSpace1
//                        x:30
//                        width: choisecasemiddlehead.width-jingluoSpace1.x*2
//                        height: 1
//                        color: "#3DA5B0"
//                        anchors.top: jinluoguihualist.bottom
//                    }
                }
                Rectangle{
                    id:middlejingluoplan
                   // x:10
                    width: middlechoiselist.width
                    height: middlechoiselist.height-40-93
                    color: "white"
                    ListView {
                            anchors.fill: middlejingluoplan;
                            model:
                                ListModel{
                                id:choisejingluoplanlist
                                ListElement {
                                    layName: ""
                                    jingluoName:""
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
                                x:20
                                width: middlejingluoplan.width-40;
                                height: 40;
                              //  color: Qt.rgba(0,0,0,0)
                                color: layName ==="仰卧手向上"?"#f9e4c6": layName==="俯卧手向下" ?"#edfbd0":"#cfe7fa"

                                Text {
                                    id: para_name;
                                    text: layName + "      "+jingluoName;
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
            height:choisecasedata1.height-choisecasedatahead.height
            anchors.left: middlechoiselist.right
            anchors.leftMargin: 0
            anchors.top: choisecasedatahead.bottom
            anchors.topMargin: 0
            color: "#dddddd"
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
                        id: starttreatbuttonimg
                        width: starttreatbutton.width
                        height: starttreatbutton.height
                        source: starttreatbutton.hovered?imgaeshprefix+"images/ys-kaishibiaoli-fz.png":imgaeshprefix+"images/ys-kaishibiaoli.png"
                    }
                }

                //font.pointSize:20

                onClicked:{
                    currgltreatmentname=currTreatment
                    jingluoplannewModel.addToPatientCaseGl(currpatientnum,currTreatment);
                    currpatientcasename=currCaseName
                    patientCaseModel.addToPatientCase(currpatientname,currpatientnum,currpatientcasename,currgltreatmentname,doctorloginname);
                    choiseCaseTreatMent.visible=false;
                    realpatient.visible=true;
                }

            }
            Button{
                id:savecasebutton
                width: 161
                height: 45
                x:28
                y:starttreatbutton.y+starttreatbutton.height+34
                background: Rectangle{
                    width: savecasebutton.width
                    height: savecasebutton.height
                    color: "transparent"
                    Image {
                        id: savecasebuttonimg
                        width: savecasebutton.width
                        height: savecasebutton.height
                        source: savecasebutton.hovered?imgaeshprefix+"images/ys-tianjiazhihuanzhe-fz.png":imgaeshprefix+"images/ys-tianjiazhihuanzhe.png"
                    }
                }
                onClicked:{
                    currgltreatmentname=currTreatment
                    jingluoplannewModel.addToPatientCaseGl(currpatientnum,currTreatment);
                    currpatientcasename=currCaseName
                    patientCaseModel.addToPatientCase(currpatientname,currpatientnum,currpatientcasename,currgltreatmentname,doctorloginname);
                    choiseCaseTreatMent.visible=false;

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
                        id: cancelcasebuttonimg
                        width: cancelcasebutton.width
                        height: cancelcasebutton.height
                        source: cancelcasebutton.hovered?imgaeshprefix+"images/ys-fanhui-fz.png":imgaeshprefix+"images/ys-fanhui.png"
                    }
                }
                onClicked:{
                    choiseCaseTreatMent.visible=false;
                }
            }
        }

    }



}
