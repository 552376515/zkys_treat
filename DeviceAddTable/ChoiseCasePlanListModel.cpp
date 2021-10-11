#include "ChoiseCasePlanListModel.h"
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
#include <QDebug>


const static QStringList jHeaderRoles = { "casename","treatment" };
const static QStringList jHeaders={"",""};
QString patientnobak="";
QString casetreatmentbak="";
bool choisefirstenter=false;
class ChoiseCasePlanListModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

ChoiseCasePlanListModel::ChoiseCasePlanListModel(QObject *parent) : QuickListModel(parent), d(new ChoiseCasePlanListModelPrivate)
{
    setHeaderRoles(jHeaderRoles);
    setTableHeaders(jHeaders);
}

ChoiseCasePlanListModel::~ChoiseCasePlanListModel(){
    delete d;
}

void ChoiseCasePlanListModel::sortByRole()
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
    case 4: {
        sortByModel(mSortOrder);
        break;
    }
    default:
        break;
    }
    updateAlternate();
}

void ChoiseCasePlanListModel::updateCase(){
     emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}
void ChoiseCasePlanListModel::loadCaseDataByCaseTreatment(QString casename,QString treatment){

    // qDebug() << "general" << casename << "cost" << treatment;
    if (patientnobak==casename && treatment==casetreatmentbak){
        return;
    }
  //   qDebug() << "general1" << casename << "cost1" << treatment;
    patientnobak=casename;
    casetreatmentbak=treatment;
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    QSqlQuery patientcasequery;
    auto c1 = std::chrono::high_resolution_clock::now();
   // QString qsql="SELECT * FROM patientscasegl where patientid=";
     QString qsql=QString("SELECT * FROM treatmentplan where casename='%1' and treatmentname='%2'").arg(casename).arg(treatment);
    patientcasequery.prepare(qsql);
    patientcasequery.exec();	//执行
   // qDebug()<<qsql;
// qWarning() << "general" << N << "cost" << "ms";
    QSqlRecord recode = patientcasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
   // int column = recode.count();			//获取读取结果的列数
    QString s1 = recode.fieldName(0);
    while (patientcasequery.next())
    {
        auto item = new PatientCaseItem;
        item->set_casename(patientcasequery.value("treatmentbody").toString());
        item->set_treatment(patientcasequery.value("treatmentjingluo").toString());
        objs.append(item);
     //      qWarning() << "general" << N << "cost" << item->casename() << "ms";

    }
    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();

    if (choisefirstenter){
        mDatas.clear();
        insert(0,objs);
        updateCase();
    }else {
        choisefirstenter=true;
        resetData(objs);
    }


}



void ChoiseCasePlanListModel::addToPatientCaseChoise(QString patientId,QString ptreatment)
{
    QList<QuickListItemBase *> copyObjs = mDatas;

    QDate now=QDate::currentDate();
    for (int i=0;i<copyObjs.count();i++){
        //QDebug()<<"addToPatientCaseGl"<<i;
        PatientCaseItem *tmpmodel=dynamic_cast<PatientCaseItem *>(copyObjs.at(i));
        addPatientCaseGLNew(patientId.toInt(),ptreatment,tmpmodel->casename(),tmpmodel->treatment(),now);

    }
}

void ChoiseCasePlanListModel::clearAll()
{
    clear();
}


void ChoiseCasePlanListModel::removeRow(int row)
{
    removeAt(row);
}


void ChoiseCasePlanListModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}



void ChoiseCasePlanListModel::sortByName(Qt::SortOrder order)
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

void ChoiseCasePlanListModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    const static QStringList zitaiList = { "足少阴肾经(体前)","手厥阴心包经","足少阳胆经","足厥阴肝经", "手太阴肺经","足阳明胃经", "足太阴脾经1","足太阴脾经2", "手少阴心经", "手少阳三焦经", "手阳明大肠经", "手太阳小肠经", "足太阳膀胱经1","足太阳膀胱经2", "足少阴肾经(体后)" };

    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            const QString q1=static_cast<PatientCaseItem *>(obj1)->treatment();
            const QString q2=static_cast<PatientCaseItem *>(obj2)->treatment();
          //  return zitaiList.indexOf(q1) < zitaiList.indexOf(q2);
            return static_cast<PatientCaseItem *>(obj1)->treatment() < static_cast<PatientCaseItem *>(obj2)->treatment();

        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            const QString q1=static_cast<PatientCaseItem *>(obj1)->treatment();
            const QString q2=static_cast<PatientCaseItem *>(obj2)->treatment();
           // return zitaiList.indexOf(q1) > zitaiList.indexOf(q2);
            return static_cast<PatientCaseItem *>(obj1)->treatment() > static_cast<PatientCaseItem *>(obj2)->treatment();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}




void ChoiseCasePlanListModel::sortByModel(Qt::SortOrder order)
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
