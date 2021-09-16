#include "XueweiDataDeal.h"
#include <QFile>
#include <QDebug>

XueweiDataDeal::XueweiDataDeal(QObject *parent) :
    QObject(parent)
{

}

bool XueweiDataDeal::initData(int indexXue){


//    QList<QString> fileList;
//    fileList<<"dan_right.txt";
//    QFile file;
//    const QString fileNmae=fileList[indexXue];
//    file.setFileName(fileNmae);
//    if (!file.exists()){
//        return false;
//    }

//    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
//    {
//        qDebug()<<"Can't open the file!"<<endl;
//        return false;
//    }
//    QTextStream in(&file);
//    QString line = in.readLine();
//    while (!line.isNull())
//     {
//       QStringList list=line.split("    ");
//       xueweiPic.append(list);
//       line = in.readLine();
//     }

    return true;
}

QPointF XueweiDataDeal::getPointByIndexAndPicSize(QString xuewei,QSize size){
    QPointF qf=QPointF(0,0);
    foreach (const QStringList &mlist, xueweiPic ){
        QString strname=mlist[0];
        if (strname ==xuewei){
            qf.setX(mlist[1].toFloat());
            qf.setY(mlist[2].toFloat());
            break;
        }
    }
    return qf;

}

QPointF XueweiDataDeal::getPointByIndex(int indexx){
     QPointF qf=QPointF(0,0);
    const QStringList &mlist=xueweiPic[indexx];
    qf.setX(mlist[1].toFloat());
    qf.setY(mlist[2].toFloat());
    return qf;
}
