#include "PatientTreatmentRecordModel.h"

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


const static QStringList jHeaderRoles = { "prescriptime","doctor" };
const static QStringList jHeaders={"",""};
class PatientTreatmentRecordModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

PatientTreatmentRecordModel::PatientTreatmentRecordModel(QObject *parent) : QuickListModel(parent), d(new PatientTreatmentRecordModelPrivate)
{
    setHeaderRoles(jHeaderRoles);
    setTableHeaders(jHeaders);
}

PatientTreatmentRecordModel::~PatientTreatmentRecordModel(){
    delete d;
}

void PatientTreatmentRecordModel::sortByRole()
{
    if (mDatas.count() <= 1) {
        return;
    }
    int index = jHeaderRoles.indexOf(mSortRole);
    switch (index) {
    case 0: {
        sortByName(mSortOrder);
        break;
    }
    case 1: {
        sortByAddress(mSortOrder);
        break;
    }

    default:
        break;
    }
    updateAlternate();
}

void PatientTreatmentRecordModel::updateCase(){
     emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}
void PatientTreatmentRecordModel::loadCaseTreatmentRecord(QString patientid,QString treatment){
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    QSqlQuery patientcasequery;
    auto c1 = std::chrono::high_resolution_clock::now();
   // QString qsql="SELECT * FROM patientscasegl where patientid=";
     QString qsql=QString("SELECT * FROM patientstreatmentrecord where patientid='%1' and treatment='%2'").arg(patientid).arg(treatment);
   // clearAll();
    patientcasequery.prepare(qsql);
    patientcasequery.exec();	//执行
    qDebug()<<qsql;
// qWarning() << "general" << N << "cost" << "ms";
    QSqlRecord recode = patientcasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
   // int column = recode.count();			//获取读取结果的列数
    QString s1 = recode.fieldName(0);
    while (patientcasequery.next())
    {
        auto item = new PatientCaseItem;
        item->set_prescriptime(patientcasequery.value("treatdate").toString());
        item->set_doctor(patientcasequery.value("doctor").toString());
        objs.append(item);
//           qWarning() << "general" << N << "cost" << item->casename() << "ms";

    }
    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
    mDatas=objs;
    updateCase();

}


void PatientTreatmentRecordModel::addModel(const PatientCaseItem &paraModel)
{


}


void PatientTreatmentRecordModel::addCaseData(QString dataStr,int index){


    QStringList list;
    const int N = 5;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);

    QStringList arr=dataStr.split(" ");
    if (arr.length()==2){
         auto item = new PatientCaseItem;
         item->set_prescriptime(arr[0]);
         item->set_doctor(arr[1]);
         item->set_treatment(arr[2]);


         QList<QuickListItemBase *> copyObjs = mDatas;
         bool hasFlag=false;
         for (int i=0;i<copyObjs.count();i++){
             PatientCaseItem *tmpmodel=dynamic_cast<PatientCaseItem *>(copyObjs.at(i));
             if (tmpmodel->treatment() ==item->treatment()){
                 hasFlag=true;
             }

         }
         if (!hasFlag){
             objs.append(item);
         }

    }

    if (objs.count()>0){
        append(objs);
    }


}

void PatientTreatmentRecordModel::swapRow(int from,int to){
    if (from!=to && from>=0<mDatas.count() && to>=0 && to<mDatas.count()){
        beginMoveRows(QModelIndex(),from,from,
                      QModelIndex(),from>to?(to):(to+1));
        auto item=mDatas.takeAt(from);
        mDatas.insert(to,item);
        endMoveRows();
        updateCalcInfo();
    }
}



void PatientTreatmentRecordModel::clearAll()
{
    clear();
}


void PatientTreatmentRecordModel::removeRow(int row)
{
    removeAt(row);
}


void PatientTreatmentRecordModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}



void PatientTreatmentRecordModel::sortByName(Qt::SortOrder order)
{
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

void PatientTreatmentRecordModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    const static QStringList zitaiList = { "足少阴肾经(体前)","手厥阴心包经","足少阳胆经","足厥阴肝经", "手太阴肺经","足阳明胃经", "足太阴脾经1","足太阴脾经2", "手少阴心经", "手少阳三焦经", "手阳明大肠经", "手太阳小肠经", "足太阳膀胱经1","足太阳膀胱经2", "足少阴肾经(体后)" };

    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {

             return (static_cast<PatientCaseItem *>(obj1))->doctor() < (static_cast<PatientCaseItem *>(obj2))->doctor();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {

           return static_cast<PatientCaseItem *>(obj1)->doctor() > static_cast<PatientCaseItem *>(obj2)->doctor();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}



void PatientTreatmentRecordModel::sortByModel(Qt::SortOrder order)
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
