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
                        treatmanagerment.visible=true;
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

    }



}
