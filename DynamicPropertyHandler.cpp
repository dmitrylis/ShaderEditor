#include "DynamicPropertyHandler.h"

#include "Dictionary.h"

DynamicPropertyHandler::DynamicPropertyHandler(QObject *parent)
    : QObject(parent)
    , m_engine(nullptr)
    , m_shaderObject(nullptr)
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

void DynamicPropertyHandler::registerShaderObject(QQuickItem *object)
{
    if (m_shaderObject != object)
    {
        m_shaderObject = object;
        emit shaderObjectChanged(object);
    }
}

bool DynamicPropertyHandler::assignProperty(const QString& name, int type, const QVariant &value)
{
    QQuickItem *object = nullptr;

    // create specific sampler2d object if needed
    if (type == PropertyTypes::Sampler2d)
    {
        object = createSampler2dObject(value);
    }

    // set property
    if (m_shaderObject && m_dynamicPropertyModel->prepend(name, type, value, object))
    {
        if (object)
        {
            m_shaderObject->setProperty(name.toStdString().c_str(), QVariant::fromValue(object));
        }
        else
        {
            m_shaderObject->setProperty(name.toStdString().c_str(), value);
        }

        return true;
    }

    return false;
}

bool DynamicPropertyHandler::removeProperty(const QString &name)
{
    QQuickItem *object = m_dynamicPropertyModel->object(name);

    if (m_shaderObject && m_dynamicPropertyModel->remove(name))
    {
        m_shaderObject->setProperty(name.toStdString().c_str(), QVariant());

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
    if (m_shaderObject && m_dynamicPropertyModel->update(name, value))
    {
        QQuickItem *object = m_dynamicPropertyModel->object(name);
        if (object) // specific sampler2d case
        {
            object->setProperty("source", value);
        }
        else
        {
            m_shaderObject->setProperty(name.toStdString().c_str(), value);
        }

        return true;
    }

    return false;
}

DynamicPropertyHandler::PropertyNameErrorCode DynamicPropertyHandler::nameErrorCode(const QString &name)
{
    if (name.isNull() || name.isEmpty())
    {
        return PropertyNameErrorCode::Empty;
    }

    // If first character is invalid
    if (!((name[0] >= 'a' && name[0] <= 'z') || (name[0] >= 'A' && name[0] <= 'Z') || name[0] == '_'))
    {
        return PropertyNameErrorCode::FirstCharError;
    }

    // Traverse the string for the rest of the characters
    for (int i = 1; i < name.length(); i++)
    {
        if (!((name[i] >= 'a' && name[i] <= 'z') || (name[i] >= 'A' && name[i] <= 'Z') || (name[i] >= '0' && name[i] <= '9') || name[i] == '_'))
        {
            return PropertyNameErrorCode::Invalid;
        }
    }

    // Check for keywords
    if (Dictionary::conditionals().contains(name)
            || Dictionary::statements().contains(name)
            || Dictionary::repeats().contains(name)
            || Dictionary::types().contains(name)
            || Dictionary::starageClasses().contains(name))
    {
        return PropertyNameErrorCode::ReservedKeyword;
    }

    // Check for reserved variables
    if (Dictionary::functions().contains(name)
            || Dictionary::states().contains(name)
            || Dictionary::uniforms().contains(name))
    {
        return PropertyNameErrorCode::ReservedName;
    }

    // Check for existing variables with the same name
    if (m_dynamicPropertyModel->contains(name))
    {
        return PropertyNameErrorCode::NameCollision;
    }

    // String is a valid identifier
    return PropertyNameErrorCode::Valid;
}

QString DynamicPropertyHandler::humanReadableNameErrorCode(DynamicPropertyHandler::PropertyNameErrorCode nameErrorCode)
{
    switch (nameErrorCode)
    {
    case PropertyNameErrorCode::FirstCharError: return "Uniform name can't be started with this character";
    case PropertyNameErrorCode::ReservedKeyword: return "Uniform name matches a reserved keyword";
    case PropertyNameErrorCode::ReservedName: return "Uniform name matches a reserved name";
    case PropertyNameErrorCode::NameCollision: return "Uniform with this name already exists";
    case PropertyNameErrorCode::Invalid: return "Invalid uniform name";
    default:  return "";
    }
}

QQuickItem *DynamicPropertyHandler::createSampler2dObject(const QVariant &value)
{
    QQmlComponent component(m_engine, QUrl(QStringLiteral("qrc:/resources/qml/uniforms/Sampler2d.qml")));
    QQuickItem *object = qobject_cast<QQuickItem*>(component.createWithInitialProperties({ { "source", value.toString() } }));
    QQmlEngine::setObjectOwnership(object, QQmlEngine::CppOwnership);
    object->setParent(m_engine);

    return object;
}
