#include "TreatCaseModel.h"

#include "patientcaseitem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
#include <chrono>
#include <random>
#include "PatientDb.h"
const static QStringList treatHeaderRoles = { "casename","treatment","prescriptime","online","checkCase","editCase","caseState" };
const static QStringList treatHeaders={"病名","处方名","开具时间","状态","","",""};
class TreatCaseModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

TreatCaseModel::TreatCaseModel(QObject *parent) : QuickListModel(parent), d(new TreatCaseModelPrivate)
{
    setHeaderRoles(treatHeaderRoles);
    setTableHeaders(treatHeaders);
}

TreatCaseModel::~TreatCaseModel(){
    delete d;
}

void TreatCaseModel::sortByRole()
{
    if (mDatas.count() <= 1) {
        return;
    }
    int index = treatHeaderRoles.indexOf(mSortRole);
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
void TreatCaseModel::initTreatData(){
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();

    /**************************使用QSqlQuery操作数据库**************************/
        QSqlQuery query;	//执行操作类对象

        //查询数据
        query.prepare("SELECT * FROM treatmentcase");
        query.exec();	//执行

        QSqlRecord recode = query.record();		//recode保存查询到一些内容信息，如表头、列数等等
       // int column = recode.count();			//获取读取结果的列数
        QString s1 = recode.fieldName(0);
        while (query.next())
        {
            auto item = new PatientCaseItem;
            item->set_casename(query.value("casename").toString());
            item->set_treatment(query.value("treatmentname").toString());
            item->set_prescriptime(query.value("treatmenttime").toString());
            item->set_tcount(query.value("treatstate").toString());
            item->set_checkCase("查看");
            item->set_editCase("修改");
            item->set_caseState(query.value("treatstate").toString());
           // item->set_regtime(query.value("regtime").toString());
            item->set_online(false);
            objs.append(item);
           // qDebug()<<query.value("casename").toString();
        }
        auto c2 = std::chrono::high_resolution_clock::now();
        auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
       // qWarning() << "general" << N << "cost" << micro << "ms";
        resetData(objs);
}

void TreatCaseModel::addToCase(QString pcase,QString ptreatment, QString doctor)
{
    const int N = 50000;
    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    QDate now=QDate::currentDate();
    addGlTreatmentNew(pcase,ptreatment,now,"启用");

    auto item = new PatientCaseItem;
    item->set_casename(pcase);
    item->set_treatment(ptreatment);
    item->set_doctor(doctor);
    item->set_prescriptime(now.toString());
    item->set_tcount(0);
    item->set_checkCase("查看");
    item->set_editCase("修改");
    item->set_caseState("启用");
   // item->set_regtime(query.value("regtime").toString());
    item->set_online(false);
    objs.append(item);
    append(objs);
}

void TreatCaseModel::clearAll()
{
    clear();
}


void TreatCaseModel::removeRow(int row)
{
    removeAt(row);
}


void TreatCaseModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}

void TreatCaseModel::sortByName(Qt::SortOrder order)
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

void TreatCaseModel::sortByAddress(Qt::SortOrder order)
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

void TreatCaseModel::sortByModel(Qt::SortOrder order)
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


