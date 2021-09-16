import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1

Item {
    id:devicebedmanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property int deviceWidth: 400
    property int deviceHeight: 30

    Rectangle{
        id:devicebedinputArea
        width:700
        height: 240
        x:54
        y:50
        Row{
            id:deviceinputRect1
            width: devicebedinputArea.width
            height: deviceHeight
            Text {
                id: positionpick
                width: 80
                height:deviceinputRect1.height
                text: qsTr("位置选择：")
                font.pixelSize: 16
                color: "#000000"
            }
            TextField{
                id:positioninput
                width: 300
                height: deviceinputRect1.height
                placeholderText: qsTr("请输入位置")
                focus: true
                echoMode: TextInput.Normal
                font.pixelSize: 14
               // anchors.left: addLeftHeadname.right
               // anchors.leftMargin: 20
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
                id:devicebedspace1
                width: 20
                height: deviceinputRect1.height
            }
            Text {
                id: currentposition
                text: qsTr(" 当前位置")
                width: 80
                height:deviceinputRect1.height
                font.pixelSize: 16
                color: "#000000"
            }
            TextField{
                id:currpositioninput
                width: 200
                height: deviceinputRect1.height
                placeholderText: qsTr("请输入当前位置")
                focus: true
                echoMode: TextInput.Normal
                font.pixelSize: 14
               // anchors.left: addLeftHeadname.right
               // anchors.leftMargin: 20
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
            id:devicespeed1
            width: deviceWidth
            height: deviceHeight
            anchors.top: deviceinputRect1.bottom
            anchors.topMargin: 10
            Text {
                id: devicespeed1lbl
                text: qsTr("高速移动速度")
                width: 100
                height: devicespeed1.height
                font.pixelSize: 16
                color: "#000000"
            }
            TextField{
                id:devicespeed1input
                width: 200
                height: deviceinputRect1.height
                placeholderText: qsTr("请输入")
                focus: true
                echoMode: TextInput.Normal
                font.pixelSize: 14
               // anchors.left: addLeftHeadname.right
               // anchors.leftMargin: 20
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
                id: devicespeed1danwei
                text: qsTr("m/s")
                width: deviceHeight
                height: devicespeed1.height
                font.pixelSize: 16
                color: "#000000"
            }

        }
        Row{
            id:devicespeed2
            width: deviceWidth
            height: deviceHeight
            anchors.top: devicespeed1.bottom
            anchors.topMargin: 10
            Text {
                id: devicespeed2lbl
                text: qsTr("低速移动速度")
                width: 100
                height: devicespeed2.height
                font.pixelSize: 16
                color: "#000000"
            }
            TextField{
                id:devicespeed2input
                width: 200
                height: devicespeed2.height
                placeholderText: qsTr("请输入")
                focus: true
                echoMode: TextInput.Normal
                font.pixelSize: 14
               // anchors.left: addLeftHeadname.right
               // anchors.leftMargin: 20
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
                id: devicespeed2danwei
                text: qsTr("m/s")
                width: deviceHeight
                height: devicespeed1.height
                font.pixelSize: 16
                color: "#000000"
            }

        }

        Row{
            id:devicespeed3
            width: deviceWidth
            height: deviceHeight
            anchors.top: devicespeed2.bottom
            anchors.topMargin: 10
            Text {
                id: devicespeed3lbl
                text: qsTr("启停移动速度")
                width: 100
                height: devicespeed2.height
                font.pixelSize: 16
                color: "#000000"
            }
            TextField{
                id:devicespeed3input
                width: 200
                height: devicespeed3.height
                placeholderText: qsTr("请输入")
                focus: true
                echoMode: TextInput.Normal
                font.pixelSize: 14
               // anchors.left: addLeftHeadname.right
               // anchors.leftMargin: 20
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
                id: devicespeed3danwei
                text: qsTr("m/s")
                width: deviceHeight
                height: devicespeed3.height
                font.pixelSize: 16
                color: "#000000"
            }

        }

        Row{
            id:devicespeed4
            width: deviceWidth
            height: 30
            anchors.top: devicespeed3.bottom
            anchors.topMargin: 10
            Text {
                id: devicespeed4lbl
                text: qsTr("加速度")
                width: 100
                height: devicespeed4.height
                font.pixelSize: 16
                color: "#000000"
            }
            TextField{
                id:devicespeed4input
                width: 200
                height: devicespeed4.height
                placeholderText: qsTr("请输入")
                focus: true
                echoMode: TextInput.Normal
                font.pixelSize: 14
               // anchors.left: addLeftHeadname.right
               // anchors.leftMargin: 20
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
                id: devicespeed4danwei
                text: qsTr("m/s")
                width: 30
                height: devicespeed3.height
                font.pixelSize: 16
                color: "#000000"
            }

        }
    }
    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: devicebedinputArea.height // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel1
            z: 99
            //更改x,y即可更改键盘位置
            x: devicebedinputArea.x
            y: 200

            //更改width即可更改键盘大小
            width: devicebedinputArea.width
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
