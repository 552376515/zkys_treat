#include "PatientCaseListModel.h"
#include <QDebug>

PatientCaseListModel::PatientCaseListModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

void PatientCaseListModel::addModel(const PatientCaseParaModel &paraModel)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << paraModel;
    endInsertRows();
}

int PatientCaseListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant PatientCaseListModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const PatientCaseParaModel &paraModel = m_data[index.row()];
    switch (role)
    {
    case paraNameRole:
        return paraModel.paraName;
        break;
    case paraCaseRole:
        return paraModel.paraCase;
        break;
    default:
        break;
    }
    return QVariant();
}

void PatientCaseListModel::update(int index, const PatientCaseParaModel &paraModel)
{
    if (index < 0 || index >= m_data.count())
        return;
    PatientCaseParaModel &srcModel = m_data[index];
    if(paraModel.paraName != "")
    {
        srcModel.paraName = paraModel.paraName;
    }
    if(paraModel.paraCase != "")
    {
        srcModel.paraCase = paraModel.paraCase;
    }
}

void PatientCaseListModel::clear()
{
    m_data.clear();
}

void PatientCaseListModel::addCaseData(QString dataStr){
    QStringList list;
#if 1
     qDebug()<<"PatientCaseListModel";
    QStringList arr=dataStr.split(" ");
    if (arr.length()==2){
        PatientCaseParaModel paramodel;
        paramodel.paraName = arr[0];// "仰卧手向上";
        paramodel.paraCase = arr[1];//"手少阴心经";
        addModel(paramodel);
    }

#else

    list.append("仰卧手向上  手少阴心经");
    QStringList arr=list[0].split(" ");
    PatientCaseParaModel paramodel;
    paramodel.paraName =  "仰卧手向上";
    paramodel.paraCase = "手少阴心经";
    addModel(paramodel);
#endif
}
//qml通过这里的QByteArray来访问数据
//首先qml输入"value"知道其role为roles[valueRole]，然后把valueRole输入到data函数返回真实值
QHash<int, QByteArray> PatientCaseListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[paraNameRole] = "paraName";
    roles[paraCaseRole] = "paraCase";
    return roles;
}
