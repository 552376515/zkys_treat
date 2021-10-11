#include "GLPatientManagerModel.h"
#include "DeviceAddItem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
#include <chrono>
#include <random>
#include <QDateTime>
#include <QDate>
#include "PatientDb.h"

#include "xlsxabstractsheet.h"
#include "xlsxcell.h"
#include "xlsxcellrange.h"
#include "xlsxcellreference.h"



#include "xlsxchartsheet.h"
#include "xlsxcellrange.h"
#include "xlsxchart.h"
#include "xlsxrichstring.h"
#include "xlsxworkbook.h"

const static QString nameTemplate("item %1");
const static QString ipTemplate("%1.%2.%3.%4");
const static QString modelTemplate("model %1");
const static QStringList glHeaderRoles = { "name","pno","gender", "age","phone", "regtime" ,"lasttreattime","binddoctor"};
const static QStringList glHeaders={"姓名","编号","性别","年龄","手机号","注册时间","最后调理时间","绑定医生"};
const static QStringList excelHead={"A","B","C","D","E","F","G","H"};
const auto INSERT_PATIENTSMANAGER_SQL = QLatin1String(R"(
    insert into patientsmanager(patientname,patientnum,gender, age,phone,regtime,doctor,lasttreattime) values(?, ?, ?, ?, ?, ?,?,?)
    )");
class GLPatientManagerModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};

GLPatientManagerModel::GLPatientManagerModel(QObject *parent) : QuickListModel(parent), d(new GLPatientManagerModelPrivate)
{
    setHeaderRoles(glHeaderRoles);
    setTableHeaders(glHeaders);
}

GLPatientManagerModel::~GLPatientManagerModel()
{
    delete d;
}

void GLPatientManagerModel::sortByRole()
{
    if (mDatas.count() <= 1) {
        return;
    }
    int index = glHeaderRoles.indexOf(mSortRole);
    switch (index) {
    case 0: {
        sortByName(mSortOrder);
        break;
    }
    case 1: {
        sortByAddress(mSortOrder);
        break;
    }
    case 2: {
        sortByModel(mSortOrder);
        break;
    }
    default:
        break;
    }
    updateAlternate();
}
void GLPatientManagerModel::initData()
{
    const int N = 50000;

    QList<QuickListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();
    if (!QSqlDatabase::drivers().contains("QSQLITE"))
       printf("Unable to load database");


    // Initialize the database:
    QSqlError err = initDb();
    if (err.type() != QSqlError::NoError) {
        return;
    }
#if 1
    /**************************使用QSqlQuery操作数据库**************************/
        QSqlQuery query;	//执行操作类对象

        //查询数据
        query.prepare("SELECT * FROM patientsmanager");
        query.exec();	//执行

        QSqlRecord recode = query.record();		//recode保存查询到一些内容信息，如表头、列数等等
        int column = recode.count();			//获取读取结果的列数
        QString s1 = recode.fieldName(0);		//获取第0列的列名

        while (query.next())
        {
            auto item = new DeviceAddItem;
            item->set_name( query.value("patientname").toString());
            item->set_pno(query.value("patientnum").toString());
            item->set_age(query.value("age").toString());
            item->set_gender(query.value("gender").toString());
            item->set_phone(query.value("phone").toString());
            item->set_regtime(query.value("regtime").toString());
            item->set_online(false);
            item->set_binddoctor(query.value("doctor").toString());
            item->set_lasttreattime(query.value("lasttreattime").toString());
            objs.append(item);
            qDebug()<<query.value("patientname").toString();
        }
#else

#endif
    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
   // qWarning() << "general" << N << "cost" << micro << "ms";
    resetData(objs);
}

void GLPatientManagerModel::addOne(const QString patientStr)
{
    const QStringList list=patientStr.split("@");
    if (list.length()==5){
        auto item = new DeviceAddItem;
        item->set_name(list[0]);
        item->set_gender(list[1]);
        item->set_age(list[2]);
        item->set_phone(list[3]);
        QString pno=QString("%1").arg(mDatas.length(),0,10);
        item->set_pno(pno);
        QString doctor=list[4];
        QDateTime now=QDateTime::currentDateTime();
        QDate now1=QDate::currentDate();
        QString qstr=now1.toString("yyyyMMdd");
        item->set_regtime(qstr);
        append({ item });
        QSqlQuery query;	//执行操作类对象
        if (!query.prepare(INSERT_PATIENTSMANAGER_SQL)){
            return;
        }
        QVariant asimovId = addPatientManager(query,item->name(),mDatas.length(),item->gender(),item->age().toInt(),item->phone(),now1,"wang",now1);

    }


    //auto item = genOne(d->u65535(d->randomEngine));
    //append({ item });
}

void GLPatientManagerModel::addMulti(int count)
{
    QList<QuickListItemBase *> objs;
    objs.reserve(count);

    for (int i = 0; i < count; ++i) {
        auto item = genOne(d->u65535(d->randomEngine));
        objs.push_back(item);
        //        if (i % 5 == 0)
        //        {
        //            qApp->processEvents(QEventLoop::ExcludeUserInputEvents);
        //        }
    }
    append(objs);
}

void GLPatientManagerModel::readExcelToGl(QString filaname){


  //  qDebug()<<"inout="<<filaname;
    QXlsx::Document xlsx("excelbook.xlsx");
    int row=xlsx.dimension().lastRow();
    int col=xlsx.dimension().lastColumn();
 //   qDebug()<<"xlsx col="<<col;
 //   qDebug()<<"xlsx row="<<row;


    for (int i = 2; i <= row; ++i) {
        QStringList lists;
        for (int j=1;j<=col;j++){
            if (QXlsx::Cell *cell = xlsx.cellAt(i, j)){
                QVariant curvar=cell->value();
                lists<<curvar.toString();
                 //        qDebug() << cell->value();
            }
        }
        auto item = new DeviceAddItem;
        item->set_name(lists[0]);
        item->set_pno(lists[1]);
        item->set_gender(lists[2]);
        item->set_age(lists[3]);
        item->set_phone(lists[4]);
        item->set_regtime(lists[5]);
        item->set_lasttreattime(lists[6]);
        item->set_binddoctor(lists[7]);
        append({ item });
        QSqlQuery query;	//执行操作类对象
        if (!query.prepare(INSERT_PATIENTSMANAGER_SQL)){
            return;
        }
        QVariant asimovId = addPatientManager(query,item->name(),mDatas.length(),item->gender(),item->age().toInt(),item->phone(),QDate::fromString(item->regtime()),item->binddoctor(),QDate::fromString(item->lasttreattime()));
    }
}


void GLPatientManagerModel::insertBeforeSelected()
{
    if (mDatas.count() <= 0) {
        auto item = genOne(d->u65535(d->randomEngine));
        insert(0, { item });
    } else {
        int pos = -1;
        for (int i = 0; i < mDatas.count(); ++i) {
            const auto &obj = mDatas.at(i);
            if (obj->isVisible() && obj->isSelected()) {
                pos = i;
                break;
            }
        }
        if (pos >= 0) {
            auto item = genOne(d->u65535(d->randomEngine));
            insert(pos, { item });
        }
    }
}

void GLPatientManagerModel::insertBeforeRow(int row)
{
    auto item = genOne(d->u65535(d->randomEngine));
    insert(row, { item });
}

void GLPatientManagerModel::clearAll()
{
    clear();
}

void GLPatientManagerModel::removeSelected()
{
    for (int i = 0; i < mDatas.count();) {
        const auto &obj = mDatas.at(i);
        if (obj->isVisible() && obj->isSelected()) {
            removeAt(i);
        } else {
            ++i;
        }
    }
}

void GLPatientManagerModel::removeChecked()
{
    for (int i = 0; i < mDatas.count();) {
        const auto &obj = mDatas.at(i);
        if (obj->isVisible() && obj->isChecked()) {
            removeAt(i);
        } else {
            ++i;
        }
    }
}

void GLPatientManagerModel::removeRow(int row)
{
    removeAt(row);
}

void GLPatientManagerModel::sortByName(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->name() < (static_cast<DeviceAddItem *>(obj2))->name();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->name() > (static_cast<DeviceAddItem *>(obj2))->name();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void GLPatientManagerModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<DeviceAddItem *>(obj1)->toIPv4Address() < static_cast<DeviceAddItem *>(obj2)->toIPv4Address();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<DeviceAddItem *>(obj1)->toIPv4Address() > static_cast<DeviceAddItem *>(obj2)->toIPv4Address();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void GLPatientManagerModel::sortByModel(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->regtime().toULongLong() < (static_cast<DeviceAddItem *>(obj2))->regtime().toULongLong();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->regtime().toULongLong() > (static_cast<DeviceAddItem *>(obj2))->regtime().toULongLong();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

DeviceAddItem *GLPatientManagerModel::genOne(uint32_t value)
{
    auto item = new DeviceAddItem;
    item->set_online(value % 2 == 0);
    item->set_name(nameTemplate.arg(value));

    int ip4 = value % 256;
    int ip3 = value / 256 % 256;
    int ip2 = value / 256 / 256 % 256;
    int ip1 = value / 256 / 256 / 256 % 256;
    item->set_phone(ipTemplate.arg(ip1).arg(ip2).arg(ip3).arg(ip4));
    item->set_regtime(modelTemplate.arg(value % 2 == 0 ? value : 0xffffffff - value));
    return item;
}
void GLPatientManagerModel::doUpdateName(int row, const QString &name)
{
    if (row < 0 || row >= rowCount({})) {
        return;
    }
    const auto &n = name.simplified();
    if (n.isEmpty()) {
        return;
    }
    static_cast<DeviceAddItem *>(mDatas.at(row))->set_name(name);
}

void GLPatientManagerModel::writeGlToExcel(QString filename){

            // Create a new .xlsx file.
            QXlsx::Document xlsx1;
//            xlsx1.write("A1", "Hello Qt!");
//            xlsx1.write("A2", 12345);
//            xlsx1.write("A3", "=44+33");
//            xlsx1.write("A4", true);
//            xlsx1.write("A5", "http://qt-project.org");
//            xlsx1.write("A6", QDate(2013, 12, 27));
//            xlsx1.write("A7", QTime(6, 30));
//            xlsx1.saveAs("./Book1.xlsx");
            for (int i=0;i<glHeaders.count();i++){
                QString aa=glHeaders[i];
                QString name=excelHead[i];
                name.append("1");
                xlsx1.write(name,aa);


            }
            if (mDatas.count() <= 0) {
                qDebug()<<"mDatas.count() is null!";
            }
            else
            {
                for (int i = 0; i < mDatas.count(); ++i) {
                    const auto &obj = mDatas.at(i);
                    //if (obj->isVisible() && obj->isChecked())
                    {
                        auto name= static_cast<DeviceAddItem *>(obj)->name();
                        auto phone= static_cast<DeviceAddItem *>(obj)->phone();
                        auto regtime= static_cast<DeviceAddItem *>(obj)->regtime();
                        auto pno=static_cast<DeviceAddItem *>(obj)->pno();
                        auto gender=static_cast<DeviceAddItem *>(obj)->gender();
                        auto age=static_cast<DeviceAddItem *>(obj)->age();
                        auto lasttime=static_cast<DeviceAddItem *>(obj)->lasttreattime();
                        auto binddoctor=static_cast<DeviceAddItem *>(obj)->binddoctor();
                        QString namea=excelHead[0];
                        namea.append(QString::number(i+2));
                        QString nameb=excelHead[1];
                        nameb.append(QString::number(i+2));
                        QString namec=excelHead[2];
                        namec.append(QString::number(i+2));
                        QString named=excelHead[3];
                        named.append(QString::number(i+2));
                        QString namee=excelHead[4];
                        namee.append(QString::number(i+2));
                        QString namef=excelHead[5];
                        namef.append(QString::number(i+2));
                        QString nameg=excelHead[6];
                        nameg.append(QString::number(i+2));
                        QString nameh=excelHead[7];
                        nameh.append(QString::number(i+2));



                        xlsx1.write(namea,name);
                        xlsx1.write(nameb,pno);
                        xlsx1.write(namec,gender);
                        xlsx1.write(named,age);
                        xlsx1.write(namee,phone);
                        xlsx1.write(namef,regtime);
                        xlsx1.write(nameg,lasttime);
                        xlsx1.write(nameh,binddoctor);

                    }
                }
            }
             xlsx1.saveAs("./out1.xlsx");

}
void GLPatientManagerModel::saveTxtItems()
{
    QFile file("testdata.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug()<<"testdata.txt no exit!";
        return ;
    }

    QTextStream out(&file);
    qDebug()<<"saveTxtItems--->mDatas.count()"<< mDatas.count();
    if (mDatas.count() <= 0) {
        qDebug()<<"mDatas.count() is null!";
    }
    else
    {
        for (int i = 0; i < mDatas.count(); ++i) {
            const auto &obj = mDatas.at(i);
            if (obj->isVisible() && obj->isChecked())
            {
                auto name= static_cast<DeviceAddItem *>(obj)->name();
                auto phone= static_cast<DeviceAddItem *>(obj)->phone();
                auto regtime= static_cast<DeviceAddItem *>(obj)->regtime();
                auto pno=static_cast<DeviceAddItem *>(obj)->pno();
                auto gender=static_cast<DeviceAddItem *>(obj)->gender();
                auto age=static_cast<DeviceAddItem *>(obj)->age();
                auto lasttime=static_cast<DeviceAddItem *>(obj)->lasttreattime();
                auto binddoctor=static_cast<DeviceAddItem *>(obj)->binddoctor();

              //  qDebug()<<"saveTxtItems--->name"<< name;
                out << name << ";"
                    << pno <<";"
                    << gender <<";"
                    << age <<";"
                    << phone << ";"
                    << regtime << ";"
                    << lasttime <<";"
                    << binddoctor <<";"
                    << "\n";
            }
        }
    }
}

void GLPatientManagerModel::genTxtItems()
{
    QList<QuickListItemBase *> objs;
//    objs.reserve(count);

    QFile file("testdata.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug()<<"testdata.txt no exit!";
        return ;
    }
    QTextStream in(&file);
    while (!in.atEnd())
    {
        QString line = in.readLine();
        auto words=line.split(';', QString::SkipEmptyParts);
        int count = 0;
        for(auto word:words){
            word=word.trimmed();
            ++count;
        }
        qDebug()<<"count"<<count;

        if(count == 3)
        {
            auto item = new DeviceAddItem;
            item->set_name(nameTemplate.arg(words[0]));
            auto ip=words[1].split('.', QString::SkipEmptyParts);
            int ipcount = 0;
            for(auto ipitem:ip){
                ipitem=ipitem.trimmed();
                ++ipcount;
            }
            qDebug()<<"ip"<<ip;
            if(ipcount==4)
            {
                item->set_phone(ipTemplate.arg(ip[0])
                                            .arg(ip[1])
                                            .arg(ip[2])
                                            .arg(ip[3]));
            }
            item->set_regtime(modelTemplate.arg(words[2]));
            objs.append(item);
        }
    }
    qDebug()<<"append(objs)";
    append(objs);
}
