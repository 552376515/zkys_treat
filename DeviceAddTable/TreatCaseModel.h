#ifndef TREATCASEMODEL_H
#define TREATCASEMODEL_H
#include <QObject>
#include "QuickModel/QuickListModel.h"
class PatientCaseItem;
class TreatCaseModelPrivate;

class TreatCaseModel: public QuickListModel
{
    Q_OBJECT
public:


    explicit TreatCaseModel(QObject *parent = nullptr);
    virtual ~TreatCaseModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
    void initTreatData();
    void insertBeforeRow(int row);

    void clearAll();
    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);
    TreatCaseModelPrivate *d;
};

#endif // TREATCASEMODEL_H
