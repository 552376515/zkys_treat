#ifndef PATIENTCASEMODEL_H
#define PATIENTCASEMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class PatientCaseItem;
class PatientCaseModelPrivate;
class PatientCaseModel : public QuickListModel
{
    Q_OBJECT

public:
    explicit PatientCaseModel(QObject *parent = nullptr);
    virtual ~PatientCaseModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
//    void doUpdateName(int row, const QString &name);

    void initCaseData();

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
    void sortByModel(Qt::SortOrder order);
private:
    PatientCaseModelPrivate *d;
};

#endif // PATIENTCASEMODEL_H
