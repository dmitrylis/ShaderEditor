#include "DynamicPropertyHandler.h"

DynamicPropertyHandler::DynamicPropertyHandler(QObject *parent)
    : QObject(parent)
    , m_engine(nullptr)
    , m_sourceObject(nullptr)
{
    m_dynamicPropertyModel = new DynamicPropertyModel(parent);
}

DynamicPropertyModel *DynamicPropertyHandler::dynamicPropertyModel() const
{
    return m_dynamicPropertyModel;
}

void DynamicPropertyHandler::setEngine(QQmlApplicationEngine *engine)
{
    m_engine = engine;
}

void DynamicPropertyHandler::registerSourceObject(QQuickItem *object)
{
    if (m_sourceObject != object)
    {
        m_sourceObject = object;
        emit sourceObjectChanged(object);
    }
}

bool DynamicPropertyHandler::assignProperty(const QString& name, int type, const QVariant &value)
{
    // create specific sampler2d object if needed
    QQuickItem *object = nullptr;
    if (type == PropertyTypes::Sampler2d) // TODO: move to the separate function
    {
        QQmlComponent component(m_engine, QUrl("qrc:/resources/qml/uniforms/Sampler2d.qml"));
        object = qobject_cast<QQuickItem*>(component.createWithInitialProperties({ { "visible", false }, { "source", value.toString() } }));
        QQmlEngine::setObjectOwnership(object, QQmlEngine::CppOwnership);
        object->setParent(m_engine);
    }

    // set property
    if (m_sourceObject && m_dynamicPropertyModel->prepend(name, type, value, object))
    {
        if (object)
        {
            m_sourceObject->setProperty(name.toStdString().c_str(), QVariant::fromValue(object));
        }
        else
        {
            m_sourceObject->setProperty(name.toStdString().c_str(), value);
        }

        return true;
    }

    return false;
}

bool DynamicPropertyHandler::removeProperty(const QString &name)
{
    QQuickItem *object = m_dynamicPropertyModel->object(name);

    if (m_sourceObject && m_dynamicPropertyModel->remove(name))
    {
        m_sourceObject->setProperty(name.toStdString().c_str(), QVariant());

        if (object) // delete the object if it was created before
        {
            object->deleteLater();
        }

        return true;
    }

    return false;
}

bool DynamicPropertyHandler::updateProperty(const QString &name, const QVariant &value)
{
    if (m_sourceObject && m_dynamicPropertyModel->update(name, value))
    {
        QQuickItem *object = m_dynamicPropertyModel->object(name);
        if (object) // specific sampler2d case
        {
            object->setProperty("source", value);
        }
        else
        {
            m_sourceObject->setProperty(name.toStdString().c_str(), value);
        }

        return true;
    }

    return false;
}
