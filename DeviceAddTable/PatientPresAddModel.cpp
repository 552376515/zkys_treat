#include "PatientPresAddModel.h"
#include <QDebug>
#include <QDateTime>
PatientPresAddModel::PatientPresAddModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

void PatientPresAddModel::addModel(const PatientCasePresParaModel &paraModel){
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << paraModel;
    qDebug()<<"m_data_count"<<m_data.length();
    endInsertRows();
}

int PatientPresAddModel::rowCount(const QModelIndex &parent) const{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant PatientPresAddModel::data(const QModelIndex &index, int role) const{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();
    const PatientCasePresParaModel &paraModel = m_data[index.row()];

    switch (role)
    {
    case paraIdRole:
        return paraModel.paraId;
        break;
    case paraScriptRole:
        return paraModel.paraScript;
        break;
    case paraDoctorRole:
        return paraModel.paraDoctor;
        break;
    case paraTimeRole:
        return paraModel.paraTime;
        break;
    default:
        break;
    }
    return QVariant();
}

void PatientPresAddModel::update(int index, const PatientCasePresParaModel &paraModel){
    if (index < 0 || index >= m_data.count())
        return;
    PatientCasePresParaModel &srcModel = m_data[index];
    if(paraModel.paraId != "")
    {
        srcModel.paraId = paraModel.paraId;
    }
    if(paraModel.paraScript != "")
    {
        srcModel.paraScript = paraModel.paraScript;
    }
    if(paraModel.paraDoctor != "")
    {
        srcModel.paraDoctor = paraModel.paraDoctor;
    }
    if(paraModel.paraTime != "")
    {
        srcModel.paraTime = paraModel.paraTime;
    }
}

void PatientPresAddModel::clear()
{
    m_data.clear();
}

QHash<int, QByteArray> PatientPresAddModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[paraIdRole] = "paraId";
    roles[paraScriptRole] = "paraScript";
    roles[paraDoctorRole] ="paraDoctor";
    roles[paraTimeRole] = "paraTime";
    return roles;
}

void PatientPresAddModel::addData(QString dataStr){
    qDebug()<<"PatientPresAddModel";
   QStringList arr=dataStr.split("@");
   if (arr.length()==4){
       qDebug()<<"PatientPresAddModel 11";
       PatientCasePresParaModel paramodel;
       paramodel.paraId = arr[0];// "仰卧手向上";
       paramodel.paraScript = arr[1];//"手少阴心经";
       paramodel.paraDoctor=arr[2];

       paramodel.paraTime=arr[3];
       addModel(paramodel);
   }
}
