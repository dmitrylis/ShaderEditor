#include "DynamicPropertyHandler.h"

DynamicPropertyHandler::DynamicPropertyHandler(QObject *parent) : QObject(parent), m_sourceObject(nullptr)
{
    m_dynamicPropertyModel = new DynamicPropertyModel(parent);
}

DynamicPropertyModel *DynamicPropertyHandler::dynamicPropertyModel() const
{
    return m_dynamicPropertyModel;
}

void DynamicPropertyHandler::registerSourceObject(QObject *object)
{
    m_sourceObject = object;
}

void DynamicPropertyHandler::assignProperty(const QString& name, const QVariant &value)
{
    if (m_sourceObject && m_dynamicPropertyModel->append(name, value))
    {
        m_sourceObject->setProperty(name.toStdString().c_str(), value);
    }
}

void DynamicPropertyHandler::removeProperty(const QString &name)
{
    if (m_sourceObject && m_dynamicPropertyModel->remove(name))
    {
        m_sourceObject->setProperty(name.toStdString().c_str(), QVariant());
    }
}

void DynamicPropertyHandler::updateProperty(const QString &name, const QVariant &value)
{
    if (m_sourceObject && m_dynamicPropertyModel->update(name, value))
    {
        m_sourceObject->setProperty(name.toStdString().c_str(), value);
    }
}
