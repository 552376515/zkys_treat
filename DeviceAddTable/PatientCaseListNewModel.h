#ifndef PATIENTCASELISTNEWMODEL_H
#define PATIENTCASELISTNEWMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class PatientCaseItem;
class PatientCaseListNewModelPrivate;

class PatientCaseListNewModel: public QuickListModel
{
    Q_OBJECT

public:
    explicit PatientCaseListNewModel(QObject *parent = nullptr);
    virtual ~PatientCaseListNewModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
//    void doUpdateName(int row, const QString &name);

    void initCaseData();
    void loadCaseDataByPatientNo(QString patientid);
    void changeDataByIndex(int index);
    void addCaseData(QString dataStr,int index);
    void addModel(const PatientCaseItem &paraModel);
    void addToPatientCaseGl(QString pno,QString ptreatment);

    void swapRow(int from,int to);

//    void addOne();
//    void addMulti(int count);

//    void genTxtItems();
//    void saveTxtItems();

//    void insertBeforeSelected();
    void insertBeforeRow(int row);

    void clearAll();

//    void removeSelected();
//    void removeChecked();
    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByAddress1(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);
private:
    PatientCaseListNewModelPrivate *d;
};


#endif // PATIENTCASELISTNEWMODEL_H
