import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
import TaoQuick 1.0
Item {
    id:loginid
    width: login.width
    height: login.height
    anchors.fill: parent
    Image {
        id: backimage
        width: loginid.width
        height:loginid.height
        source: imgaeshprefix+"firstlogin.png"
    }

    Rectangle{
        id:logindispimg
        width: 1027
        height: 148
        x:(loginid.width-logindispimg.width)/2.0
        y:190
        color: "transparent"
        Image {

            id: logindispcompamy
            width: logindispimg.width
            height:logindispimg.height
            source: imgaeshprefix+"images/xitong.png"
        }
    }
    Rectangle{
        id:logindisprespect
        width: 588
        height: 18
        anchors.top: logindispimg.bottom
        anchors.topMargin: 64
        x:(loginid.width-logindisprespect.width)/2.0
        color: "transparent"
        Text {
            id: name
            width: logindisprespect.width
            height: logindisprespect.height
            text: qsTr("——尊敬的用户：欢迎使用中科尚易中医经络调理机器人——")
            font.pixelSize: 18
            color: "white"
        }
    }


             Rectangle{
                 id: rect2
                 width: 688
                 height: 178

                 x:(loginid.width-rect2.width)/2.0
                 anchors.top: logindisprespect.bottom
                 anchors.topMargin: 42
                 color: "#E9E9E9"
                 radius: 10
                 Rectangle{
                     id:loginname
                     width: 62+240
                     x:100
                     y:40
                     height: 42
                     color: "transparent"
                     Text{
                         id:namelbl
                         width: 62
                         height: loginname.height-20
                         y:10
                         text: qsTr("用户名")
                         color: "#333333"
                         font.pixelSize: 18

                     }

                     Rectangle{
                         id:inputrect1
                         width: 240
                         height: loginname.height
                         color: "white"
                         anchors.left: namelbl.right
                         anchors.leftMargin: 0
                         TextField{
                             id:nameInput
                             width: inputrect1.width
                             height: inputrect1.height

                             font.pointSize: 15
                             focus: true
                             placeholderText:qsTr("请输入名字")
                             echoMode: TextInput.Normal
                             onAccepted: {
                             color:"#999999"
                             }
                             // 当选择输入框的时候才显示键盘
                             onPressed: {
                                        inputX = x
                                        inputY = y + height
                                        inputPanel.visible = true
                             }
                         }
                     }


                 }
                 Rectangle{
                     id:loginpwd
                     width: 62+240
                     x:100
                     anchors.top: loginname.bottom
                     anchors.topMargin: 17
                     height: 42
                     color: "transparent"
                     Text{
                         id:pwdlbl
                         width: 62
                         height: loginpwd.height-20
                         y:10
                         text: qsTr("密  码")
                         color: "#333333"
                         font.pixelSize: 18
                     }

                     Rectangle{
                         id:inputpwdrect1
                         width: 240
                         height: loginpwd.height
                         color: "white"
                         anchors.left: pwdlbl.right
                         anchors.leftMargin: 0

                         TextField{
                             id:pwdInput
                             width: inputrect1.width
                             height: inputrect1.height
                             font.pointSize: 15
                             focus: true
                             placeholderText:qsTr("请输入密码")
                             echoMode: TextInput.Password
                             onAccepted: {
                             color:"#999999"
                             }
                             // 当选择输入框的时候才显示键盘
                             onPressed: {
                                        inputX = x
                                        inputY = y + height
                                        inputPanel.visible = true
                             }
                         }
                     }


                 }
                 Rectangle{
                     id: rectButton
                     width: 165
                     height: rect2.height
                     x:rect2.width-rectButton.width
                     color: "transparent"
                     CusButton_Image{
                         width: rectButton.width
                         height: rectButton.height
                         btnImgUrl:imgaeshprefix+"images/denglu.png"
                         btnImgHovered: imgaeshprefix+"images/denglu2.png"
                         font.pointSize:20

                         onClicked:{
                             closeAllView()
                            showIndex=1
                            login.visible=false;
                            loadPatient()
                         }
                     }
                 }

             }

             Text {
                 id: gongsiname
                 text: qsTr("中科尚易中医经络调理机器人    400-0000-0000")
                 color: "white"
                 font.pixelSize: 16
                 x:52
                 y:loginid.height-28-gongsiname.contentHeight
             }

             property int inputX: 0 // 键盘x坐标(动态)
             property int inputY: rect2.height // 键盘y坐标(动态)

                 // 嵌入式虚拟键盘
             InputPanel {
                     id: inputPanel
                     z: 99
                     //更改x,y即可更改键盘位置
                     x: 100
                     y: rect2.height
                     //更改width即可更改键盘大小
                     width: rect2.width+200
                     visible: false

                     externalLanguageSwitchEnabled: false

                     states: State {
                         name: "visible"
                         when: inputPanel.active
                         PropertyChanges {
                             target: inputPanel
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
