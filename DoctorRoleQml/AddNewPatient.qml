import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import TaoQuick 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1
Rectangle {
    id:addnew
    width: parent
    height: parent
    anchors.fill: addnewpt
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

    Rectangle{
        id:addrect1
        x:490
        y:250
        width: 535
        height: 395
        //radius: 20
        border.color: "blue"
        border.width: 1
        color: "white"
        opacity: 1



        Rectangle{
            id:addrecthead
            width: 535
            height: 50
            color:"#00c2d5"
            Image {
                id: addLeftImage
                x:21
                y:(addrecthead.height-21)/2.0
                width: 21
                height: 21
                source: imgaeshprefix+"images/ys-tianjia.png"
            }

            Text {
                id: addnew1
                anchors.left: addLeftImage.right
                anchors.leftMargin: 8
                height: addrecthead.height
                text: qsTr("新增患者")
                color: "white"
                font.pixelSize: 16 		//字体像素大小，缺省为12
                font.bold: true  		//字体是否加粗，缺省为false
                font.underline: false 	//字体是否有下划线，缺省为false
                verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
            }

            CusButton_Image{
                id:addcaseQuitBtn
                width: 30
                height:30

                y:10
                anchors.right: addrecthead.right
                anchors.rightMargin: 14
                //text: "退出"
                btnImgNormal:imgaeshprefix+"images/ys-guanbi.png"
                btnImgHovered:imgaeshprefix+"images/sy-guanbi-fz.png"
                onClicked: {
                      addnewpt.visible=false;;
                }
            }
        }
        Rectangle{
            id:addnewRect
            y:addrecthead.height
            width: 535
            height: addrect1.height- addrecthead.height
            Row{
                id:addInput1
                x:110
                y:30
                width: 300
                height: 35
                Text {
                    id: leftAddIcon
                    x:0
                    y:0
                    width: 24
                    height: 35

                    text: qsTr("*")
                    color: "red"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                Text {
                    id: addIndexleft
                    width: 70
                    height: 35
                    text: qsTr("姓 名：")
                    color: "#333333"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                TextField{
                    id:pinputname
                    width: 204
                    height:35
                    placeholderText: "点击输入"
                    echoMode: TextInput.Normal
                    onAccepted: {
                        color:"#999999"
                    }
                    // 当选择输入框的时候才显示键盘
                    onPressed: {
                               inputX = x+addrect1.x
                               inputY = y + height
                               inputPanel1.visible = true
                    }
                }
            }
            Row{
                id:addinput2
                x:110
                y:addInput1.y+addInput1.height+24

                width: 300
                height: 35
                Text {
                    id: leftAddIcon1
                    x:0
                    y:0
                    width: 24
                    height: 35
                    text: qsTr("*")
                    color: "red"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                Text {
                    id: addIndexleft1
                    x:24
                    width: 70
                    height: 35
                    text: qsTr("性 别：")
                    color: "#333333"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                //定义的互斥分组
                    ExclusiveGroup{

                        id: mos;
                    }

                    RadioButton {
                            id: sexman;
                            text: "男"
                            width: 60
                            height: 35
                             font.pixelSize: 15
                            autoExclusive: mos
                      //      anchors.left: addIndexleft1.right
                      //      anchors.leftMargin: 20

                            checked: true;
                            focus: true;
                            activeFocusOnTab: true;
                           // style: radioStyle;
                            onClicked: {
                            }
                        }
                        RadioButton {
                            id: sexwoman
                            text: "女";
                            font.pixelSize: 15
                            width: 60
                            height: 35
                            autoExclusive: mos;
                      //      anchors.left:  sexman.right;
                      //      anchors.leftMargin: 20;
                            activeFocusOnTab: true;

                           // RadioButtonStyle: radioStyle;
                            onClicked: {
                            }
                        }
            }
            Row{
                x:110
                id:addinput3
                y:addinput2.y+addinput2.height+24
                width: 300
                height: 35
                Text {
                    id: leftAddIcon2
                    x:0
                    y:0
                    width: 24
                    height: 35
                    text: qsTr(" ")
                    color: "white"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                Text {
                    id: addIndexleft2
                    x:24
                    width: 70
                    height: 35
                    text: qsTr("年 龄：")
                    color: "#333333"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                TextField{
                    id:pinputage
                    width: 204
                    height: 35
                    font.pixelSize: 15
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
            }
            Row{
                id:addinput4
                x:110
                y:addinput3.y+addinput3.height+24
                width: 300
                height: 50
                Text {
                    id: leftAddIcon3
                    x:0
                    y:0
                    width: 24
                    height: 35
                    text: qsTr(" ")
                    color: "white"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                Text {
                    id: addIndexleft3
                    x:24
                    width: 70
                    height: 35
                    text: qsTr("电 话：")
                    color: "#333333"
                    font.pixelSize: 15 		//字体像素大小，缺省为12
                    font.bold: true  		//字体是否加粗，缺省为false
                    font.underline: false 	//字体是否有下划线，缺省为false
                    verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                    horizontalAlignment: Text.AlignLeft 	//水平居中，控件必须有width才可以使用
                }
                TextField{
                    id:pinputphone
                    width: 204
                    height: 35
                    font.pixelSize: 15
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
            }

            Button{
                id:addQuxiao
                x:72
                width: 155
                height:39
                anchors.top: addinput4.bottom
                anchors.topMargin: 10
                //text: "退出"
                background: Rectangle{
                    width: addQuxiao.width
                    height: addQuxiao.height
                    color: "transparent"
                    Image {
                        id: addQuxiaoimg
                        width: addQuxiao.width
                        height: addQuxiao.height
                        source: addQuxiao.hovered?imgaeshprefix+"images/ys-xingzeng-qvxiao-fz.png":imgaeshprefix+"images/ys-xingzeng-qvxiao.png"
                    }
                }

                onClicked: {
                      addnewpt.visible=false;

                }
            }
            Button{
                id:addBaocun
                width: addQuxiao.width
                height:addQuxiao.height
                anchors.left:addQuxiao.right
                anchors.leftMargin: 70
                anchors.top: addinput4.bottom
                anchors.topMargin: 10
                background: Rectangle{
                    width: addBaocun.width
                    height: addBaocun.height
                    color: "transparent"
                    Image {
                        id: addBaocunimg
                        width: addBaocun.width
                        height: addBaocun.height
                        source: addBaocun.hovered?imgaeshprefix+"images/ys-xingzeng-baocun-fz.png":imgaeshprefix+"images/ys-xingzeng-baocun.png"
                    }
                }
                //text: "退出"
              //  btnImgNormal:imgaeshprefix+"images/ys-xingzeng-baocun.png"
              //  btnImgHovered:imgaeshprefix+"images/ys-xingzeng-baocun-fz.png"
                onClicked: {
                      addnewpt.visible=false;;
                    if (pinputname.text.length >0 ){
                        var sex=""
                        if (sexman.checked){
                            sex="男"
                        }
                        if (sexwoman.checked){
                            sex="女"
                        }
                        var age=""
                        if (pinputage.text.length>0){
                            age=pinputage.text
                        }
                        var phone=""
                        if (pinputphone.text.length>0){
                            phone=pinputphone.text
                        }
                        deviceAddModel.addOne(pinputname.text+"@"+sex+"@"+age+"@"+phone+"@"+doctorloginname)

                    }
                }
            }

        }
    }


    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: addrect1.height // 键盘y坐标(动态)

        // 嵌入式虚拟键盘
    InputPanel {
            id: inputPanel1
            z: 99
            //更改x,y即可更改键盘位置
            x: addrect1.x
            y: addrect1.height+addrect1.y
            //更改width即可更改键盘大小
            width: addrect1.width
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

