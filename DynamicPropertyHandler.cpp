#include "DynamicPropertyHandler.h"

DynamicPropertyHandler::DynamicPropertyHandler(QObject *parent) : QObject(parent)
{

}

void DynamicPropertyHandler::assignProperty(QObject *object, const QString& name, const QVariant &value)
{
    if (object)
    {
        object->setProperty(name.toStdString().c_str(), value);
    }
}
