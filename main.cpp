#include <QGuiApplication>
#include <QSurfaceFormat>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "GlslHighlighter.h"
#include "DynamicPropertyHandler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.setOrganizationName("DigitalMankind");
    app.setOrganizationDomain("DigitalMankind.com");

    QSurfaceFormat format;
    format.setSamples(8);
    QSurfaceFormat::setDefaultFormat(format);

    // fonts loading
    QFontDatabase::addApplicationFont(":/resources/assets/fonts/consolas-regular.TTF");
    QFontDatabase::addApplicationFont(":/resources/assets/fonts/consolas-bold.TTF");
    QFontDatabase::addApplicationFont(":/resources/assets/fonts/consolas-italic.ttf");
    QFontDatabase::addApplicationFont(":/resources/assets/fonts/consolas-bold-italic.ttf");

    // types registration
    qmlRegisterType<GlslHighlighter>("com.dln.Highlighter", 1, 0, "GlslHighlighter");
    qmlRegisterUncreatableType<DynamicPropertyHandler>("com.dln.PropertyHandler", 1, 0, "PropertyHandler", "c++ enums");

    // objects creation
    DynamicPropertyHandler dynamicPropertyHandler;
    QQmlApplicationEngine engine; // create objects before the engine!

    // setup objects
    dynamicPropertyHandler.setEngine(&engine);

    // context properties setting
    engine.rootContext()->setContextProperty("_dynamicPropertyHandler", &dynamicPropertyHandler);

    // load main qml file
    engine.load(QUrl(QStringLiteral("qrc:/resources/qml/main.qml")));

    return app.exec();
}
