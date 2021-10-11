import QtQuick 2.0
import TaoQuick 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0
Rectangle {
    id:patientimport
    width: parent.width
    height: parent.height
    anchors.fill: parent
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
    property int dispWidth: 528
    property int dispHeight: 462
    property string filePath: ""
    Rectangle{
        id:patientImportArea
        width: dispWidth
        height: dispHeight
        x:(patientimport.width-patientImportArea.width)/2.0
        y:(patientimport.height-patientImportArea.height)/2.0
        Rectangle{
            id:patientImportAreahead
            width: patientImportArea.width
            height: 52
            color: "#00C2D5"
            Text {
                id: importHeadName
                text: qsTr("批量导入")
                color: "white"
                height: patientImportAreahead.height
                verticalAlignment: Text.AlignVCenter
                x:20
                font.pixelSize: 16
            }

       }
            Button {
                id: importImage
                width: 253
                height: 126
                anchors.top: patientImportAreahead.bottom
                anchors.topMargin: 17
                x:(patientImportAreahead.width-importImage.width)/2.0
                background: Rectangle{
                    width: importImage.width
                    height: importImage.height
                    color: "transparent"
                    Image {
                        id: importImageimg
                        source: imgaeshprefix+"images/gl-tuozhuaiqv.png"
                    }

                }
                onClicked: {
                    fileDialog.open()
                }
            }
            Text{
                id:modelDownload
                text: qsTr("模板下载: ")
                font.pixelSize: 14
                color: "black"

                anchors.top: importImage.bottom
                anchors.topMargin: 20
                x:54
            }
            Text{
                id:modelDownloadcontext
                text: qsTr("1.下载模板，根据模版中的规定，进行模版填写")
                font.pixelSize: 14
                color: "#333333"
                anchors.top: modelDownload.bottom
                anchors.topMargin: 10
                x:modelDownload.x
            }
            CusButton{
                id:modeldownloadbtn
                text: "下载模版"
                textColor: "blue"
                font.pixelSize: 14
                backgroundColor: "transparent"
                x:modelDownload.x
                anchors.top: modelDownload.bottom
                anchors.topMargin: 6
                anchors.left: modelDownloadcontext.right
                anchors.leftMargin: 50
                onClicked: {

                }
            }

            Text{
                id:modelDownloadShuoming
                text: qsTr("导入说明: ")
                font.pixelSize: 14
                color: "black"
                anchors.top: modelDownloadcontext.bottom
                anchors.topMargin: 20
                x:modelDownload.x
            }
            Text{
                id:modelDownloadShuomingontext1
                text: qsTr("1.仅支持上传文件名为.xls或.xlsx的表格文件")
                font.pixelSize: 14
                color: "#333333"
                anchors.top: modelDownloadShuoming.bottom
                anchors.topMargin: 10
                x:modelDownload.x
            }
            Text{
                id:modelDownloadShuomingontext2
                text: qsTr("2.前三行为表头及样例行，请勿修改、删除")
                font.pixelSize: 14
                color: "#333333"
                anchors.top: modelDownloadShuomingontext1.bottom
                anchors.topMargin: 10
                x:modelDownload.x
            }

            Button {
                id: importqv
                width: 155
                height: 40
                anchors.top: modelDownloadShuomingontext2.bottom
                anchors.topMargin: 28
                x:73
                background: Rectangle{
                    width: importqv.width
                    height: importqv.height
                    color: "transparent"
                    Image {
                        id: importqvimg
                        width: importqv.width
                        height: importqv.height
                        source: importqv.hovered?imgaeshprefix+"images/gl-piliang-qvxiao-fz.png":imgaeshprefix+"images/gl-piliang-qvxiao.png"
                    }

                }


                onClicked: {
                     patientImport.visible=false
                }
            }
            Button {
                id: importsure
                width: 155
                height: 40
                anchors.top: modelDownloadShuomingontext2.bottom
                anchors.topMargin: 28
                anchors.left: importqv.right
                anchors.leftMargin: 71
                background: Rectangle{
                    width: importsure.width
                    height: importsure.height
                    color: "transparent"
                    Image {
                        id: importsureimg
                        width: importsure.width
                        height: importsure.height
                        source: importsure.hovered?imgaeshprefix+"images/gl-kaishidaoru-fz.png":imgaeshprefix+"images/gl-kaishidaoru.png"
                    }
                }
                onClicked: {
                    glpatientModel.readExcelToGl(filePath)
                }
            }

    }
    FileDialog{
        id:fileDialog
        title: qsTr("请选择要导入的文件")
        nameFilters: ["*.xls","*.xlsx"]
        onAccepted: {
            filePath=String(fileUrl)
        }

    }
}
