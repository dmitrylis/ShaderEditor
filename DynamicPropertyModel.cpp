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

    switch (role)
    {
    case PropertyRoles::NameRole:
        m_propertyList[index.row()].m_name = value.toString();
        break;
    case PropertyRoles::ValueRole:
        m_propertyList[index.row()].m_value = value;
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
    roles[PropertyRoles::ValueRole] = "ValueRole";
    return roles;
}

bool DynamicPropertyModel::append(const QString &name, const QVariant &value)
{
    Property newProperty(name, value);

    if (m_propertyList.contains(newProperty))
    {
        return false;
    }

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_propertyList.append(newProperty);
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

    const int entityIndex = m_propertyList.indexOf(currentProperty);

    beginRemoveRows(QModelIndex(), entityIndex, entityIndex);
    m_propertyList.removeAt(entityIndex);
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

    const int entityIndex = m_propertyList.indexOf(currentProperty);
    const QModelIndex modelIndex = index(entityIndex);

    if (setData(modelIndex, value, PropertyRoles::ValueRole))
    {
        emit dataChanged(modelIndex, modelIndex, { PropertyRoles::ValueRole });
        return true;
    }

    return false; // we will not reach this line
}
