#ifndef CHOISECASEMODEL_H
#define CHOISECASEMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class ChoiseCaseModelPrivate;
class ChoiseCaseModel: public QuickListModel
{
    Q_OBJECT

public:
    explicit ChoiseCaseModel(QObject *parent = nullptr);
    virtual ~ChoiseCaseModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
    void insertBeforeRow(int row);
    void initCaseData();
    void clearAll();
    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);
private:
    ChoiseCaseModelPrivate *d;
};

#endif // CHOISECASEMODEL_H
