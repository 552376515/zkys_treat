#ifndef TREATCASEMANAGELISTMODEL_H
#define TREATCASEMANAGELISTMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class PatientCaseItem;
class TreatCaseManageListModelPrivate;


class TreatCaseManageListModel: public QuickListModel
{
    Q_OBJECT

public:
    explicit TreatCaseManageListModel(QObject *parent = nullptr);
    virtual ~TreatCaseManageListModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
//    void doUpdateName(int row, const QString &name);


    void loadCaseDataByTreatment(QString treatment);
    void changeDataByIndex(int index);
    void addCaseData(QString dataStr,int index);
    void addToCaseGl(QString ptreatment);

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
    void updateCase();
private:
    TreatCaseManageListModelPrivate *d;
};


#endif // TREATCASEMANAGELISTMODEL_H
