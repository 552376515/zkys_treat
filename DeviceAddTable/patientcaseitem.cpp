#include "patientcaseitem.h"

PatientCaseItem::PatientCaseItem(QObject *parent) : QuickListItemBase(parent)
{

}

PatientCaseItem::~PatientCaseItem(){ }

bool PatientCaseItem::match(const QString &key){
    if (key.isEmpty()) {
        return true;
    }
    if (m_casename.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_treatment.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_tcount.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_doctor.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_prescriptime.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_checkCase.contains(key,Qt::CaseInsensitive)){
        return true;
    }
    if (m_editCase.contains(key,Qt::CaseInsensitive)){
        return true;
    }
    return false;
}
