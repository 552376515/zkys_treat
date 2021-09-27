#include "PatientDb.h"
QSqlDatabase mysql;

const auto PATIENTSMANAGER_SQL = QLatin1String(R"(
                                               create table patientsmanager(id integer primary key, patientname varchar, patientnum integer,gender varchar,
                       age integer, phone varchar, regtime date, doctor varchar,lasttreattime varchar)
    )");

const auto PATIENTSCASE_SQL =  QLatin1String(R"(
    create table patientscase(id integer primary key, patientname varchar,patientid integer, pcase varchar, treatment varchar,doctor varchar, checkdate date,state integer,treatdate date)
    )");

const auto DOCTORMANAGER_SQL =  QLatin1String(R"(
    create table doctormanager(id integer primary key, name varchar, doctorid varchar, regtime date,doctorstate int,  managertype integer)
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

const auto PATIENTSCASEGL_SQL =  QLatin1String(R"(
    create table patientscasegl(id integer primary key, patientid integer, treatment varchar,directlay varchar,jingluo varchar, treatdate date)
    )");

const auto INSERT_PATIENTSMANAGER_SQL = QLatin1String(R"(
    insert into patientsmanager(patientname,patientnum,gender, age,phone,regtime,doctor,lasttreattime) values(?, ?, ?, ?, ?, ?,?,?)
    )");

const auto INSERT_PATIENTSCASE_SQL = QLatin1String(R"(
    insert into patientscase(patientname,patientid, pcase, treatment,doctor, checkdate, state,treatdate)
                      values(?, ?, ?, ?, ?,?,?,?)
    )");

const auto INSERT_DOCTORMANAGER_SQL = QLatin1String(R"(
    insert into doctormanager(name,doctorid,regtime,doctorstate,managertype ) values(?,?,?,?,?)
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

const auto INSERT_PATIENTSCASEGL_SQL =  QLatin1String(R"(
    insert into patientscasegl(patientid, treatment,directlay ,jingluo, treatdate)
                        values(?,?,?,?,?)
    )");

QVariant addPatientManager(QSqlQuery &q, const QString &patientname, int patientnum,const QString &gender, int age,const QString &phone, QDate regtime, const QString &doctor,const QDate &lasttreattime)
{
    q.addBindValue(patientname);
    q.addBindValue(patientnum);
    q.addBindValue(gender);
    q.addBindValue(age);
    q.addBindValue(phone);
    q.addBindValue(regtime);
    q.addBindValue(doctor);
    q.addBindValue(lasttreattime);
    q.exec();
    return q.lastInsertId();
}

QVariant addPatientCase(QSqlQuery &q, const QString &patientname, int patientid, const QString &pcase,  const QString &treatment,const QString &doctor, QDate checkdate, int state ,QDate treatdate)
{
    q.addBindValue(patientname);
    q.addBindValue(patientid);
    q.addBindValue(pcase);
    q.addBindValue(treatment);
    q.addBindValue(doctor);
    q.addBindValue(checkdate);
    q.addBindValue(state);
    q.addBindValue(treatdate);
    q.exec();
     return q.lastInsertId();
}
void addPatientCaseNew(const QString &patientname, int patientid, const QString &pcase,  const QString &treatment,const QString &doctor, QDate checkdate, int state ,QDate treatdate)
{
    QSqlQuery q;
    if (q.prepare(INSERT_PATIENTSCASE_SQL))
    {

      QVariant qq= addPatientCase(q,patientname,patientid,pcase,treatment,doctor,checkdate,state,treatdate);
    }
}
QVariant addPatientCaseGL(QSqlQuery &q, int patientid, const QString &treatment,  const QString &directlay,const QString &jingluo, QDate treatdate)
{

    q.addBindValue(patientid);
    q.addBindValue(treatment);
    q.addBindValue(directlay);

    q.addBindValue(jingluo);
    q.addBindValue(treatdate);
    q.exec();
     return q.lastInsertId();
}
void addPatientCaseGLNew( int patientid, const QString &treatment,  const QString &directlay,const QString &jingluo, QDate treatdate){
    QSqlQuery q;
    if (q.prepare(INSERT_PATIENTSCASEGL_SQL)){
      //  qDebug()<<"patientid="<<patientid<<"treatment="<<treatment;
        addPatientCaseGL(q,patientid,treatment.toUtf8(),directlay.toUtf8(),jingluo.toUtf8(),treatdate);
      //  qDebug()<<"patientid1111="<<patientid<<"treatment="<<treatment;
    }
}



QVariant addDoctorManager(QSqlQuery &q, const QString &name, const QString doctorid, QDate regtime, const QString doctorstate, const QString managertype)
{
    //   create table doctormanager(id integer primary key, name varchar, doctorid varchar, regtime date,doctorstate int,  managertype integer)

    q.addBindValue(name);
    q.addBindValue(doctorid);
    q.addBindValue(regtime);
    q.addBindValue(doctorstate);
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
void addGlTreatmentNew(const QString &casename,const QString &treatmentname,QDate treatmenttime,const QString &treatstate){
     QSqlQuery q;
     if (q.prepare(INSERT_GLTREATMENTCASE_SQL)){
         addGlTreatment(q,casename,treatmentname,treatmenttime,treatstate);
     }
}

QVariant addGlTreatmentPlan(QSqlQuery &q,const QString &treatmentname,const QString &treatmentbody,const QString &treatmentjingluo){
    q.addBindValue(treatmentname);
    q.addBindValue(treatmentbody);
    q.addBindValue(treatmentjingluo);
    q.exec();
    return q.lastInsertId();
}

void addGlTreatmentPlanNew(const QString &treatmentname,const QString &treatmentbody,const QString &treatmentjingluo){
    QSqlQuery q;
    if (q.prepare(INSERT_GLTREATMENTCASEPLAN_SQL)){
        addGlTreatmentPlan(q,treatmentname,treatmentbody,treatmentjingluo);
    }
}

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

    if (!q.exec(PATIENTSCASEGL_SQL))
        return q.lastError();



    if (!q.prepare(INSERT_PATIENTSMANAGER_SQL))
        return q.lastError();
    QDate now=QDate::currentDate();
    //string str1="王小小";
    QVariant asimovId = addPatientManager(q, QStringLiteral("王小小"),1111,QStringLiteral("男"),29,QLatin1String("13500000009"), now,QLatin1String("wang"),now);
    QVariant greeneId = addPatientManager(q, QStringLiteral("李小小"),1112,QStringLiteral("女"),29,QLatin1String("13500000019"), now,QLatin1String("wang"),now);
    QVariant pratchettId = addPatientManager(q, QStringLiteral("张小小"),1113,QStringLiteral("女"),29,QLatin1String("13500000029"), now,QLatin1String("wang"),now);

    if (!q.prepare(INSERT_PATIENTSCASE_SQL))
        return q.lastError();

    QVariant sfiction = addPatientCase(q, QStringLiteral("王小小"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法"),QStringLiteral("王医生"),now,1,now
                                       );
    QVariant fiction = addPatientCase(q, QStringLiteral("王小小"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法1"),QStringLiteral("张医生"),now,1,now);
    QVariant fantasy = addPatientCase(q, QStringLiteral("王小小"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法2"),QStringLiteral("李医生"),now,1,now);
 //QVariant fantasy1 = addPatientCase(q, QStringLiteral("wangxiaoxiao"),1111,QStringLiteral("病症1"),QStringLiteral("经络疗法2"),QStringLiteral("李医生"),now,1,now);

    if (!q.prepare(INSERT_DOCTORMANAGER_SQL))
        return q.lastError();

        addDoctorManager(q, QStringLiteral("李医生"),"001", QDate(1971,7,18), QStringLiteral("启用"),QStringLiteral("医生"));
        addDoctorManager(q, QStringLiteral("李医生"),"002", QDate(1971,7,18), QStringLiteral("启用"),QStringLiteral("管理者"));
        addDoctorManager(q, QStringLiteral("李医生"),"003", QDate(1971,7,18), QStringLiteral("禁用"),QStringLiteral("医生"));
        addDoctorManager(q, QStringLiteral("李医生"),"004", QDate(1971,7,18), QStringLiteral("禁用"),QStringLiteral("管理者"));


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
    addGlTreatmentPlan(q,QStringLiteral("经络疗法1"),QStringLiteral("仰卧手向下"),QStringLiteral("足少阴肾经(体前)"));
    addGlTreatmentPlan(q,QStringLiteral("经络疗法1"),QStringLiteral("俯卧手向上"),QStringLiteral("心包经络"));

    if (!q.prepare(INSERT_PATIENTSCASEGL_SQL))
            return q.lastError();

    addPatientCaseGL(q,1111,QStringLiteral("经络疗法1"),QStringLiteral("仰卧手向下"),QStringLiteral("足少阴肾经(体前)"),QDate(2021,7,15));
     addPatientCaseGL(q,1111,QStringLiteral("经络疗法1"),QStringLiteral("俯卧手向上"),QStringLiteral("心包经络"),QDate(2021,7,15));
 //qWarning() << "general" << "dbcost1" << "ms";
     return QSqlError();

}
