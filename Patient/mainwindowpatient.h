#ifndef MAINWINDOWPATIENT_H
#define MAINWINDOWPATIENT_H

#include <QtWidgets>
#include <QMainWindow>

namespace Ui {
class MainWindowPatient;
}

class MainWindowPatient : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindowPatient(QWidget *parent = nullptr);
    ~MainWindowPatient();

private:
    Ui::MainWindowPatient *ui;
};

#endif // MAINWINDOWPATIENT_H
