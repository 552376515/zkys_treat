#ifndef PATIENTPRESADDMODEL_H
#define PATIENTPRESADDMODEL_H
#include <QAbstractListModel>

struct PatientCasePresParaModel
{
    PatientCasePresParaModel()
    {
        paraId = "";
        paraScript = "";
        paraDoctor ="";
        paraTime="";
    }
    //核心属性
    QString paraId;
    QString paraScript;
    QString paraDoctor;
    QString paraTime;

};

class PatientPresAddModel: public QAbstractListModel
{
     Q_OBJECT
public:
    PatientPresAddModel(QObject* parent = 0);
    enum Roles//qml用来识别别名的规则
    {
        paraIdRole = Qt::UserRole + 1,
        paraScriptRole,
        paraDoctorRole,
        paraTimeRole,

    };
    void addModel(const PatientCasePresParaModel &model);
    void update(int index ,const PatientCasePresParaModel &model );
    void clear();
public slots:
    void addData(QString dataStr);
protected:
    int  rowCount(const QModelIndex &parent = QModelIndex()) const;//qml内部调用,不用多管直接重写即可
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;//qml内部调用,不用多管直接重写即可
    QHash<int, QByteArray> roleNames() const;//qml内部调用,不用多管直接重写即可
private:
    QList<PatientCasePresParaModel> m_data;
};

#endif // PATIENTPRESADDMODEL_H
