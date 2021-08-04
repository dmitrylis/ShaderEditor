#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "GlslHighlighter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // load fonts
    QFontDatabase::addApplicationFont("qrc:/assets/fonts/consolas-regular.TTF");
    QFontDatabase::addApplicationFont("qrc:/assets/fonts/consolas-bold.TTF");
    QFontDatabase::addApplicationFont("qrc:/assets/fonts/consolas-italic.ttf");
    QFontDatabase::addApplicationFont("qrc:/assets/fonts/consolas-bold-italic.ttf");

    qmlRegisterType<GlslHighlighter>("dln.com.highlighter", 1, 0, "GlslHighlighter");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
