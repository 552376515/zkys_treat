import QtQuick 2.0

import TaoQuick 1.0
import QtQuick.Controls 2.5
Rectangle {
    id:devicemanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property int deviceSelectedIndex: 0
    color:"#F2F2F2"
    Rectangle{
        id:devicemanagerrect
        y:30
        x:30
        width: devicemanager.width-devicemanagerrect.x*2
        height: 40
        color: "transparent"
        Row{
            id:devicemanagerheaderleft
            width: 126*6+10*5
            height: 40

                    CusTextButton{
                        id:devicemanagerheader1
                        width:126
                        height:devicemanagerheaderleft.height
                        font.pointSize:18
                        text:"机器人运行"
                        textColor:"white"
                        backgroundColorNormal:"#78C8E2"
                        backgroundColorPressed:"#007393"
                        selected:deviceSelectedIndex==0
                        onClicked:{
                            deviceSelectedIndex=0
                        }
                    }
                    Rectangle{
                        id:deviceheaderleftspace1
                        width: 10
                        height: devicemanagerheaderleft.height
                        color: "white"
                    }
                    CusTextButton{
                        id:devicemanagerheader2
                        width:126
                        height:devicemanagerheaderleft.height
                        font.pointSize:18
                        text:"调理床运行"
                        textColor:"white"
                        backgroundColorNormal:"#78C8E2"
                        backgroundColorPressed:"#007393"
                        selected:deviceSelectedIndex==1
                        onClicked:{
                            deviceSelectedIndex=1
                        }
                    }
                    Rectangle{
                        id:deviceheaderleftspace2
                        width: 10
                        height: devicemanagerheaderleft.height
                        color: "white"
                    }
                    CusTextButton{
                        id:devicemanagerheader3
                        width:126
                        height:devicemanagerheaderleft.height
                        font.pointSize:18
                        text:"标定管理"
                        textColor:"white"
                        backgroundColorNormal:"#78C8E2"
                        backgroundColorPressed:"#007393"
                        selected:deviceSelectedIndex==2
                        onClicked:{
                            deviceSelectedIndex=2
                        }
                    }
                    Rectangle{
                        id:deviceheaderleftspace3
                        width: 10
                        height: devicemanagerheaderleft.height
                        color: "white"
                    }
                    CusTextButton{
                        id:devicemanagerheader4
                        width:126
                        height:devicemanagerheaderleft.height
                        font.pointSize:18
                        text:"相机管理"
                        textColor:"white"
                        backgroundColorNormal:"#78C8E2"
                        backgroundColorPressed:"#007393"
                        selected:deviceSelectedIndex==3
                        onClicked:{
                            deviceSelectedIndex=3
                        }
                    }
                    Rectangle{
                        id:deviceheaderleftspace4
                        width: 10
                        height: devicemanagerheaderleft.height
                        color: "white"
                    }
                    CusTextButton{
                        id:devicemanagerheader5
                        width:126
                        height:devicemanagerheaderleft.height
                        font.pointSize:18
                        text:"调理头设置"
                        textColor:"white"
                        backgroundColorNormal:"#78C8E2"
                        backgroundColorPressed:"#007393"
                        selected:deviceSelectedIndex==4
                        onClicked:{
                            deviceSelectedIndex=4
                        }
                    }
                    Rectangle{
                        id:deviceheaderleftspace5
                        width: 10
                        height: devicemanagerheaderleft.height
                        color: "white"
                    }
                    CusTextButton{
                        id:devicemanagerheader6
                        width:126
                        height:devicemanagerheaderleft.height
                        font.pointSize:18
                        text:"声光管理"
                        textColor:"white"
                        backgroundColorNormal:"#78C8E2"
                        backgroundColorPressed:"#007393"
                        selected:deviceSelectedIndex==5
                        onClicked:{
                            deviceSelectedIndex=5
                        }
                    }
                    Rectangle{
                        id:deviceheaderleftspace6
                        width: 10
                        height: devicemanagerheaderleft.height
                        color: "white"
                    }
        } //row
        Button{
            id:deviceheaderyjqd
            width:96
            y:2
            x:devicemanagerrect.width-20-deviceheaderyjqd.width
            height:36
            background: Rectangle{
                width: deviceheaderyjqd.width
                height: deviceheaderyjqd.height
                color: "transparent"
                Image {
                    id: deviceheaderyjqdimg
                    width: deviceheaderyjqd.width
                    height: deviceheaderyjqd.height
                    source: deviceheaderyjqd.hovered?imgaeshprefix+"images/gl-sb-yijianqidong-fz.png":imgaeshprefix+"images/gl-sb-yijianqidong.png"
                }
            }
            onClicked:{

            }
        }

    }

    Rectangle{
        id:robotmanagerdisp
        width: devicemanagerrect.width-30*2
        x:30
        anchors.top: devicemanagerrect.bottom
        anchors.topMargin: 0
        height: devicemanager.height-devicemanagerrect.y-devicemanagerrect.height-30
        visible: deviceSelectedIndex==0
        RobotManger{
            id:robotman
            width: robotmanagerdisp.width
            height: robotmanagerdisp.height
        }
    }

    Rectangle{
        id:robotbemanagerdisp
        width: devicemanagerrect.width-30*2
        x:30
        anchors.top: devicemanagerrect.bottom
        anchors.topMargin: 0
        height: devicemanager.height-devicemanagerrect.y-devicemanagerrect.height-30
        visible: deviceSelectedIndex==1
        DeviceBedManager{
            id:robotbed
            width: robotmanagerdisp.width
            height: robotmanagerdisp.height
        }
    }

    Rectangle{
        id:robotbiaodingdisp
        width: devicemanagerrect.width-30*2
        x:30
        anchors.top: devicemanagerrect.bottom
        anchors.topMargin: 0
        height: devicemanager.height-devicemanagerrect.y-devicemanagerrect.height-30
        visible: deviceSelectedIndex==2
        DeviceBiaoDingManager{
            id:robotbiaoding
            width: robotmanagerdisp.width
            height: robotmanagerdisp.height
        }
    }
    Rectangle{
        id:robotcameradisp
        width: devicemanagerrect.width-30*2
        x:30
        anchors.top: devicemanagerrect.bottom
        anchors.topMargin: 0
        height: devicemanager.height-devicemanagerrect.y-devicemanagerrect.height-30
        visible: deviceSelectedIndex==3
        DeviceCameraManager{
            id:robotcamera
            width: robotmanagerdisp.width
            height: robotmanagerdisp.height
        }
    }
    Rectangle{
        id:robothead
        width: devicemanagerrect.width-30*2
        x:30
        anchors.top: devicemanagerrect.bottom
        anchors.topMargin: 0
        height: devicemanager.height-devicemanagerrect.y-devicemanagerrect.height-30
        visible: deviceSelectedIndex==4
        DeviceHeadManager{
            id:robotdevicehead
            width: robotmanagerdisp.width
            height: robotmanagerdisp.height
        }
    }

    Rectangle{
        id:robotsound
        width: devicemanagerrect.width-30*2
        x:30
        anchors.top: devicemanagerrect.bottom
        anchors.topMargin: 0
        height: devicemanager.height-devicemanagerrect.y-devicemanagerrect.height-30
        visible: deviceSelectedIndex==5
        DeviceSoundManager{
            id:robotdevicesond
            width: robotsound.width
            height: robotsound.height
        }

    }

}
