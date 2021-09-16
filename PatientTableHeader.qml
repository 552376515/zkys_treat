import QtQuick 2.0
import TaoQuick 1.0

Item {
    id: cusTableHeader
    height: 50
    clip: true

    property int splitingIndex: -1
    property bool isOut: false
    property var dataObj
    property var headerRoles
    property var headerNames
    property bool needSort: true

    property var widthList
    property var xList
    property real totalW
    property real visualWidth
    property bool isChoise: false

    onWidthListChanged: {
        updateXList()
    }
    onVisualWidthChanged: {
        updateWidthList()
        updateXList()
    }
    Component.onCompleted: {
        updateWidthList()
        updateXList()
    }
    property var updateXList: function() {
        var xL = [0]
        var tw = 0;
        for (var i = 0; i < widthList.length; ++i) {
            xL.push(xL[i] + widthList[i])
            tw += widthList[i]
        }
        xList = xL
        if (tw < visualWidth) {
            widthList[widthList.length - 1] += visualWidth - tw
            tw = visualWidth
        }
        totalW = tw
    }
    property var updateWidthList: function () {}


    Repeater {
        model: headerRoles
        Rectangle {
            x: xList[index]
            height: cusTableHeader.height
            width: widthList[index]
            color: "transparent"
            CusLabel {
                anchors.fill: parent
                text: qsTr(headerNames[index]) + CusConfig.transString
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: isChoise?"white":"#0f7e8b"
                 font.pixelSize: 16
            }

            CusImageOverlay {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }
                width: 8
                height: 8
                readonly property string ascUrl: CusConfig.imagePathPrefix + "Table_Asc.png"
                readonly property string ascUrl_Hovered: CusConfig.imagePathPrefix
                                                         + "Table_Asc_Hovered.png"
                readonly property string descUrl: CusConfig.imagePathPrefix + "Table_Desc.png"
                readonly property string descUrl_Hovered: CusConfig.imagePathPrefix
                                                          + "Table_Desc_Hovered.png"

                property string ascImageUrl: (headerArea.containsMouse) ? ascUrl_Hovered : ascUrl
                property string descImageUrl: (headerArea.containsMouse) ? descUrl_Hovered : descUrl

                source: visible ? (dataObj.sortOrder === 0 ? ascImageUrl : descImageUrl) : ""

                visible: dataObj && dataObj.sortRole === headerRoles[index]
                color: headerArea.containsMouse ? CusConfig.imageColor_hovered : CusConfig.imageColor
            }
            MouseArea {
                id: headerArea
                enabled: needSort
                hoverEnabled: enabled
                anchors {
                    fill: parent
                    leftMargin: 4
                }
                onClicked: {
                    if (dataObj.sortRole !== headerRoles[index]) {
                        dataObj.sortRole = headerRoles[index]
                    } else {
                        if (dataObj.sortOrder === Qt.AscendingOrder) {
                            dataObj.sortOrder = Qt.DescendingOrder
                        } else {
                            dataObj.sortOrder = Qt.AscendingOrder
                        }
                    }
                    dataObj.sortByRole()
                }
            }
            MoveArea {
                id: moveArea
                width: 4
                height: parent.height
                enabled: index > 0
                anchors {
                    left: parent.left
                }
                onPressedChanged: {
                    if (pressed) {
                        splitingIndex = index
                    } else {
                        splitingIndex = -1
                    }
                }
                cursorShape: (pressed || containsMouse) ? Qt.SplitHCursor : Qt.ArrowCursor
                onMove: {
                    if (index === 0) {
                        return
                    }
                    var wList = widthList
                    //                    if (index === widthList.length - 2) {
                    //                        if (validWidth(wList[index] + xOffset) && validWidth(wList[index + 1] - xOffset)) {
                    //                            isOut = false
                    //                            wList[index] += xOffset
                    //                            wList[index + 1] -= xOffset
                    //                            widthList = wList
                    //                        } else {
                    //                            isOut = true
                    //                        }

                    //                    } else {
                    if (validWidth(wList[index] + xOffset) ) {
                        isOut = false
                        wList[index] += xOffset
                        widthList = wList
                    } else {
                        isOut = true
                    }
                    //                    }
                }
            }
        }
    }
    function validWidth(targetWidth) {
        return inRange(targetWidth,CusTableConstant.minWidth,CusTableConstant.maxWidth  )
    }
    function inRange(value, min, max) {
        return (min <= value && value <= max)
    }
}

