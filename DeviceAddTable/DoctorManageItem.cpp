#include "DoctorManageItem.h"


DoctorManageItem::DoctorManageItem(QObject *parent) : QuickListItemBase(parent)
{

}

DoctorManageItem::~DoctorManageItem(){ }

bool DoctorManageItem::match(const QString &key){
    if (key.isEmpty()) {
        return true;
    }
    if (m_name.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_doctorid.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_doctorstate.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_managertype.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_resetpwd.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_editpwd.contains(key,Qt::CaseInsensitive)){
        return true;
    }
    if (m_dstate.contains(key,Qt::CaseInsensitive)){
        return true;
    }
    if (m_doctorspace.contains(key,Qt::CaseInsensitive)){
        return true;
    }

    return false;
}
