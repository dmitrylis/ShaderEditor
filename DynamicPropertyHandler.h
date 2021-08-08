#ifndef DYNAMICPROPERTYHANDLER_H
#define DYNAMICPROPERTYHANDLER_H

#include <QObject>

#include "DynamicPropertyModel.h"

class DynamicPropertyHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DynamicPropertyModel* dynamicPropertyModel READ dynamicPropertyModel CONSTANT)

public:
    explicit DynamicPropertyHandler(QObject *parent = nullptr);

    DynamicPropertyModel *dynamicPropertyModel() const;

    Q_INVOKABLE void registerSourceObject(QObject *object);

    Q_INVOKABLE void assignProperty(const QString& name, const QVariant &value);
    Q_INVOKABLE void removeProperty(const QString& name);
    Q_INVOKABLE void updateProperty(const QString& name, const QVariant &value);

protected:
    DynamicPropertyModel *m_dynamicPropertyModel;
    QObject *m_sourceObject;
};

#endif // DYNAMICPROPERTYHANDLER_H
