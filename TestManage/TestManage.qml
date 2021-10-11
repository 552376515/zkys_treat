import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import TaoQuick 1.0
import "../DoctorRoleQml"
import zmq.Components 1.0
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
                backgroundColorNormal:"#70c0cc"
                backgroundColorPressed:"black"
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
                backgroundColorNormal:"#70c0cc"
                backgroundColorPressed:"black"
                textColor:"white"
                onClicked: {
                    closeAllStatus();
                    realtimeRecognize.visible=true
                    currTreatState=2
//                    realpatient2.visible=true
//                    realpatient.visible=false
                  //  showIndex=4

                 //  CodeImage.initData(0)
                }
            }
            CusButton{
                id:treatheadcorrtimer13
                x:10+220+4
                width: 110
                height: treathead.height
                text: qsTr("调理画面")
                backgroundColorNormal:"#70c0cc"
                backgroundColorPressed:"black"
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
            height: background.height+20

            y:0
            color: "#90cfd8"
            TestRightControl{
                width: 300
                height: background.height+20
            }

        }

}
