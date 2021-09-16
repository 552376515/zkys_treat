import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Rectangle {
    id:patientdata
    width: parent
    height: parent
    anchors.fill: patientdatacheck
    color: Qt.rgba(0/255,0/255,0/255,1)
    opacity: 0.8
    Rectangle{
        id:patientdata1
        x:(patientdatacheck.width-890)/2.0//(Screen.desktopAvailableWidth-890)/2.0
        y:(patientdatacheck.height-730)/2.0+40
        width: 890
        height: 730
       // radius: 20
        border.color: "blue"
        border.width: 1
        color: "white"
        opacity: 1
        Rectangle{
            id:patientdatahead
            width: patientdata1.width
            height: 58
            opacity:1
            color: "#003b42"
            Row{
                Rectangle{
                    id:casedataSpace1
                    width: 20
                    height: patientdatahead.height
                    color: "transparent"
                }

                Text {
                    id: patientdataname
                    width:800
                    height: patientdatahead.height
                    text: qsTr("患者")
                    color: "white"
                    font.pixelSize: 20 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                CusButton_Image{
                    id:patientdataheadButton

                    width: 30
                    height: 30
                    y:(patientdatahead.height-patientdataheadButton.height)/2.0
                    //text: "退出"
                    btnImgUrl:imgaeshprefix+"images/ys-guanbi.png"
                    btnImgHovered:imgaeshprefix+"images/sy-guanbi-fz.png"
                    //font.pointSize:20
                    onClicked: {
                        patientdatacheck.visible=false
                    }
                }
            }

        }
        Rectangle{
            id:patientdatalist
            width: patientdata1.width
            height: patientdata1.height-patientdatahead.height
            anchors.top: patientdatahead.bottom
            anchors.topMargin: 0
            color: "white"
            opacity: 1
            Column{
                id:casedataListColumn
                Text {
                    id: patientdatalisthead
                    x:50
                    width: (patientdatalist.width-100)/2.0
                    height: 76
                    text:"病情资料"
                    color: "#EF6001"
                    font.pixelSize: 24 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                TextField{
                    id:patientdataedit
                    width: patientdatalist.width-100
                    height: 180
                    x:50

                    placeholderText: "点击输入"

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
                    id:casedataSpace2
                    width: patientdata1.width
                    height: 15
                    color: "transparent"
                }

                CusButton_Image{
                    id:savedatabutton
                    x:55
                    width: 161
                    height: 45
                    btnImgUrl:imgaeshprefix+"images/ys-baocun.png"
                    btnImgHovered:imgaeshprefix+"images/ys-baocun-fz.png"

                   // text: "保存"

                    onClicked: {
                        casedatalistModel.addData("1111@"+patientdataedit.text+"@王医生@"+getCurDate().toString())

                    }
                }
            }
            Rectangle{
                id:realdatalist
                x:50
                width: patientdatalist.width-realdatalist.x*2
                height: patientdatalist.height-76-180-45-15-10
                anchors.top: casedataListColumn.bottom
                anchors.topMargin: 10
                color: "transparent"
                ListView {
                        anchors.fill: realdatalist;
                        model: casedatalistModel;
                        delegate: casedatadelegate_list
                        spacing: 10;
                    }
                    //委托
                    Component {
                        id: casedatadelegate_list;
                        Rectangle {
                            id: realdatalistrect;
                            width: realdatalist.width;
                            height: para_doct.contentHeight+para_script_content.contentHeight+30
                            color: "#e4e4e4"

                            Text {
                                id:para_doct;
                                text: paraDoctor;
                                font.pixelSize: 16
                                x:20
                                y:10
                                color: "#333333";
                                horizontalAlignment: Text.AlignLeft;
                            }
                            Rectangle {
                                id:listspaceRect1
                                width: 20;
                                height: 1;

                                color: "transparent";
                                anchors.left: para_doct.right
                                anchors.leftMargin: 20
                            }
                            Text{
                                id:para_time
                                text: paraTime
                                y:10
                                font.pixelSize: 16
                                color: "#333333"
                                anchors.left: listspaceRect1.right
                                anchors.leftMargin: 20
                                horizontalAlignment: Text.AlignLeft;
                            }


                            Text {
                                id: para_script_content
                                text: paraScript
                                font.pixelSize: 17;
                                anchors.top: para_doct.bottom
                                anchors.topMargin: 10
                                x:20
                                color: "#333333";
                                horizontalAlignment: Text.AlignLeft;
                            }
                        }
                    }
            }
        }

    }

    function getCurDate()
           {
                var d = new Date();
                var week;

                var years = d.getFullYear();
                var month = add_zero(d.getMonth()+1);
                var days = add_zero(d.getDate());
                var hours = add_zero(d.getHours());
                var minutes = add_zero(d.getMinutes());
                var seconds=add_zero(d.getSeconds());
                var ndate = years+"-"+month+"-"+days+" "+hours+":"+minutes+":"+seconds;
                return ndate;
           }
    function add_zero(temp)
            {
                 if(temp<10) return "0"+temp;
                 else return temp;
            }

    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: login.height // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel1
            z: 99
            //更改x,y即可更改键盘位置
            x: realdatalist.x
            y: realdatalist.y
            //更改width即可更改键盘大小
            width: realdatalist.width - 100
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


}
