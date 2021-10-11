#ifndef DOCTORMANAGERMODEL_H
#define DOCTORMANAGERMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class DoctorManageItem;
class DoctorManagerModelPrivate;
class DoctorManagerModel : public QuickListModel
{
    Q_OBJECT

public:
    explicit DoctorManagerModel(QObject *parent = nullptr);
    virtual ~DoctorManagerModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
//    void doUpdateName(int row, const QString &name);

    void initCaseData();

//    void addOne();
//    void addMulti(int count);

//    void genTxtItems();
//    void saveTxtItems();

//    void insertBeforeSelected();

    void modifyDoctorPwd(QString doctorid,QString newpwd);
    void resetAllDocPwd();
    void forbidUser(QString doctorid);
    void insertBeforeRow(int row);

    void clearAll();

//    void removeSelected();
//    void removeChecked();
    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);
    void updateData();
private:
    DoctorManagerModelPrivate *d;
};

#endif // DOCTORMANAGERMODEL_H
