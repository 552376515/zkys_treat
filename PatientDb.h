#ifndef PATIENTDB_H
#define PATIENTDB_H
#include <QtSql>
#include <string.h>

extern QSqlError initDb();
extern QVariant addPatientCase(QSqlQuery &q, const QString &patientname, int patientnum, const QString &pcase,  const QString &treatment,const QString &doctor, QDate checkdate, int state);
extern QVariant addPatientManager(QSqlQuery &q, const QString &patientname, int patientnum,const QString &gender, int age,const QString &phone, QDate regtime, const QString &doctor);
extern QVariant addDoctorManager(QSqlQuery &q, const QString &name, QDate birthdate, int managertype);
//extern const auto INSERT_PATIENTSMANAGER_SQL;
#endif // PATIENTDB_H
