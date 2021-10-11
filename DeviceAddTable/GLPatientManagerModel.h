#ifndef GLPATIENTMANAGERMODEL_H
#define GLPATIENTMANAGERMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
#include <QtCore>
#include "xlsx/xlsxdocument.h"
class DeviceAddItem;
class GLPatientManagerModelPrivate;
class GLPatientManagerModel : public QuickListModel
{

    Q_OBJECT
public:
    explicit GLPatientManagerModel(QObject *parent = nullptr);
    virtual ~GLPatientManagerModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
    void doUpdateName(int row, const QString &name);

    void initData();

    void addOne(const QString patientStr );
    void addMulti(int count);

    void genTxtItems();
    void saveTxtItems();
    void readExcelToGl(QString filename);
    void writeGlToExcel(QString filename);

    void insertBeforeSelected();
    void insertBeforeRow(int row);

    void clearAll();

    void removeSelected();
    void removeChecked();
    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);

    DeviceAddItem *genOne(uint32_t value);
private:
    GLPatientManagerModelPrivate *d;
};

#endif // GLPATIENTMANAGERMODEL_H
