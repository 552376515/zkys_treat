#ifndef PATIENTTREATMENTRECORDMODEL_H
#define PATIENTTREATMENTRECORDMODEL_H

#include <QObject>
#include "QuickModel/QuickListModel.h"
class PatientCaseItem;
class PatientTreatmentRecordModelPrivate;



class PatientTreatmentRecordModel: public QuickListModel
{

//    Q_OBJECT
// public:
//     PatientTreatmentRecordModel(QObject* parent = 0);
//     enum Roles//qml用来识别别名的规则
//     {
//         paraNameRole = Qt::UserRole + 1,
//         paraCaseRole
//     };
//     void addModel(const PatientTreatmentRecordParaModel &deviceList);//C++设置值
//     void update(int index, const PatientTreatmentRecordParaModel &paraModel);//C++更新

// public slots:
//     void addTreatmentData(QString dataStr);
//     void clear();//清空
//     void loadCaseTreatmentRecord(QString patientid,QString treatment);

// protected:
//     int  rowCount(const QModelIndex &parent = QModelIndex()) const;//qml内部调用,不用多管直接重写即可
//     QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;//qml内部调用,不用多管直接重写即可
//     QHash<int, QByteArray> roleNames() const;//qml内部调用,不用多管直接重写即可

// private:
//     QList<PatientTreatmentRecordParaModel> m_data;

     Q_OBJECT

 public:
     explicit PatientTreatmentRecordModel(QObject *parent = nullptr);
     virtual ~PatientTreatmentRecordModel() override;
     Q_INVOKABLE virtual void sortByRole() override;
 public slots:


     void loadCaseTreatmentRecord(QString patientid,QString treatment);

     void addCaseData(QString dataStr,int index);
     void addModel(const PatientCaseItem &paraModel);

     void swapRow(int from,int to);

     void insertBeforeRow(int row);

     void clearAll();

 //    void removeSelected();
 //    void removeChecked();
     void removeRow(int row);
 private:
     void sortByName(Qt::SortOrder order);
     void sortByAddress(Qt::SortOrder order);
     void sortByModel(Qt::SortOrder order);
     void updateCase();
 private:
     PatientTreatmentRecordModelPrivate *d;
};
#endif // PATIENTTREATMENTRECORDMODEL_H
