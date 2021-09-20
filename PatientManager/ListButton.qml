import QtQuick 2.0

import QtQuick 2.4

Item {
    id:listButtonItem
    property int first: 0
    property int last: 20
    property int current: 0
    signal selectChange(var value)
    signal lastNumChanged(var value)
    onLastChanged: {
        refrushList()
    }
    function refrushList(){
        if(current > last){
            current = last
        }
        var mycaus=[]
        for(var i=0;i<6;i++){
            mycaus[i]= last+i-5;
        }
        for(i = 6;i<12;i++){
            mycaus[i] = first +i -6;
        }
        var flag=-1;
        for(i = 2;i<9;i++){
            if(current === mycaus[i]){
                flag = i;
            }
        }
        if(flag !== -1){
            text1.text = formataNum(mycaus[flag])
            text2.text = formataNum(mycaus[flag-1])
            text3.text = formataNum(mycaus[flag])
            text4.text = formataNum(mycaus[flag+1])
            text5.text = formataNum(mycaus[flag+2])
        }else{
            text1.text = formataNum(current-2)
            text2.text = formataNum(current-1)
            text3.text = formataNum(current)
            text4.text = formataNum(current+1)
            text5.text = formataNum(current+2)
        }


    }
    Component.onCompleted: {
        refrushList()
    }

    function formataNum(num){
        var s;
        String(num).length >= 2 ? s = String(num):s = '0' + num;
        return s;
    }

    function updateText(y){
        if(y >= listButtonItem.height *0.5){
            text1.text = text2.text
            text2.text = text3.text
            text3.text = text4.text
            text4.text = text5.text
            if(Number(text5.text) === last){
                text5.text = formataNum(first)
            }else{
               var num = Number(text5.text)+1;
               text5.text = formataNum(num)
            }
        }else{

            text5.text = text4.text
            text4.text = text3.text
            text3.text = text2.text
            text2.text = text1.text

            if(Number(text1.text) === first){
                text1.text = formataNum(last)
            }else{
               var num1 = Number(text1.text)-1;
               text1.text = formataNum(num1)
            }
        }
         current = Number(text3.text)
    }

    MouseArea{
        anchors.fill: parent
        onWheel: {
            var datl = wheel.angleDelta.y/120;//一刻滚轮代表正负120度，所以除以120等于1或者-1
            if(datl>0){
                updateText(listButtonItem.height *0.4)
            }else{
                updateText(listButtonItem.height *0.6)
            }
        }
        onClicked: updateText(mouse.y)

    }

    Column{
        anchors.fill: parent
        Rectangle{
            width: parent.width
            height: parent.height / 5
            color: "transparent"
            Text {
                id: text1
                color: "#be8181"
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.4
                text: "<b>2002</b>"
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height / 5
            color: "transparent"
            Text {
                id: text2
                color: "#be8181"
                //anchors.fill: parent
                anchors.centerIn: parent
                font.pixelSize: parent.height *0.6
                text: "2002"
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height / 5
            color: "transparent"
            Text {
                id: text3
                //anchors.fill: parent
                anchors.centerIn: parent
                font.pixelSize: parent.height* 0.8
                text: "<b>2002</b>"
                color:"#fd7d2c"
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height / 5
            color: "transparent"
            Text {
                id: text4
                color: "#be8181"
                //anchors.fill: parent
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.6
                text: "<b>2002</b>"
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height / 5
            color: "transparent"
            Text {
                id: text5
                color: "#be8181"
                //anchors.fill: parent
                anchors.centerIn: parent
                font.pixelSize: parent.height *0.4
                text: "<b>2002</b>"
            }
        }
    }
}

