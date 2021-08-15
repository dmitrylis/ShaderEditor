#ifndef DYNAMICPROPERTYMODEL_H
#define DYNAMICPROPERTYMODEL_H

#include <QAbstractListModel>
#include <QSet>
#include <QQuickItem>

struct Property {
    Property(const QString& name) : m_name(name) {}
    Property(const QString& name, int type, const QVariant &value, QQuickItem *object = nullptr) : m_name(name), m_type(type), m_value(value), m_object(object) {}

    bool operator== (const Property& other) const
    {
        return this->m_name == other.m_name;
    }

    QString m_name;
    int m_type;
    QVariant m_value;
    QQuickItem *m_object; // nullptr for simple copyable types
};

class DynamicPropertyModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum PropertyRoles {
        NameRole = Qt::UserRole + 1,
        TypeRole,
        ValueRole
    };
    Q_ENUM(PropertyRoles)

    explicit DynamicPropertyModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    QHash<int, QByteArray> roleNames() const override;

    bool prepend(const QString& name, int type, const QVariant &value, QQuickItem *object = nullptr);
    bool remove(const QString& name);
    bool update(const QString& name, const QVariant &value);

    QQuickItem *object(const QString& name) const;
    bool contains(const QString& name) const;

protected:
    QList<Property> m_propertyList;

};

#endif // DYNAMICPROPERTYMODEL_H
