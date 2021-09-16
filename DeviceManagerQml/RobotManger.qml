import QtQuick 2.0


import TaoQuick 1.0
Item {
    id:robotmanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    Rectangle{
        id:robotmanagerLeft
        width: 924
        height: 413+243+22+22-100
        y:100
        Image {
            id: robotleftimg
            width: 240
            height: 190
            x:140
            source: imgaeshprefix+"images/leftrobot.png"
        }
        Image{
            id:robotrightimg
            width: 246
            height: 190
            anchors.left: robotleftimg.right
            anchors.leftMargin: 120
            source: imgaeshprefix+"images/rightrobot.png"
        }
        Rectangle{
            id:robotmanagerRect
            x:120
            anchors.top: robotleftimg.bottom
            anchors.topMargin: 20
            width: robotmanagerLeft.width-robotmanagerRect.x*2
            height: 400
             color: "transparent"
            GridView{
                id:robotmanagerList
                clip: true
                anchors.fill:robotmanagerRect
                model:ListModel{
                    id:robotactionList
                    ListElement{
                        actionname:"自由驱动"
                        actionid:"1"
                    }
                    ListElement{
                        actionname:"自由驱动"
                        actionid:"2"
                    }
                    ListElement{
                        actionname:"机器人启动"
                        actionid:"3"
                    }
                    ListElement{
                        actionname:"机器人启动"
                        actionid:"4"
                    }
                    ListElement{
                        actionname:"安全位置"
                        actionid:"5"
                    }
                    ListElement{
                        actionname:"安全位置"
                        actionid:"6"
                    }
                    ListElement{
                        actionname:"识别位置"
                        actionid:"7"
                    }
                    ListElement{
                        actionname:"识别位置"
                        actionid:"8"
                    }
                }
                cellWidth: robotmanagerRect.width/2
                cellHeight: 50
                delegate: robotactiondelegate
            }
            Component{
                id:robotactiondelegate
                Rectangle {
                    id: wrapperrobot
                    width: robotmanagerRect.width/2-40
                    height: robotmanagerList.cellHeight-20
                    anchors.centerIn: robotmanagerList.Center
                    color: "transparent"
                    Rectangle{
                        id:leftname
                        width: wrapperrobot.width
                        height:wrapperrobot.height
                        //x:10
                        color: "#f2f2f2"
                        radius: 10
                        Text  {
                            id:landscape_name
                            width: wrapperrobot.width
                            height: wrapperrobot.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 15
                            text: actionname
                            color: "#333333"
                            font.bold: true  		//字体是否加粗，缺省为false
                            verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
                            horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
                        }
                        MouseArea {
                                   anchors.fill: parent
                                   onClicked:{

                                   }
                        }
                    }


                }
            }

        }
     }

     Rectangle{
         id:robotrightRect
         anchors.left: robotmanagerLeft.right
         anchors.leftMargin: 0
         width: 588
         height: 413
         y:22
         color: "#f2f2f2"
         CusButton_Image{
             id:doubleend
             width:156
             height:123
             x:108
             y:57
             btnImgUrl:imgaeshprefix+"images/gl-sb-jiqiren5.png"
             btnImgHovered:imgaeshprefix+"images/gl-sb-jiqiren5-fz.png"
             onClicked:{

             }
         }
         CusButton_Image{
             id:doublepause
             width:156
             height:123
             anchors.left: doubleend.right
             anchors.leftMargin: 60
             y:57
             btnImgUrl:imgaeshprefix+"images/gl-sb-jiqiren6.png"
             btnImgHovered:imgaeshprefix+"images/gl-sb-jiqiren6-fz.png"
             onClicked:{

             }
         }
         CusButton_Image{
             id:doublestart
             width:156
             height:123
             x:108
             anchors.top: doubleend.bottom
             anchors.topMargin: 50
             btnImgUrl:imgaeshprefix+"images/gl-sb-jiqiren7.png"
             btnImgHovered:imgaeshprefix+"images/gl-sb-jiqiren7-fz.png"
             onClicked:{

             }
         }
         CusButton_Image{
             id:alarmreset
             width:156
             height:123
             anchors.left: doublestart.right
             anchors.leftMargin: 60
             anchors.top: doubleend.bottom
             anchors.topMargin: 50
             btnImgUrl:imgaeshprefix+"images/gl-sb-jiqiren8.png"
             btnImgHovered:imgaeshprefix+"images/gl-sb-jiqiren8-fz.png"
             onClicked:{

             }
         }
     }
     Rectangle{
         id:doublestartbottom
         width: robotrightRect.width
         height: 243
         anchors.left: robotmanagerLeft.right
         anchors.leftMargin: 0
         anchors.top: robotrightRect.bottom
         anchors.topMargin: 22
         color: "#f2f2f2"
         CusButton_Image{
             id:yijianstart
             width:156
             height:123
             y:60
             x:108
             btnImgUrl:imgaeshprefix+"images/gl-sb-jiqiren9.png"
             btnImgHovered:imgaeshprefix+"images/gl-sb-jiqiren9-fz.png"
             onClicked:{

             }
         }
         CusButton_Image{
             id:teststart
             width:156
             height:123
             anchors.left: yijianstart.right
             anchors.leftMargin: 60
             y:60
             btnImgUrl:imgaeshprefix+"images/gl-sb-jiqiren10.png"
             btnImgHovered:imgaeshprefix+"images/gl-sb-jiqiren10-fz.png"
             onClicked:{

             }
         }

     }

}
