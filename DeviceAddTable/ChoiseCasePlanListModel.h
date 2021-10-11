#ifndef CHOISECASEPLANLISTMODEL_H
#define CHOISECASEPLANLISTMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class PatientCaseItem;
class ChoiseCasePlanListModelPrivate;

class ChoiseCasePlanListModel: public QuickListModel
{
    Q_OBJECT

public:
    explicit ChoiseCasePlanListModel(QObject *parent = nullptr);
    virtual ~ChoiseCasePlanListModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
//    void doUpdateName(int row, const QString &name);


    void loadCaseDataByCaseTreatment(QString casename,QString treatment);
    void addToPatientCaseChoise(QString pno,QString ptreatment);


    void insertBeforeRow(int row);

    void clearAll();

    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);
    void updateCase();
private:
    ChoiseCasePlanListModelPrivate *d;
};
#endif // CHOISECASEPLANLISTMODEL_H
