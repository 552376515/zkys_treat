import QtQuick 2.0
import QtQuick.Controls 2.5
import TaoQuick 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Item {
    id:patientManager1
    width: parent.width
    height: parent.height
    anchors.fill: parent



    Rectangle{
        id:patientlist
        x:38
        y:114
        width: 511
        height: 742
        radius: 10
        border.color: "#ededed"
        border.width: 1
        PatientManageTable{
            id:patientList1
            width: patientlist.width
            height: patientlist.height
        }

    }

    Rectangle{
        id:caseList
        x:patientlist.x+patientlist.width+20
        y:patientlist.y
        height: patientlist.height
        width:984
        radius: 10
        PatientCaseTable{
            id:caseList1
            width: caseList.width
            height: caseList.height
        }
    }

    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: 200 // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel
            z: 99
            //更改x,y即可更改键盘位置
            x: 100
            y:300
            //更改width即可更改键盘大小
            width: 1000
            visible: false

            externalLanguageSwitchEnabled: false

            states: State {
                name: "visible"
                when: inputPanel.active
                PropertyChanges {
                    target: inputPanel
                    // 将键盘顶部放在屏幕底部会使其隐藏起来
                    x: 100
                    y: 300
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
