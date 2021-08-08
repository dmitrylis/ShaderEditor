#ifndef DYNAMICPROPERTYHANDLER_H
#define DYNAMICPROPERTYHANDLER_H

#include <QObject>

class DynamicPropertyHandler : public QObject
{
    Q_OBJECT

public:
    explicit DynamicPropertyHandler(QObject *parent = nullptr);

    Q_INVOKABLE void assignProperty(QObject *object, const QString& name, const QVariant &value);

signals:

};

#endif // DYNAMICPROPERTYHANDLER_H
