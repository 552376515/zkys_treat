#include "PatientDb.h"
QSqlDatabase mysql;
QVariant addPatientManager(QSqlQuery &q, const QString &patientname, int patientnum,const QString &gender, int age,const QString &phone, QDate regtime, const QString &doctor)
{
    q.addBindValue(patientname);
    q.addBindValue(patientnum);
    q.addBindValue(gender);
    q.addBindValue(age);
    q.addBindValue(phone);
    q.addBindValue(regtime);
    q.addBindValue(doctor);
    q.exec();
    return q.lastInsertId();
}

QVariant addPatientCase(QSqlQuery &q, const QString &patientname, int patientid, const QString &pcase,  const QString &treatment,const QString &doctor, QDate checkdate, int state)
{
    q.addBindValue(patientname);
    q.addBindValue(patientid);
    q.addBindValue(pcase);
    q.addBindValue(treatment);
    q.addBindValue(doctor);
    q.addBindValue(checkdate);
    q.addBindValue(state);
    q.exec();
     return q.lastInsertId();
}

QVariant addDoctorManager(QSqlQuery &q, const QString &name, QDate birthdate, int managertype)
{
    q.addBindValue(name);
    q.addBindValue(birthdate);
    q.addBindValue(managertype);
    q.exec();
    return q.lastInsertId();
}


QVariant addPatientScript(QSqlQuery &q,  int patientid,  const QString &pprescript,const QString &doctor, QDate prescriptdate)
{

    q.addBindValue(patientid);
    q.addBindValue(pprescript);

    q.addBindValue(doctor);
    q.addBindValue(prescriptdate);

    q.exec();
     return q.lastInsertId();
}

QVariant addGlTreatment(QSqlQuery &q, const QString &casename,const QString &treatmentname,QDate treatmenttime,const QString &treatstate){
    q.addBindValue(casename);
    q.addBindValue(treatmentname);
    q.addBindValue(treatmenttime);
    q.addBindValue(treatstate);
    q.exec();
    return q.lastInsertId();

}

QVariant addGlTreatmentPlan(QSqlQuery &q,const QString &treatmentname,const QString &treatmentbody,const QString &treatmentjingluo){
    q.addBindValue(treatmentname);
    q.addBindValue(treatmentbody);
    q.addBindValue(treatmentjingluo);
    q.exec();
    return q.lastInsertId();
}

const auto PATIENTSMANAGER_SQL = QLatin1String(R"(
                                               create table patientsmanager(id integer primary key, patientname varchar, patientnum integer,gender varchar,
                       age integer, phone varchar, regtime date, doctor varchar)
    )");

const auto PATIENTSCASE_SQL =  QLatin1String(R"(
    create table patientscase(id integer primary key, patientname varchar,patientid integer, pcase varchar, treatment varchar,doctor varchar, checkdate date,state integer)
    )");

const auto DOCTORMANAGER_SQL =  QLatin1String(R"(
    create table doctormanager(id integer primary key, name varchar, birthdate date, managertype integer)
    )");


const auto PATIENTSPRESCRIPT_SQL =  QLatin1String(R"(
    create table patientsprescript(id integer primary key, patientid integer, pprescript varchar, doctor varchar, prescriptdate date)
    )");

const auto GLTREATMENTCASE_SQL = QLatin1String(R"(
    create table treatmentcase(id integer primary key, casename varchar, treatmentname varchar, treatmenttime date, treatstate varchar)
    )");

const auto GLTREATMENTCASEPLAN_SQL = QLatin1String(R"(
    create table treatmentplan(id integer primary key, treatmentname varchar, treatmentbody varchar, treatmentjingluo varchar)
    )");


const auto INSERT_PATIENTSMANAGER_SQL = QLatin1String(R"(
    insert into patientsmanager(patientname,patientnum,gender, age,phone,regtime,doctor) values(?, ?, ?, ?, ?, ?,?)
    )");

const auto INSERT_PATIENTSCASE_SQL = QLatin1String(R"(
    insert into patientscase(patientname,patientid, pcase, treatment,doctor, checkdate, state)
                      values(?, ?, ?, ?, ?,?,?)
    )");

const auto INSERT_DOCTORMANAGER_SQL = QLatin1String(R"(
    insert into doctormanager(name,birthdate,managertype ) values(?,?,?)
    )");


const auto INSERT_PATIENTSPRESCRIPT_SQL = QLatin1String(R"(
    insert into patientsprescript(patientid, pprescript, doctor, prescriptdate)
                      values(?, ?, ?, ?)
    )");

const auto INSERT_GLTREATMENTCASE_SQL =QLatin1String(R"(
    insert into treatmentcase(casename,treatmentname,treatmenttime,treatstate)
                       values(?,?,?,?)
    )");

const auto INSERT_GLTREATMENTCASEPLAN_SQL = QLatin1String(R"(
    insert into treatmentplan(treatmentname,treatmentbody,treatmentjingluo)
                       values(?,?,?)
)");

QSqlError initDb()
{
    mysql = QSqlDatabase::addDatabase("QSQLITE");
    mysql.setDatabaseName(":memory:");

    if (!mysql.open())
        return mysql.lastError();

    QStringList tables = mysql.tables();
    if (tables.contains("patientsManager", Qt::CaseInsensitive)
        && tables.contains("patientCase", Qt::CaseInsensitive))
        return QSqlError();

    QSqlQuery q;
    if (!q.exec(PATIENTSMANAGER_SQL))
        return q.lastError();
    if (!q.exec(PATIENTSCASE_SQL))
        return q.lastError();
    if (!q.exec(DOCTORMANAGER_SQL))
        return q.lastError();

    if (!q.exec(PATIENTSPRESCRIPT_SQL))
        return q.lastError();

    if (!q.exec(GLTREATMENTCASE_SQL))
        return q.lastError();
    if (!q.exec(GLTREATMENTCASEPLAN_SQL))
        return q.lastError();



    if (!q.prepare(INSERT_PATIENTSMANAGER_SQL))
        return q.lastError();
    QDate now=QDate::currentDate();
    //string str1="王小小";
    QVariant asimovId = addPatientManager(q, QStringLiteral("王小小"),1111,QStringLiteral("男"),29,QLatin1String("13500000009"), now,QLatin1String("wang"));
    QVariant greeneId = addPatientManager(q, QStringLiteral("李小小"),1112,QStringLiteral("女"),29,QLatin1String("13500000019"), now,QLatin1String("wang"));
    QVariant pratchettId = addPatientManager(q, QStringLiteral("张小小"),1113,QStringLiteral("女"),29,QLatin1String("13500000029"), now,QLatin1String("wang"));

    if (!q.prepare(INSERT_PATIENTSCASE_SQL))
        return q.lastError();

    QVariant sfiction = addPatientCase(q, QStringLiteral("王小小"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法"),QStringLiteral("王医生"),now,1);
    QVariant fiction = addPatientCase(q, QStringLiteral("王小小"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法1"),QStringLiteral("张医生"),now,1);
    QVariant fantasy = addPatientCase(q, QStringLiteral("王小小"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法2"),QStringLiteral("李医生"),now,1);

    if (!q.prepare(INSERT_DOCTORMANAGER_SQL))
        return q.lastError();
    addDoctorManager(q, QLatin1String("李医生"), QDate(1971,7,18), 3);


    if (!q.prepare(INSERT_PATIENTSPRESCRIPT_SQL))
        return q.lastError();

    addPatientScript(q,1111,QStringLiteral("病情描述详细内容，病情描述详细内容，病情描述详细内容，……"),QStringLiteral("王医生"),QDate(2021,7,15));
    addPatientScript(q,1111,QStringLiteral("病情描述详细内容，病情描述详细内容，病情描述详细内容，……"),QStringLiteral("王医生"),QDate(2021,7,15));

    if (!q.prepare(INSERT_GLTREATMENTCASE_SQL))
        return q.lastError();
    addGlTreatment(q,QStringLiteral("痛风1"),QStringLiteral("经络疗法1"),QDate(1992,1,12),"启用");
    addGlTreatment(q,QStringLiteral("痛风1"),QStringLiteral("经络疗法1"),QDate(1992,1,12),"禁用");

    if (!q.prepare(INSERT_GLTREATMENTCASEPLAN_SQL))
        return q.lastError();
    addGlTreatmentPlan(q,QStringLiteral("经络疗法1"),QStringLiteral("俯卧手向上"),"心包经络");
    addGlTreatmentPlan(q,QStringLiteral("经络疗法1"),QStringLiteral("俯卧手向上"),"心包经络");

    return QSqlError();

}
