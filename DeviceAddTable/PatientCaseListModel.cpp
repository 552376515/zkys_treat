#include "PatientCaseListModel.h"
#include <QDebug>
#include "patientcaseitem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
#include <QList>
#include <chrono>
#include <random>
#include "PatientDb.h"
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

void PatientCaseListModel::loadCaseDataByPatientNoTreatment(QString patientid,QString treatment){
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    QSqlQuery patientcasequery;
    m_data.clear();
    auto c1 = std::chrono::high_resolution_clock::now();
   // QString qsql="SELECT * FROM patientscasegl where patientid=";
    QString str=QString("SELECT * FROM patientscasegl where patientid='%1' and treatment='%2'").arg(patientid).arg(treatment);
    patientcasequery.prepare(str);
    patientcasequery.exec();	//执行
 //   qDebug()<<"loadCaseDataByPatientNoTreatment="<<str;
    QSqlRecord recode = patientcasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
   // int column = recode.count();			//获取读取结果的列数
    QString s1 = recode.fieldName(0);
//    qDebug()<<"loadCaseDataByPatientNoTreatmentcount="<<recode.count();
    while (patientcasequery.next())
    {
//        qDebug()<<"loadCaseDataByPatientNoTreatmentcount";
        PatientCaseParaModel parm1;
        parm1.paraName=patientcasequery.value("directlay").toString();
        parm1.paraCase =patientcasequery.value("jingluo").toString();
        addModel(parm1);
    }
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
