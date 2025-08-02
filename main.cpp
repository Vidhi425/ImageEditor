#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "imagemanager.h"
#include "selectionmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<ImageManager>("App", 1, 0, "ImageManager");
    qmlRegisterType<SelectionManager>("App", 2, 0, "SelectionManager");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ImageEditor", "Main");

    return app.exec();
}
