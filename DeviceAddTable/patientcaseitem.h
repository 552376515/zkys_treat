#ifndef PATIENTCASEITEM_H
#define PATIENTCASEITEM_H

#include <QObject>
#include <QWidget>
#include "Common/PropertyHelper.h"
#include "QuickModel/QuickListItemBase.h"
class PatientCaseItem : public QuickListItemBase
{
    Q_OBJECT
    AUTO_PROPERTY(QString, casename, "")
    AUTO_PROPERTY(QString, treatment, "")
    AUTO_PROPERTY(QString, tcount, "")
    AUTO_PROPERTY(QString, doctor, "")
    AUTO_PROPERTY(QString, prescriptime, "")
    AUTO_PROPERTY(bool, online, false)
    AUTO_PROPERTY(QString, checkCase, "")
    AUTO_PROPERTY(QString, editCase, "")
    AUTO_PROPERTY(QString, caseState,"")
public:
    explicit PatientCaseItem(QObject *parent = nullptr);
    virtual ~PatientCaseItem() override;
    bool match(const QString &key) override;
    quint32 toIPv4Address() const { return m_ipv4Address; }
private:
    quint32 m_ipv4Address = 0;
};

#endif // PATIENTCASEITEM_H
