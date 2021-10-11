#include "DoctorManagerModel.h"


#include "DoctorManageItem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
#include <chrono>
#include <random>
#include "PatientDb.h"
const static QStringList dHeaderRoles = { "name","doctorid","regtime", "doctorstate","managertype","doctorspace","resetpwd","editpwd" ,"dstate"};
const static QStringList dHeaders={"姓名","编号","注册时间","状态","角色","","","",""};

class DoctorManagerModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

DoctorManagerModel::DoctorManagerModel(QObject *parent) : QuickListModel(parent), d(new DoctorManagerModelPrivate)
{
    setHeaderRoles(dHeaderRoles);
    setTableHeaders(dHeaders);
}

DoctorManagerModel::~DoctorManagerModel(){
    delete d;
}

void DoctorManagerModel::sortByRole()
{
    if (mDatas.count() <= 1) {
        return;
    }
    int index = dHeaderRoles.indexOf(mSortRole);
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
void DoctorManagerModel::initCaseData(){
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
        QSqlQuery query;	//执行操作类对象

        //查询数据
        query.prepare("SELECT * FROM doctormanager");
        query.exec();	//执行

        QSqlRecord recode = query.record();		//recode保存查询到一些内容信息，如表头、列数等等
       // int column = recode.count();			//获取读取结果的列数
        QString s1 = recode.fieldName(0);
        while (query.next())
        {
            auto item = new DoctorManageItem;
            item->set_name(query.value("name").toString());
            item->set_doctorid(query.value("doctorid").toString());
            item->set_doctorstate(query.value("doctorstate").toString());
            item->set_regtime(query.value("regtime").toString());
            item->set_managertype(query.value("managertype").toString());
            item->set_dstate(query.value("doctorstate").toString());
            item->set_resetpwd("reset");
            item->set_editpwd("modify");

           // item->set_regtime(query.value("regtime").toString());

            objs.append(item);
           // qDebug()<<query.value("patientname").toString();
        }
        auto c2 = std::chrono::high_resolution_clock::now();
        auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
        //qWarning() << "general" << N << "cost" << micro << "ms";
        resetData(objs);
}

void DoctorManagerModel::updateData()
{
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void DoctorManagerModel::modifyDoctorPwd(QString doctorid,QString newpwd){
    QSqlQuery docquery;	//执行操作类对象
    QString qsql=QString("UPDATE doctormanager set docpassword='%1' where doctorid='%2'").arg(newpwd).arg(doctorid);
   docquery.prepare(qsql);
   docquery.exec();	//执行
}

void DoctorManagerModel::resetAllDocPwd(){
    QSqlQuery docquery;	//执行操作类对象
    QString qsql=QString("UPDATE doctormanager set docpassword='111111'");
   docquery.prepare(qsql);
   docquery.exec();	//执行
}

void DoctorManagerModel::forbidUser(QString doctorid){
    QList<QuickListItemBase *> copyObjs = mDatas;
    for (int i=0;i<copyObjs.count();i++){
        DoctorManageItem *tmpmodel=dynamic_cast<DoctorManageItem *>(copyObjs.at(i));
         qDebug()<<"forbidUserid="<<doctorid<<" doctrid="<<tmpmodel->doctorid();
        if (tmpmodel->doctorid()==doctorid){
            qDebug()<<"forbidUserid===="<<tmpmodel->doctorstate();


            if (tmpmodel->doctorstate()==QStringLiteral("启用")){
                tmpmodel->set_doctorstate(QStringLiteral("禁用"));
                tmpmodel->set_dstate(QStringLiteral("禁用"));
            }else {
                tmpmodel->set_doctorstate(QStringLiteral("启用"));
                tmpmodel->set_dstate(QStringLiteral("启用"));
            }

        }

    }
    mDatas=copyObjs;
    updateData();

}

void DoctorManagerModel::clearAll()
{
    clear();
}


void DoctorManagerModel::removeRow(int row)
{
    removeAt(row);
}


void DoctorManagerModel::insertBeforeRow(int row)
{
//    auto item = genOne(d->u65535(d->randomEngine));
//    insert(row, { item });
}

void DoctorManagerModel::sortByName(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DoctorManageItem *>(obj1))->name() < (static_cast<DoctorManageItem *>(obj2))->name();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DoctorManageItem *>(obj1))->name() > (static_cast<DoctorManageItem *>(obj2))->name();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void DoctorManagerModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<DoctorManageItem *>(obj1)->doctorid() < static_cast<DoctorManageItem *>(obj2)->doctorid();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<DoctorManageItem *>(obj1)->doctorid() > static_cast<DoctorManageItem *>(obj2)->doctorid();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void DoctorManagerModel::sortByModel(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DoctorManageItem *>(obj1))->regtime().toULongLong() < (static_cast<DoctorManageItem *>(obj2))->regtime().toULongLong();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DoctorManageItem *>(obj1))->regtime().toULongLong() > (static_cast<DoctorManageItem *>(obj2))->regtime().toULongLong();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}
