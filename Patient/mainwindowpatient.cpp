#include "mainwindowpatient.h"
#include "ui_mainwindowpatient.h"

MainWindowPatient::MainWindowPatient(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindowPatient)
{
    ui->setupUi(this);

    ui->tableWidget->setColumnCount(3);
    ui->tableWidget->setHorizontalHeaderLabels(QStringList()<<"姓名"<<"ID"<<"注册时间");



}

MainWindowPatient::~MainWindowPatient()
{
    delete ui;
}
