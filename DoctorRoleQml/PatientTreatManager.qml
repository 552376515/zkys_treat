import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import zmq.Components 1.0
import QtMultimedia 5.12

Item {
    id:patienttreatmanager
    width: parent.width
    height: parent.height
    anchors.fill: parent
    property int rightCellWidth: 300
    property int leftcellOffset: 30
    property int topcellOffset: 27
    property int cellSpace: 15
    property int currTreatState: 1
    property string musicname: ""
    property int anicount: 1
    property string anibackimg1: "right_26_dan.png"
    property string anibackimg2: "left_26_dan.png"
    property string anibackimg3: "left_26_dan.png"
    Rectangle{
        id:background
        x:leftcellOffset
        y:topcellOffset
        width: (patienttreatmanager.width-background.x*2-rightCellWidth)
        height: (patienttreatmanager.height-topcellOffset*2)
        color: "black"
    }
    function closeAllStatus(){
        realtimeCorrect.visible=false;
        realtimeRecognize.visible=false;
        realtimeRoutine.visible=false
    }

    Rectangle{
        id:treathead
        y:topcellOffset
        x:leftcellOffset
        width: background.width
        height: 35
        color: "#c4f1f8"
        Row{
            CusButton {
                id: treathead1
                x:10
                width: 110
                height: treathead.height
                text: qsTr("实时画面")
                backgroundColorNormal:currTreatState===1?"black":"#70c0cc"
                backgroundColorPressed:currTreatState===1?"#70c0cc":"black"
                textColor:"white"
                //selected:"true"
                onClicked: {
                    closeAllStatus();
                    realtimeCorrect.visible=true
                    currTreatState=1
                }
            }
            CusButton{
                id:treathead2
                x:10+110+2
                width: 110
                height: treathead.height
                text: qsTr("识别画面")
                backgroundColorNormal:currTreatState===2?"black":"#70c0cc"
                backgroundColorPressed:currTreatState===2?"#70c0cc":"black"
                textColor:"white"
                onClicked: {
                    closeAllStatus();
                    realtimeRecognize.visible=true
                    currTreatState=2
                }
            }
            CusButton{
                id:treatheadcorrtimer13
                x:10+220+4
                width: 110
                height: treathead.height
                text: qsTr("调理画面")
                backgroundColorNormal:currTreatState===3?"black":"#70c0cc"
                backgroundColorPressed:currTreatState===3?"#70c0cc":"black"
                textColor:"white"
                onClicked: {
                    closeAllStatus()
                    realtimeRoutine.visible=true
                    currTreatState=3
                }
            }
        }
    }
    Rectangle{
        id:realtimeCorrect
        anchors.top: treathead.bottom
        anchors.bottom: parent.bottom
        color: "transparent"
        width: background.width
        height: background.height-treathead.height-cellSpace
        visible: currTreatState==1
        PatientTreatCorrect{
            width: realtimeCorrect.width
            height: realtimeCorrect.height

        }
    }

    Rectangle{
        id:realtimeRecognize
        anchors.top: treathead.bottom
        anchors.bottom: parent.bottom
        color: "transparent"
        width: background.width
        height: background.height-treathead.height-cellSpace
        visible: currTreatState==2
        PatientTreatRecognize{
            width: realtimeRecognize.width
            height: realtimeRecognize.height

        }
    }

    Rectangle{
        id:realtimeRoutine
        anchors.top: treathead.bottom
        anchors.bottom: parent.bottom
        color: "transparent"
        width: background.width
        height: background.height-treathead.height-cellSpace
        visible: currTreatState==3
        PatientTreatRoutine{
            width: realtimeRoutine.width
            height: realtimeRoutine.height

        }
    }



    Rectangle{
        id:rightdisp
        x:patienttreatmanager.width-rightCellWidth
        width: rightCellWidth
        height: background.height+topcellOffset
        y:0
        color: "#90cfd8"
        CaseRightControl{
            width: 300
            height: background.height+topcellOffset
        }

    }
    function toReconize(){
        console.log("to recognize")
        closeAllStatus()
        realtimeRecognize.visible=true
        currTreatState=2
        console.log("to recognize1")

    }
    onVisibleChanged:{
        if (visible){
            showIndex=2
        }
    }



}
