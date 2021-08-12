#ifndef DYNAMICPROPERTYHANDLER_H
#define DYNAMICPROPERTYHANDLER_H

#include <QObject>
#include <QQuickItem>
#include <QQmlApplicationEngine>

#include "DynamicPropertyModel.h"

class DynamicPropertyHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DynamicPropertyModel* dynamicPropertyModel READ dynamicPropertyModel CONSTANT)
    Q_PROPERTY(QQuickItem* sourceObject MEMBER m_sourceObject NOTIFY sourceObjectChanged)

public:
    enum PropertyTypes {
        Unknown = -1,
        Float = 0,
        Sampler2d,
        Vector2d,
        Vector3d,
        Vector4d,
        Matrix4x4
    };
    Q_ENUM(PropertyTypes)

    explicit DynamicPropertyHandler(QObject *parent = nullptr);

    DynamicPropertyModel *dynamicPropertyModel() const;

    void setEngine(QQmlApplicationEngine *engine);
    Q_INVOKABLE void registerSourceObject(QQuickItem *object);

    Q_INVOKABLE bool assignProperty(const QString& name, int type, const QVariant &value);
    Q_INVOKABLE bool removeProperty(const QString& name);
    Q_INVOKABLE bool updateProperty(const QString& name, const QVariant &value);

signals:
    void sourceObjectChanged(QQuickItem* sourceObject);

protected:
    QQmlApplicationEngine *m_engine;
    DynamicPropertyModel *m_dynamicPropertyModel;
    QQuickItem *m_sourceObject;
};

#endif // DYNAMICPROPERTYHANDLER_H
