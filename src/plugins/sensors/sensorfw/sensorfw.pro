TARGET = qtsensors_sensorfw
QT = core sensors network

PLUGIN_TYPE = sensors
load(qt_plugin)

include(sensorfw.pri)


CONFIG += link_pkgconfig
PKGCONFIG += sensord

CONFIGFILES.files = Sensors.conf
CONFIGFILES.path = /etc/xdg/QtProject/
INSTALLS += CONFIGFILES

OTHER_FILES = plugin.json
