#include "PatientCaseModel.h"
#include "patientcaseitem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
#include <chrono>
#include <random>
#include "PatientDb.h"

const static QStringList sHeaderRoles = { "casename","treatment","tcount", "doctor","prescriptime","online" };
const static QStringList sHeaders={"病/病名","处方","已调理","处方医生","处方时间",""};
class PatientCaseModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

PatientCaseModel::PatientCaseModel(QObject *parent) : QuickListModel(parent), d(new PatientCaseModelPrivate)
{
    setHeaderRoles(sHeaderRoles);
    setTableHeaders(sHeaders);
}

PatientCaseModel::~PatientCaseModel(){
    delete d;
}

void PatientCaseModel::sortByRole()
{
    if (mDatas.count() <= 1) {
        return;
    }
    int index = sHeaderRoles.indexOf(mSortRole);
    switch (index) {
    case 0: {
        sortByName(mSortOrder);
        break;
    }
    case 1: {
        sortByAddress(mSortOrder);
        break;
    }
    case 4: {
        sortByModel(mSortOrder);
        break;
    }
    default:
        break;
    }
    updateAlternate();
}
void PatientCaseModel::initCaseData(){
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();
//    if (!QSqlDatabase::drivers().contains("QSQLITE"))
//       printf("Unable to load database");


//    // Initialize the database:
//    QSqlError err = initDb();
//    if (err.type() != QSqlError::NoError) {
//        return;
//    }

    /**************************使用QSqlQuery操作数据库**************************/
            //执行操作类对象
QSqlQuery patientscasequery;
        //查询数据
        patientscasequery.prepare("SELECT * FROM patientscase");
        patientscasequery.exec();	//执行

        QSqlRecord recode = patientscasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
       // int column = recode.count();			//获取读取结果的列数
        QString s1 = recode.fieldName(0);
        while (patientscasequery.next())
        {
            auto item = new PatientCaseItem;
            item->set_casename(patientscasequery.value("pcase").toString());
            item->set_treatment(patientscasequery.value("treatment").toString());
            item->set_doctor(patientscasequery.value("doctor").toString());
            item->set_prescriptime(patientscasequery.value("checkdate").toString());
            item->set_tcount(patientscasequery.value("state").toString());
           // item->set_regtime(query.value("regtime").toString());
            item->set_online(false);
            objs.append(item);
           // qDebug()<<patientcasequery.value("patientname").toString();
        }
        auto c2 = std::chrono::high_resolution_clock::now();
        auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
        //qWarning() << "general" << N << "cost" << micro << "ms";
        resetData(objs);
}

void PatientCaseModel::loadCaseByPatientId(QString patientId){
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();
    QSqlQuery patientscasequery;

  //  QString str=QString("SELECT * FROM patientscase where patientid like '%%1%'").arg(patientId);
    QString str=QString("SELECT * FROM patientscase where patientid='%1'").arg(patientId);
    patientscasequery.prepare(str);
    patientscasequery.exec();	//执行

    QSqlRecord recode = patientscasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
  // qDebug()<<"获取读取结果的列数"<<recode.count();
    // int column = recode.count();			//获取读取结果的列数
    QString s1 = recode.fieldName(0);
    while (patientscasequery.next())
    {
        auto item = new PatientCaseItem;
        item->set_casename(patientscasequery.value("pcase").toString());
        item->set_treatment(patientscasequery.value("treatment").toString());
        item->set_doctor(patientscasequery.value("doctor").toString());
        item->set_prescriptime(patientscasequery.value("checkdate").toString());
        item->set_tcount(patientscasequery.value("state").toString());
       // item->set_regtime(query.value("regtime").toString());
        item->set_online(false);
        objs.append(item);
       // qDebug()<<patientcasequery.value("patientname").toString();
    }
    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
    if(mDatas.count()==0){
        resetData(objs);
    }else {
        mDatas=objs;
    }
    sortByDate(Qt::SortOrder::DescendingOrder);
}

void PatientCaseModel::addToPatientCase(QString pname,QString pno,QString pcase,QString ptreatment, QString doctor)
{
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    QDate now=QDate::currentDate();
    QList<QuickListItemBase *> copyObjs = mDatas;
 // qDebug()<<"addToPatientCaseGl"<<copyObjs.count();
    for (int i=0;i<copyObjs.count();i++){
        //QDebug()<<"addToPatientCaseGl"<<i;
        PatientCaseItem *tmpmodel=dynamic_cast<PatientCaseItem *>(copyObjs.at(i));

        if (tmpmodel->tcount()=="0"){
            QSqlQuery query;
            QString str=QString("DELETE FROM patientscase where patientid='%1' and state='%2'").arg(pno).arg(tmpmodel->tcount());
          //  qDebug()<<str;
            query.prepare(str);
            query.exec();
            removeAt(i);
            break;
        }

    }
 //   qDebug()<<"addToPatientCaseGl"<<mDatas.count();
  //  mDatas=copyObjs;
    addPatientCaseNew(pname,pno.toInt(),pcase,ptreatment,doctor,now,0,now);
    auto item = new PatientCaseItem;
    item->set_casename(pcase);
    item->set_treatment(ptreatment);
    item->set_doctor(doctor);
    item->set_prescriptime(now.toString("yyyy-MM-dd"));
    item->set_tcount("0");
   // item->set_regtime(query.value("regtime").toString());
    item->set_online(false);
    objs.append(item);
    insert(0,objs);
    //append(objs);
}

void PatientCaseModel::clearAll()
{
    clear();
}


void PatientCaseModel::removeRow(int row)
{
    removeAt(row);
}


void PatientCaseModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}

void PatientCaseModel::sortByName(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<PatientCaseItem *>(obj1))->casename() < (static_cast<PatientCaseItem *>(obj2))->casename();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<PatientCaseItem *>(obj1))->casename() > (static_cast<PatientCaseItem *>(obj2))->casename();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void PatientCaseModel::sortByDate(Qt::SortOrder order){
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<PatientCaseItem *>(obj1))->prescriptime() < (static_cast<PatientCaseItem *>(obj2))->prescriptime();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<PatientCaseItem *>(obj1))->prescriptime() > (static_cast<PatientCaseItem *>(obj2))->prescriptime();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void PatientCaseModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<PatientCaseItem *>(obj1)->treatment() < static_cast<PatientCaseItem *>(obj2)->treatment();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<PatientCaseItem *>(obj1)->treatment() > static_cast<PatientCaseItem *>(obj2)->treatment();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void PatientCaseModel::sortByModel(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<PatientCaseItem *>(obj1))->prescriptime().toULongLong() < (static_cast<PatientCaseItem *>(obj2))->prescriptime().toULongLong();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<PatientCaseItem *>(obj1))->prescriptime().toULongLong() > (static_cast<PatientCaseItem *>(obj2))->prescriptime().toULongLong();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}
