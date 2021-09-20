import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Item {
    id:gldeviceparamset
    width: parent.width
    height: parent.height
    anchors.fill: parent
    Rectangle{
        id:gldeviceparamsetRect
        x:38
        y:39
        width: gldeviceparamset.width-gldeviceparamsetRect.x*2
        height: gldeviceparamset.height-gldeviceparamsetRect.y
        Rectangle{
            id:gldeviceparamsethead
            width: gldeviceparamsetRect.width
            height: 63
            Image {
                id: gldeviceparamsetimg
                source:imgaeshprefix+ "images/ys-liebiao-bj"
                width: gldeviceparamsethead.width
                height: gldeviceparamsethead.height
            }
            Text{
                id:gldeviceparamsetheadname
                width: 90
                height: gldeviceparamsethead.height
                x:32
                verticalAlignment: Text.AlignVCenter
                text: qsTr("主要参数设置")
                color: "#0F7E8B"
                font.pixelSize: 19
            }
        }
        Text {
            id: gldeviceparamsetlbl1
            text: qsTr("调理头设置:")
            x:32
            anchors.top: gldeviceparamsethead.bottom
            anchors.topMargin: 42
            color: "#007393"
            font.pixelSize: 18
        }
        Row{
            id:row1
            width: 210
            height: 27
            x:80
            anchors.top: gldeviceparamsetlbl1.bottom
            anchors.topMargin: 35
            Text{
                id:gldevicesetpinlvlbl
                text: qsTr("震动频率：")
                width:80
                height: row1.height
                color: "#000000"
                font.pixelSize: 16
            }

            TextField{
                id:gldevicesetInputpinlv
                width: 100
                height: row1.height
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
            Text {
                id: gldevicesetpinlvright
                text: qsTr("Hz")
                color: "#000000"
                font.pixelSize: 16
                width: 30
            }
        }

        Row{
            id:row2
            width: 210
            height: 27
            x:80
            anchors.top: row1.bottom
            anchors.topMargin: 35
            Text{
                id:gldevicesetwendu
                text: qsTr("加热温度： ")
                width: 80
                height: row2.height
                color: "#000000"
                font.pixelSize: 16

            }

            TextField{
                id:gldevicesetInputwendu
                width: 100
                height: 27
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

            Text {
                id: gldevicesetInputwenduright
                text: qsTr("℃")
                width: 30
                height: row2.height
                color: "#000000"
                font.pixelSize: 16
            }

        }

        Text {
            id: gldevicesetsoundlbl
            text: qsTr("声音设置：")
            x:32
            anchors.top: row2.bottom
            anchors.topMargin: 35
            color: "#007393"
            font.pixelSize: 18
        }
        Row{
            id:row3
            width: 210
            height: 27
            x:80
            anchors.top: gldevicesetsoundlbl.bottom
            anchors.topMargin: 35
            Text{
                id:gldevicesetsoundlbl1
                text: qsTr("语音音量：")
                width:80
                height: row3.height
                color: "#000000"
                font.pixelSize: 16
            }

            TextField{
                id:gldevicesetInputsound
                width: 100
                height: row3.height
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
            Text {
                id: gldevicesetInputsoundright
                text: qsTr("%")
                color: "#000000"
                font.pixelSize: 16
                width: 30
            }
        }

        Text {
            id: gldevicesetexitlbl
            text: qsTr("自动退出设置:")
            x:32
            anchors.top: row3.bottom
            anchors.topMargin: 35
            color: "#007393"
            font.pixelSize: 18
        }
        Row{
            id:row4
            width: 255+700
            height: 27
            x:80
            anchors.top: gldevicesetexitlbl.bottom
            anchors.topMargin: 35
            Text{
                id:gldevicesetexitlbl1
                text: qsTr("自动终止调理：")
                width:110
                height: row4.height
                color: "#000000"
                font.pixelSize: 16
            }

            TextField{
                id:gldevicesetexitlblInputStop
                width: 100
                height: row4.height
                placeholderText: qsTr("请输入")
                text: qsTr("10")
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
                id: gldevicesetexitlblInputStopright
                text: qsTr("分钟")
                color: "#000000"
                font.pixelSize: 16
                width: 40
                height: row4.height
            }
            Text{
                id:gldevicesetexit
                text: qsTr("【调理界面】超过设置时间仍无人操作，则终止调理并退出至【患者管理】页面。（排除机械臂正在调理时的情况）")
                font.pixelSize: 14
                color: "#CA2C2C"

            }
        }


        Row{
            id:row5
            width: 255+700
            height: 27
            x:80
            anchors.top: row4.bottom
            anchors.topMargin: 35
            Text{
                id:gldevicesetexitloginlbl1
                text: qsTr("自动退出登录:")
                width:110
                height: row5.height
                color: "#000000"
                font.pixelSize: 16
            }

            TextField{
                id:gldevicesetexitloginInput
                width: 100
                height: row5.height
                placeholderText: qsTr("请输入")
                text: qsTr("10")
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
                id: gldevicesetexitloginright
                text: qsTr("分钟")
                color: "#000000"
                font.pixelSize: 16
                width: 40
                height: row5.height
            }
            Text{
                id:gldevicesetexitlogin
                text: qsTr("超过设置时间无人操作，则自动退出登录）")
                font.pixelSize: 14
                color: "#CA2C2C"

            }
        }


    }

}
