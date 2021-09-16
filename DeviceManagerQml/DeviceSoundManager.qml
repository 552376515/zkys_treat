import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Item {
    id:soundmanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    Rectangle{
        id:soundmanager1
        width: soundmanager.width
        height: soundmanager.height
        Row{
            id:soundpower
            width: 260
            height: 30

            x:32
            y:44
            Text {
                id: soundpowerlbl
                text: qsTr("语音音量：")
                width: 80
                height: soundpower.height
                font.pixelSize: 16
                color: "#333333"
            }
            TextField{
                id:soundpowerinput
                width: 144
                height: soundpower.height
                placeholderText: qsTr("请输入")
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

                id: brakerateinputdanwei
                width: 36
                height: soundpower.height
                text: qsTr("%")
                color: "#333333"
                font.pixelSize: 16

            }

        }

    }
    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: soundpower.height+100 // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel1
            z: 99
            //更改x,y即可更改键盘位置
            x: 40
            y: 200

            //更改width即可更改键盘大小
            width: 900
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
