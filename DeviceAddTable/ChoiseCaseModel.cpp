#include "ChoiseCaseModel.h"
#include "patientcaseitem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
#include <chrono>
#include <random>
#include "PatientDb.h"
const static QStringList sHeaderRoles = { "casename","treatment" };
const static QStringList sHeaders={"病/病名","处方名"};
class ChoiseCaseModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};


ChoiseCaseModel::ChoiseCaseModel(QObject *parent) : QuickListModel(parent), d(new ChoiseCaseModelPrivate)
{
    setHeaderRoles(sHeaderRoles);
    setTableHeaders(sHeaders);
}

ChoiseCaseModel::~ChoiseCaseModel(){
    delete d;
}

void ChoiseCaseModel::sortByRole()
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

    default:
        break;
    }
    updateAlternate();
}
void ChoiseCaseModel::initCaseData(){
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
    QString qsql=QString("SELECT * FROM treatmentcase where treatstate='启用'");
        QSqlQuery query;	//执行操作类对象

        //查询数据
     //   query.prepare("SELECT * FROM treatmentcase");
        query.prepare(qsql);
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
           // item->set_regtime(query.value("regtime").toString());
            item->set_online(false);
            objs.append(item);
            qDebug()<<query.value("casename").toString();
        }
        auto c2 = std::chrono::high_resolution_clock::now();
        auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
        //qWarning() << "general" << N << "cost" << micro << "ms";
        resetData(objs);
}

void ChoiseCaseModel::clearAll()
{
    clear();
}


void ChoiseCaseModel::removeRow(int row)
{
    removeAt(row);
}


void ChoiseCaseModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}

void ChoiseCaseModel::sortByName(Qt::SortOrder order)
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

void ChoiseCaseModel::sortByAddress(Qt::SortOrder order)
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

void ChoiseCaseModel::sortByModel(Qt::SortOrder order)
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
