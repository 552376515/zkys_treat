import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Item {

    id:deviceheadManager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property int  rateWidth: 380
    property int rateHeight: 30
    Text {
        id: brakeset
        x:33
        y:43
        text: qsTr("震动设置")
        color: "#007393"
        font.pixelSize: 18
        font.bold: true
    }
    Row{
        id:brakerate
        width: rateWidth
        height: rateHeight
        anchors.top: brakeset.bottom
        anchors.topMargin: 10
        x:80
        Text {
            id: brakeratelbl
            text: qsTr("震动频率")
            width: 80
            height: brakerate.height
            font.pixelSize: 18
            color: "#333333"
        }
        TextField{
            id:brakerateinput
            width: 240
            height: brakerate.height
            placeholderText: qsTr("请输入")
            focus: true
            echoMode: TextInput.Normal
            font.pixelSize: 16
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
            id: brakerateinputdanwei
            text: qsTr("Hz")
        }
        CusSwitch{
            id:switch1
            backgroundColor_on:"blue"
            backgroundColor_on_disable:"#f2f2f2"
            width:48
            height:26
        }

    }
    Text {
        id: heatset
        x:33
        y:43
        anchors.top: brakerate.bottom
        anchors.topMargin: 45
        text: qsTr("加热设置：")
        color: "#007393"
        font.pixelSize: 18
        font.bold: true
    }
    Row{
        id:heatsetrow
        width: rateWidth
        height: rateHeight
        anchors.top: heatset.bottom
        anchors.topMargin: 10
        x:80
        Text {
            id: heatsetlbl
            text: qsTr("震动频率")
            width: 80
            height: heatsetrow.height
            font.pixelSize: 18
            color: "#333333"
        }
        TextField{
            id:heatsetinput
            width: 240
            height: heatsetrow.height
            placeholderText: qsTr("请输入")
            focus: true
            echoMode: TextInput.Normal
            font.pixelSize: 16
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
            id: heatsetinputdanwei
            text: qsTr("C")
        }
        CusSwitch{
            id:switch2
            backgroundColor_on:"blue"
            backgroundColor_on_disable:"#f2f2f2"
            width:48
            height:26
        }

    }
    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: heatsetrow.height+heatsetrow.y // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel1
            z: 99
            //更改x,y即可更改键盘位置
            x: deviceheadManager.x
            y: 200

            //更改width即可更改键盘大小
            width: deviceheadManager.width
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
