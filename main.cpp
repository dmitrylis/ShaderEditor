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
    QQmlApplicationEngine engine;

    QSurfaceFormat format;
    format.setSamples(8);
    QSurfaceFormat::setDefaultFormat(format);

    DynamicPropertyHandler dynamicPropertyHandler;

    // registration of types and set context properties
    qmlRegisterType<GlslHighlighter>("dln.com.highlighter", 1, 0, "GlslHighlighter");
    engine.rootContext()->setContextProperty("_dynamicPropertyHandler", &dynamicPropertyHandler);

    // load fonts
    QFontDatabase::addApplicationFont("qrc:/resources/assets/fonts/consolas-regular.TTF");
    QFontDatabase::addApplicationFont("qrc:/resources/assets/fonts/consolas-bold.TTF");
    QFontDatabase::addApplicationFont("qrc:/resources/assets/fonts/consolas-italic.ttf");
    QFontDatabase::addApplicationFont("qrc:/resources/assets/fonts/consolas-bold-italic.ttf");

    const QUrl url(QStringLiteral("qrc:/resources/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
