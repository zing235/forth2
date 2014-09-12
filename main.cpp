#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "camera1394.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Camera1394>("Camera1394", 1, 0, "Camera1394");
#include "camera1394.h"
    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/forth2/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
