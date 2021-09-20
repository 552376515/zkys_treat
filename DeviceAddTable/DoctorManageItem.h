#ifndef DOCTORMANAGEITEM_H
#define DOCTORMANAGEITEM_H

#include <QObject>
#include <QWidget>
#include "Common/PropertyHelper.h"
#include "QuickModel/QuickListItemBase.h"
class DoctorManageItem: public QuickListItemBase
{
    Q_OBJECT
    AUTO_PROPERTY(QString, name, "")
    AUTO_PROPERTY(QString, doctorid, "")
    AUTO_PROPERTY(QString, regtime, "")
    AUTO_PROPERTY(QString,doctorstate,"")
    AUTO_PROPERTY(QString,managertype,"")
    AUTO_PROPERTY(QString,doctorspace,"")
    AUTO_PROPERTY(QString, resetpwd, "")
    AUTO_PROPERTY(QString, editpwd, "")
    AUTO_PROPERTY(QString, dstate,"")
public:
    explicit DoctorManageItem(QObject *parent = nullptr);
    virtual ~DoctorManageItem() override;
    bool match(const QString &key) override;
};

#endif // DOCTORMANAGEITEM_H
