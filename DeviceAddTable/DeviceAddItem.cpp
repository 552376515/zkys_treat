#include "DeviceAddItem.h"
#include <QHostAddress>
DeviceAddItem::DeviceAddItem(QObject *parent) : QuickListItemBase(parent)
{
    connect(this, &DeviceAddItem::regtimeChanged, this, [this]() { m_ipv4Address = QHostAddress(regtime()).toIPv4Address(); });
}

DeviceAddItem::~DeviceAddItem() { }
bool DeviceAddItem::match(const QString &key)
{
    if (key.isEmpty()) {
        return true;
    }
    if (m_name.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_pno.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_gender.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_age.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_phone.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_regtime.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    return false;
}
