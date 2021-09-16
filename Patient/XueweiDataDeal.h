#ifndef XUEWEIDATADEAL_H
#define XUEWEIDATADEAL_H
#include <QObject>
#include <QSize>
#include <QPointF>
class XueweiDataDeal: public QObject
{
    Q_OBJECT
public:

    explicit XueweiDataDeal(QObject *parent = 0);
public slots:
    bool initData(int index);
    QPointF getPointByIndexAndPicSize(QString xuewei, QSize size);
    QPointF getPointByIndex (int indexx);
private:
    QList<QStringList> xueweiPic;
};

#endif // XUEWEIDATADEAL_H
