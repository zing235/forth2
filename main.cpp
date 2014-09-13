#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "camera1394.h"
#include "ImageValue.h"
#include <QtQml>
#include <QtQuick/QQuickView>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Camera1394>("Camera1394", 1, 0, "Camera1394");
    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("imagevalue",new ImageValue);
    viewer.setMainQmlFile(QStringLiteral("qml/forth2/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
