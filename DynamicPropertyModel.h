#ifndef DYNAMICPROPERTYMODEL_H
#define DYNAMICPROPERTYMODEL_H

#include <QAbstractListModel>

struct Property {
    Property(const QString& name) : m_name(name) {}
    Property(const QString& name, const QVariant &value) : m_name(name), m_value(value) {}

    bool operator== (const Property& other) const
    {
        return this->m_name == other.m_name;
    }

    QString m_name;
    QVariant m_value;
};

class DynamicPropertyModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum PropertyRoles {
        NameRole = Qt::UserRole + 1,
        ValueRole
    };
    Q_ENUM(PropertyRoles)

    explicit DynamicPropertyModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    QHash<int, QByteArray> roleNames() const override;

    bool append(const QString& name, const QVariant &value);
    bool remove(const QString& name);
    bool update(const QString& name, const QVariant &value);

protected:
    QList<Property> m_propertyList;

};

#endif // DYNAMICPROPERTYMODEL_H
