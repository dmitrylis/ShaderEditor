#include "DynamicPropertyModel.h"

DynamicPropertyModel::DynamicPropertyModel(QObject *parent)  : QAbstractListModel(parent) {}

int DynamicPropertyModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
    {
        return 0;
    }

    return m_propertyList.count();
}

QVariant DynamicPropertyModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
    {
        return QVariant();
    }

    const Property currentProperty = m_propertyList[index.row()];
    switch (role)
    {
    case PropertyRoles::NameRole:
        return QVariant::fromValue(currentProperty.m_name);
    case PropertyRoles::TypeRole:
        return QVariant::fromValue(currentProperty.m_type);
    case PropertyRoles::ValueRole:
        return QVariant::fromValue(currentProperty.m_value);
    default:
        break;
    }

    return QVariant();
}

bool DynamicPropertyModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
    {
        return false;
    }

    Property& currentProperty = m_propertyList[index.row()];
    switch (role)
    {
    case PropertyRoles::NameRole:
        currentProperty.m_name = value.toString();
        break;
    case PropertyRoles::TypeRole:
        currentProperty.m_type = value.toInt();
        break;
    case PropertyRoles::ValueRole:
        currentProperty.m_value = value;
        break;
    default:
        QAbstractListModel::setData(index, value, role);
        break;
    }

    return true;
}

QHash<int, QByteArray> DynamicPropertyModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[PropertyRoles::NameRole] = "NameRole";
    roles[PropertyRoles::TypeRole] = "TypeRole";
    roles[PropertyRoles::ValueRole] = "ValueRole";
    return roles;
}

bool DynamicPropertyModel::prepend(const QString &name, int type, const QVariant &value, QQuickItem *object)
{
    Property newProperty(name, type, value, object);

    if (m_propertyList.contains(newProperty))
    {
        return false;
    }

    beginInsertRows(QModelIndex(), 0, 0);
    m_propertyList.prepend(newProperty);
    endInsertRows();

    return true;
}

bool DynamicPropertyModel::remove(const QString &name)
{
    Property currentProperty(name);

    if (!m_propertyList.contains(currentProperty))
    {
        return false;
    }

    const int propertyIndex = m_propertyList.indexOf(currentProperty);

    beginRemoveRows(QModelIndex(), propertyIndex, propertyIndex);
    m_propertyList.removeAt(propertyIndex);
    endRemoveRows();

    return true;
}

bool DynamicPropertyModel::update(const QString &name, const QVariant &value)
{
    Property currentProperty(name);

    if (!m_propertyList.contains(currentProperty))
    {
        return false;
    }

    const int propertyIndex = m_propertyList.indexOf(currentProperty);
    const QModelIndex modelIndex = index(propertyIndex);

    if (setData(modelIndex, value, PropertyRoles::ValueRole))
    {
        emit dataChanged(modelIndex, modelIndex, { PropertyRoles::ValueRole });
        return true;
    }

    return false; // we will not reach this line
}

QQuickItem *DynamicPropertyModel::object(const QString& name) const
{
    auto result = std::find(m_propertyList.begin(), m_propertyList.end(), Property(name));
    if (result != m_propertyList.end())
    {
        return (*result).m_object;
    }
    return nullptr;
}

bool DynamicPropertyModel::contains(const QString &name) const
{
    return m_propertyList.contains(Property(name));
}
