#include "PatientCaseListNewModel.h"


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


const static QStringList jHeaderRoles = { "casename","treatment","doctor","checkCase", "editCase","caseState" };
const static QStringList jHeaders={"","","","","",""};
QString patientidbak="";
QString treatmentbak="";
class PatientCaseListNewModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

PatientCaseListNewModel::PatientCaseListNewModel(QObject *parent) : QuickListModel(parent), d(new PatientCaseListNewModelPrivate)
{
    setHeaderRoles(jHeaderRoles);
    setTableHeaders(jHeaders);
}

PatientCaseListNewModel::~PatientCaseListNewModel(){
    delete d;
}

void PatientCaseListNewModel::sortByRole()
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
void PatientCaseListNewModel::initCaseData(){
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();
//    if (!QSqlDatabase::drivers().contains("QSQLITE"))
//       printf("Unable to load database");
    QSqlQuery patientcasequery;

//    // Initialize the database:
//    QSqlError err = initDb();
//    if (err.type() != QSqlError::NoError) {
//        return;
//    }

    /**************************使用QSqlQuery操作数据库**************************/
            //执行操作类对象
// qWarning() << "general" << N << "cost1" << "ms";
        //查询数据
        patientcasequery.prepare("SELECT * FROM patientscasegl");
        patientcasequery.exec();	//执行
// qWarning() << "general" << N << "cost" << "ms";
        QSqlRecord recode = patientcasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
       // int column = recode.count();			//获取读取结果的列数
        QString s1 = recode.fieldName(0);
        while (patientcasequery.next())
        {
            auto item = new PatientCaseItem;
            item->set_casename(patientcasequery.value("directlay").toString());
            item->set_treatment(patientcasequery.value("jingluo").toString());
            item->set_doctor("");
            item->set_checkCase("1");
            item->set_editCase("1");
            item->set_caseState("1");
           // item->set_regtime(query.value("regtime").toString());
            item->set_online(false);
            objs.append(item);
//           qWarning() << "general" << N << "cost" << item->casename() << "ms";

        }
        auto c2 = std::chrono::high_resolution_clock::now();
        auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
        //qWarning() << "general" << N << "cost" << micro << "ms";
        resetData(objs);
}

void PatientCaseListNewModel::updateCase(){
     emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}
void PatientCaseListNewModel::loadCaseDataByPatientNo(QString patientid,QString treatment){
    if (patientid==patientidbak && treatment==treatmentbak){
        return;
    }
    patientidbak=patientid;
    treatmentbak=treatment;
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    QSqlQuery patientcasequery;
    auto c1 = std::chrono::high_resolution_clock::now();
   // QString qsql="SELECT * FROM patientscasegl where patientid=";
     QString qsql=QString("SELECT * FROM patientscasegl where patientid='%1' and treatment='%2'").arg(patientid).arg(treatment);
  //  clearAll();
    patientcasequery.prepare(qsql);
    patientcasequery.exec();	//执行
//    qDebug()<<qsql;
// qWarning() << "general" << N << "cost" << "ms";
    QSqlRecord recode = patientcasequery.record();		//recode保存查询到一些内容信息，如表头、列数等等
   // int column = recode.count();			//获取读取结果的列数
    QString s1 = recode.fieldName(0);
    while (patientcasequery.next())
    {
        auto item = new PatientCaseItem;
        item->set_casename(patientcasequery.value("directlay").toString());
        item->set_treatment(patientcasequery.value("jingluo").toString());
        item->set_doctor("");
        item->set_checkCase("1");
        item->set_editCase("1");
        item->set_caseState("1");
       // item->set_regtime(query.value("regtime").toString());
        item->set_online(false);
        objs.append(item);
 //          qWarning() << "general" << N << "cost" << item->casename() << "ms";

    }
    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
    mDatas=objs;
    updateCase();

}

void PatientCaseListNewModel::changeDataByIndex(int index){
    QList<QuickListItemBase *> copyObjs = mDatas;
    for (int i=0;i<copyObjs.count();i++){
        PatientCaseItem *tmpmodel=dynamic_cast<PatientCaseItem *>(copyObjs.at(i));
        if (index==0){
            tmpmodel->set_checkCase("1");
            tmpmodel->set_editCase("1");
           // tmpmodel->set_caseState("1");
        }else {
            tmpmodel->set_checkCase("0");
            tmpmodel->set_editCase("0");
        }

    }
    if (index==1){
        sortByAddress(Qt::SortOrder::AscendingOrder);

    }
    if (index==2){

        sortByAddress1(Qt::SortOrder::AscendingOrder);
    }

}

void PatientCaseListNewModel::addModel(const PatientCaseItem &paraModel)
{


}


void PatientCaseListNewModel::addCaseData(QString dataStr,int index){


    QStringList list;
    const int N = 5;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);

    QStringList arr=dataStr.split(" ");
    if (arr.length()==2){
         auto item = new PatientCaseItem;
         item->set_casename(arr[0]);
         item->set_treatment(arr[1]);
         item->set_doctor("");
          item->set_caseState("1");
         if (index==0){

             item->set_checkCase("1");
             item->set_editCase("1");

         }else{
             item->set_checkCase("0");
             item->set_editCase("0");
         }
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

void PatientCaseListNewModel::swapRow(int from,int to){
    if (from!=to && from>=0<mDatas.count() && to>=0 && to<mDatas.count()){
        beginMoveRows(QModelIndex(),from,from,
                      QModelIndex(),from>to?(to):(to+1));
        auto item=mDatas.takeAt(from);
        mDatas.insert(to,item);
        endMoveRows();
        updateCalcInfo();
    }
}

void PatientCaseListNewModel::addToPatientCaseGl(QString pno,QString ptreatment)
{
    QList<QuickListItemBase *> copyObjs = mDatas;

    QDate now=QDate::currentDate();
    for (int i=0;i<copyObjs.count();i++){
        //QDebug()<<"addToPatientCaseGl"<<i;
        PatientCaseItem *tmpmodel=dynamic_cast<PatientCaseItem *>(copyObjs.at(i));
        addPatientCaseGLNew(pno.toInt(),ptreatment,tmpmodel->casename(),tmpmodel->treatment(),now);

    }
}

void PatientCaseListNewModel::clearAll()
{
    clear();
}


void PatientCaseListNewModel::removeRow(int row)
{
    removeAt(row);
}


void PatientCaseListNewModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}



void PatientCaseListNewModel::sortByName(Qt::SortOrder order)
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

void PatientCaseListNewModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    const static QStringList zitaiList = { "足少阴肾经(体前)","手厥阴心包经","足少阳胆经","足厥阴肝经", "手太阴肺经","足阳明胃经", "足太阴脾经1","足太阴脾经2", "手少阴心经", "手少阳三焦经", "手阳明大肠经", "手太阳小肠经", "足太阳膀胱经1","足太阳膀胱经2", "足少阴肾经(体后)" };

    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            const QString q1=static_cast<PatientCaseItem *>(obj1)->treatment();
            const QString q2=static_cast<PatientCaseItem *>(obj2)->treatment();
            return zitaiList.indexOf(q1) < zitaiList.indexOf(q2);

        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            const QString q1=static_cast<PatientCaseItem *>(obj1)->treatment();
            const QString q2=static_cast<PatientCaseItem *>(obj2)->treatment();
            return zitaiList.indexOf(q1) > zitaiList.indexOf(q2);
           // return static_cast<PatientCaseItem *>(obj1)->treatment() > static_cast<PatientCaseItem *>(obj2)->treatment();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void PatientCaseListNewModel::sortByAddress1(Qt::SortOrder order)
{
    const static QStringList shengxiList = { "足少阴肾经(体前)","手厥阴心包经","手少阳三焦经","足少阳胆经","足厥阴肝经", "手太阴肺经", "手阳明大肠经","足阳明胃经", "足太阴脾经1","足太阴脾经2", "手少阴心经",  "手太阳小肠经", "足太阳膀胱经1","足太阳膀胱经2", "足少阴肾经(体后)" };

    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            const QString q1=static_cast<PatientCaseItem *>(obj1)->treatment();
            const QString q2=static_cast<PatientCaseItem *>(obj2)->treatment();
            return shengxiList.indexOf(q1) < shengxiList.indexOf(q2);
           // return static_cast<PatientCaseItem *>(obj1)->treatment() < static_cast<PatientCaseItem *>(obj2)->treatment();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            const QString q1=static_cast<PatientCaseItem *>(obj1)->treatment();
            const QString q2=static_cast<PatientCaseItem *>(obj2)->treatment();
            return shengxiList.indexOf(q1) > shengxiList.indexOf(q2);
           // return static_cast<PatientCaseItem *>(obj1)->treatment() > static_cast<PatientCaseItem *>(obj2)->treatment();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}


void PatientCaseListNewModel::sortByModel(Qt::SortOrder order)
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
