#ifndef PATIENTCASELISTMODEL_H
#define PATIENTCASELISTMODEL_H

#include <QAbstractListModel>

struct PatientCaseParaModel
{
    PatientCaseParaModel()
    {
        paraName = "";
        paraCase = "";
    }
    //核心属性
    QString paraName;
    QString paraCase;
};
class PatientCaseListModel: public QAbstractListModel
{

    Q_OBJECT
 public:
     PatientCaseListModel(QObject* parent = 0);
     enum Roles//qml用来识别别名的规则
     {
         paraNameRole = Qt::UserRole + 1,
         paraCaseRole
     };
     void addModel(const PatientCaseParaModel &deviceList);//C++设置值
     void update(int index, const PatientCaseParaModel &paraModel);//C++更新
     void clear();//清空
 public slots:
     void addCaseData(QString dataStr);
     void loadCaseDataByPatientNoTreatment(QString patientid,QString treatment);

 protected:
     int  rowCount(const QModelIndex &parent = QModelIndex()) const;//qml内部调用,不用多管直接重写即可
     QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;//qml内部调用,不用多管直接重写即可
     QHash<int, QByteArray> roleNames() const;//qml内部调用,不用多管直接重写即可

 private:
     QList<PatientCaseParaModel> m_data;
};

#endif // PATIENTCASELISTMODEL_H
