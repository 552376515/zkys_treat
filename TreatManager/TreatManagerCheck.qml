import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import zmq.Components 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1

Rectangle {
    id:checktreatmananger
    width: parent.width
    height: parent.height

    anchors.fill: parent
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: false
        hoverEnabled: true
        onClicked: {}

        onReleased: {}

        onPressed: {}
    }
    property int managerWidth : 854
    property int managerHeight: 758
    property int rightWidth: 215
    property int managerHeadHeight: 58
    Rectangle{
        id:checkreatcase1
        x:(checktreatmananger.width-managerWidth)/2.0
        y:(checktreatmananger.height-managerHeight)/2.0+20
        width: managerWidth
        height: managerHeight
       // radius: 20
        border.color: "blue"
        border.width: 1
        color: "white"
        opacity: 1
        Rectangle{
            id:checktreathead
            width: checkreatcase1.width
            height: managerHeadHeight
            opacity:1
            color: "#003b42"
            Row{
                Rectangle{
                    id:checkLeftHeadname
                    width: 80
                    height: checktreathead.height
                    color: "transparent"
                    Text {
                        id: checkcasename
                        width: checkcasename.contentWidth+50
                        height: checkLeftHeadname.height
                        text: qsTr("病症:"+currglcasename)
                        color: "white"
                        font.pixelSize: 16 		//字体像素大小，缺省为12
                        font.bold: true  		//字体是否加粗，缺省为false
                        font.underline: false 	//字体是否有下划线，缺省为false
                        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                        horizontalAlignment: Text.AlignRight 	//水平居中，控件必须有width才可以使用
                    }
                }


                Text {
                    id: checkcasemanager1
                    width: checkcasemanager1.contentWidth+70
                    height: checkLeftHeadname.height
                    text: qsTr("处方名称:"+currgltreatmentname)
                    color: "white"
                    font.pixelSize: 16 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignRight 	//水平居中，控件必须有width才可以使用
                }



                Rectangle{
                    id:addspace2
                    width: checktreathead.width-checkLeftHeadname.width-checkcasemanager1.width-addcaseQuitBtn.width-30
                    height: checkLeftHeadname.height
                    color: "transparent"
                }

                CusButton_Image{
                    id:addcaseQuitBtn
                    width: 30
                    height: 30
                    y:(checktreathead.height-addcaseQuitBtn.height)/2.0
                   // anchors.left: addcasedataheadButton.right
                   // anchors.leftMargin: 60
                    btnImgUrl:imgaeshprefix+"images/ys-guanbi.png"
                    btnImgHovered:imgaeshprefix+"images/sy-guanbi-fz.png"
                    onClicked: {
                          treatmanagerCheck.visible=false;
                    }
                }

            }

        }

        Rectangle{
            id:middlecaselist

            width: 638
            height: checkreatcase1.height-checktreathead.height
            anchors.top: checktreathead.bottom
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
                            model: treatManagerCheckModel
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
            width: 215
            height:checkreatcase1.height-checktreathead.height
            anchors.left: middlecaselist.right
            anchors.leftMargin: 0
            anchors.top: checktreathead.bottom
//            anchors.topMargin: 0
            color: "#dddddd"

            Button{
                id:savecasebutton
                width: 161
                height: 45

                x:28
                y:550
                background: Rectangle{
                    width: savecasebutton.width
                    height: savecasebutton.height
                    color:"transparent"
                    Image {
                        id: savecasebuttonimg
                        width: savecasebutton.width
                        height: savecasebutton.height
                        source: savecasebutton.hovered?imgaeshprefix+"images/ys-tianjiazhihuanzhe-fz.png":imgaeshprefix+"images/ys-tianjiazhihuanzhe.png"
                    }
                }


                onClicked:{
                    if (treatManagerCheckModel.rowCount()>0){

                    }
                    treatmanagerCheck.visible=false
                }
            }
            Button{
                id:cancelcasebutton
                width: 161
                height: 45
                x:28
                y:savecasebutton.y+savecasebutton.height+34
                background: Rectangle{
                    width:cancelcasebutton.width
                    height: cancelcasebutton.height
                    color: "transparent"
                    Image{
                        id:cancelcasebuttonimg
                        width:cancelcasebutton.width
                        height: cancelcasebutton.height
                        source: cancelcasebutton.hovered?imgaeshprefix+"images/ys-fanhui-fz.png":imgaeshprefix+"images/ys-fanhui.png"
                    }
                }

                onClicked:{
                    treatmanagerCheck.visible=false;
                }
            }
        }


    }



}
