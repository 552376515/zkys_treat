#ifndef PATIENTDB_H
#define PATIENTDB_H
#include <QtSql>
#include <string.h>

extern QSqlError initDb();
extern QVariant addPatientCase(QSqlQuery &q, const QString &patientname, int patientnum, const QString &pcase,  const QString &treatment,const QString &doctor, QDate checkdate, int state,QDate treatdate);
extern QVariant addPatientManager(QSqlQuery &q, const QString &patientname, int patientnum,const QString &gender, int age,const QString &phone, QDate regtime, const QString &doctor,const QDate &lasttreattime);
extern QVariant addDoctorManager(QSqlQuery &q, const QString &name, int doctorid, QDate regtime, int doctorstate, int managertype);
extern QVariant addPatientCaseGL(QSqlQuery &q, int patientid, const QString &treatment,  const QString &directlay,const QString &jingluo, QDate treatdate);
//extern const auto INSERT_PATIENTSMANAGER_SQL;
extern void addPatientCaseNew(const QString &patientname, int patientid, const QString &pcase,  const QString &treatment,const QString &doctor, QDate checkdate, int state ,QDate treatdate);
extern void addPatientCaseGLNew( int patientid, const QString &treatment,  const QString &directlay,const QString &jingluo, QDate treatdate);
#endif // PATIENTDB_H
