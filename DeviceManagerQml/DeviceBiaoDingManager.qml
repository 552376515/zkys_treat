import QtQuick 2.0
import TaoQuick 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Item {
    id:devicebiaodingmanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property string pickrobotname: "1号机器人"
    property string robotpickleft: "左侧机器人"
    property string pickcameraname: "左侧相机"
    property int deviceindex: 0
    property int cameraindex: 0
    Rectangle{
        id:devicebiaodinginputRect
        width: devicebiaodingmanager.width
        height: 620
        color: "white"
        y:60
        Rectangle{
            id:devicexuanze
            width: 700
            height: 300
            Row{
                id:camerapick
                x:54
                width: devicexuanze.width-54
                height: 30

                Text{
                    id:camerapicklbl
                    width: 80
                    height:camerapick.height
                    text: qsTr("选择机器人：")
                    font.pixelSize: 16
                    color: "#000000"

                }
//                Rectangle{
//                    id:camerapicklbl1
//                    width: 160
//                    height: camerapick.height
//                    color: "transparent"
//                    border.color: "#6d6d6d"
//                    border.width: 1
//                    Text{
//                        text: qsTr(pickrobotname)
//                        font.pixelSize: 14
//                        color: "#999999"
//                    }
//                }
                CusComboBox {
                    model: ["1号机器人", "2号机器人"]
                    width: 160
                    height: 30
                    displayText: qsTr(currentText)
                }

                Text{
                    id:cameraindexlbl
                    width: 100
                    height: 30
                    text: qsTr("相机index")
                    color: "#000000"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignRight
                }

                CusComboBox {
                    model: ["顶部摄像头", "左侧摄像头", "右侧摄像头"]
                    width: 211
                    height: 30
                    displayText: qsTr(currentText)
                }

            }
            Row{
                id:coordinate
                width: 300
                height: 30
                x:54

                anchors.top: camerapick.bottom
                anchors.topMargin: 10
                Text{
                    width: 135
                    height: coordinate.height
                    text: qsTr("标定板中心坐标：")
                    color: "#000000"
                    font.pixelSize: 16
                }
                TextField{
                    width: 165
                    height: coordinate.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0,0.016")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
            }
            Row{
                id:offsetworkspace
                width: 300
                height: 30
                anchors.top: coordinate.bottom
                anchors.topMargin: 10
                x:54
                Text{
                    width: 135
                    height: offsetworkspace.height
                    text: qsTr("offset workspace：")
                    color: "#000000"
                    font.pixelSize: 16
                }
                TextField{
                    width: 165
                    height: coordinate.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.12")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
            }

            Row{
                id:miny
                width: 160+144+107+144
                height: 30
                x:54
                anchors.top: offsetworkspace.bottom
                anchors.topMargin: 10
                Text{
                    width: 160
                    height: miny.height
                    text: qsTr("min_y=ndi_pose[1]-")
                    color: "#000000"
                    font.pixelSize: 16
                }
                TextField{
                    width: 144
                    height: miny.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.04")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
                    id: max_z
                    width: 107
                    text: qsTr("max_z: ")
                    height: miny.height
                    horizontalAlignment: Text.AlignRight
                }
                TextField{
                    width: 144
                    height: miny.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.25")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
            }
            Row{
                id:maxy
                width: 160+144+107+144
                height: 30
                x:54
                anchors.top: miny.bottom
                anchors.topMargin: 10
                Text{
                    width: 160
                    height: maxy.height
                    text: qsTr("max_y=ndi_pose[1]-")
                    color: "#000000"
                    font.pixelSize: 16
                }
                TextField{
                    width: 144
                    height: maxy.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.04")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
                    id: min_z
                    width: 107
                    text: qsTr("min_z: ")
                    height: maxy.height
                    horizontalAlignment: Text.AlignRight
                }
                TextField{
                    width: 144
                    height: maxy.height
                    placeholderText:qsTr("请输入")
                    text: qsTr("0.04")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
            }
            Row{
                id:xyz
                width: 35+144+80+144+80+144
                height: 30
                anchors.top: maxy.bottom
                anchors.topMargin: 10
                x:54
                Text{
                    width: 35
                    height: xyz.height
                    text: qsTr("I:")
                    color: "#000000"
                    font.pixelSize: 16
                }
                TextField{
                    id:xyz_Iinput
                    width: 144
                    height: xyz.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.05")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
                    id: xyz_v
                    width: 80
                    text: qsTr("V:")
                    height: maxy.height
                    horizontalAlignment: Text.AlignRight
                }
                TextField{
                    id:xyz_vinput
                    width: 144
                    height: maxy.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.05")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
                    id: xyz_a
                    width: 80
                    text: qsTr("a:")
                    height: maxy.height
                    horizontalAlignment: Text.AlignRight
                }
                TextField{
                    id:xyz_ainput
                    width: 144
                    height: maxy.height
                    placeholderText: qsTr("请输入")
                    text: qsTr("0.05")
                    focus: true
                    echoMode: TextInput.Normal
                    font.pixelSize: 14
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
            }

            Rectangle{
                id:devicestart
                width: 135
                height: 49
                anchors.top:xyz.bottom
                anchors.topMargin: 60
                x:(devicebiaodinginputRect.width-devicestart.width)/2.0
                CusButton_Image{
                    id:savecasebutton
                    width: devicestart.width
                    height: devicestart.height

                    btnImgUrl:imgaeshprefix+"images/gl-Start.png"
                    btnImgHovered:imgaeshprefix+"images/gl-Start-fz.png"
                    onClicked:{

                    }
                }
            }


        }

    }
    Rectangle{
        id:biaodingbottom
        width: devicebiaodingmanager.width
        height: 130
        anchors.top: devicebiaodinginputRect.bottom
        anchors.topMargin: 0
        color: "#f2f2f2"

        Rectangle{
            id:inputcameraleftrect
            width: 160
            height: 30
            y:(biaodingbottom.height-inputcameraleftrect.height)/2.0
            x:80
            border.color: "#e7e6e6"
            border.width: 1
            CusComboBox {
                model: ["1号机器人", "2号机器人"]
                width: 160
                height: 30
                displayText: qsTr(currentText)
            }
        }

        CusButton_Image{
            id:forbidprotect
            x:inputcameraleftrect.x+inputcameraleftrect.width+44
            width:197
            height:49
            y:(biaodingbottom.height-forbidprotect.height)/2.0

            btnImgUrl:imgaeshprefix+"images/gl-jiechubaohu.png"
            btnImgHovered:imgaeshprefix+"images/gl-jiechubaohu-fz.png"
            onClicked:{

            }

        }
        CusButton_Image{
            id:freeaction
            x:forbidprotect.x+forbidprotect.width+17
            width:136
            height:49
            y:forbidprotect.y

            btnImgUrl:imgaeshprefix+"images/gl-ziyouqvdong.png"
            btnImgHovered:imgaeshprefix+"images/gl-ziyouqvdong-fz.png"
            onClicked:{

            }

        }
        CusButton_Image{
            id:stopaction
            x:freeaction.x+freeaction.width+17
            width:136
            height:49
            y:forbidprotect.y
            btnImgUrl:imgaeshprefix+"images/gl-tingzhi.png"
            btnImgHovered:imgaeshprefix+"images/gl-tingzhi-fz.png"
            onClicked:{

            }

        }

    }


}
