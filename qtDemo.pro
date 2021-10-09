QT += quick virtualkeyboard core gui sql charts
QT += widgets
requires(qtConfig(tablewidget))

CONFIG += c++11
CONFIG(debug,debug|release){
    # debug mode use local file
    win32{
        path=$$system("cd")
        path ~=s,\\\\,/,g
    } else {
        path=$$system("pwd")
    }

    DEFINES += MainImageResourcePath=\\\"file:///$${path}/Resource/\\\"
} else {
    # release mode use qrc file

    # release mode set importPath with 'qrc:///'

    DEFINES += MainImageResourcePath=\\\"qrc:/Resource/\\\"
}

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

DISTFILES += \
    qml/qtDemo/*



# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

include($$PWD/zmqml/zmq.pri)
include($$PWD/TaoQuick/imports/imports.pri)
include($$PWD/TaoCommon/TaoCommon.pri)
include($$PWD/xlsx/qtxlsx.pri)

INCLUDEPATH += $$PWD/zmqml/ include

SOURCES += \
    DeviceAddTable/ChoiseCaseItem.cpp \
    DeviceAddTable/ChoiseCaseModel.cpp \
    DeviceAddTable/ChoiseCasePlanListModel.cpp \
        DeviceAddTable/DeviceAddItem.cpp \
        DeviceAddTable/DeviceAddModel.cpp \
    DeviceAddTable/DoctorManageItem.cpp \
    DeviceAddTable/DoctorManagerModel.cpp \
    DeviceAddTable/GLPatientManagerModel.cpp \
    DeviceAddTable/PatientCaseListModel.cpp \
    DeviceAddTable/PatientCaseListNewModel.cpp \
        DeviceAddTable/PatientCaseModel.cpp \
        DeviceAddTable/PatientDb.cpp \
    DeviceAddTable/PatientPresAddModel.cpp \
    DeviceAddTable/PatientTreatmentRecordModel.cpp \
    DeviceAddTable/TreatCaseManageListModel.cpp \
    DeviceAddTable/TreatCaseModel.cpp \
        DeviceAddTable/patientcaseitem.cpp \
    Patient/ImageProvider.cpp \
    Patient/ShowImage.cpp \
        zmqml/zmqcontext.cpp \
        zmqml/zmqsocket.cpp \
        zmqml/bytearraytools.cpp \
        main.cpp

RESOURCES += qml.qrc



# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH +=$$PWD/TaoQuick/imports/TaoQuick
QML_IMPORT_PATH =
# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    DeviceAddTable/ChoiseCaseItem.h \
    DeviceAddTable/ChoiseCaseModel.h \
    DeviceAddTable/ChoiseCasePlanListModel.h \
    DeviceAddTable/DeviceAddItem.h \
    DeviceAddTable/DeviceAddModel.h \
    DeviceAddTable/DoctorManageItem.h \
    DeviceAddTable/DoctorManagerModel.h \
    DeviceAddTable/GLPatientManagerModel.h \
    DeviceAddTable/PatientCaseListModel.h \
    DeviceAddTable/PatientCaseListNewModel.h \
    DeviceAddTable/PatientCaseModel.h \
    DeviceAddTable/PatientPresAddModel.h \
    DeviceAddTable/PatientTreatmentRecordModel.h \
    DeviceAddTable/TreatCaseManageListModel.h \
    DeviceAddTable/TreatCaseModel.h \
    DeviceAddTable/patientcaseitem.h \
    Patient/ImageProvider.h \
    Patient/ShowImage.h \
    zmqml/zmqcontext.h \
    zmqml/zmqsocket.h \
    zmqml/bytearraytools.h \
    PatientDb.h

FORMS +=

#DISTFILES += libzmq-mingw64-4_3_4/libzmq.dll

#LIBS +=-L D:\Qt\project\build-qtDemo-Desktop_Qt_5_14_2_MinGW_64_bit-Debug\debug -lzmq-v120-mt-gd-4_3_4

