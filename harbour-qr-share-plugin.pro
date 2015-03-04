TEMPLATE = lib
TARGET = $$qtLibraryTarget(harbourqrshareplugin)
CONFIG += plugin
DEPENDPATH += .

CONFIG += link_pkgconfig
PKGCONFIG += nemotransferengine-qt5

# Input
HEADERS += \
    src/qrplugininfo.h \
    src/qruploader.h \
    src/qrshareplugin.h

SOURCES += \
    src/qrplugininfo.cpp \
    src/qruploader.cpp \
    src/qrshareplugin.cpp

OTHER_FILES += \
    qml/QRCodeShow.qml

shareui.files = qml/QRCodeShow.qml
shareui.path = /usr/share/nemo-transferengine/plugins

target.path = /usr/lib/nemo-transferengine/plugins
INSTALLS += target shareui

OTHER_FILES += \
    qml/qqr.js/qqr.js \
    qml/qqr.js/QRCode.qml \
    qml/qqr.js/qmldir

qqrlib.files = qml/qqr.js/qqr.js \
    qml/qqr.js/QRCode.qml \
    qml/qqr.js/qmldir
qqrlib.path = /usr/lib/qt5/qml/fi/lahdemaki/QQRCode

INSTALLS += qqrlib

TS_FILE = $$OUT_PWD/harbour_qr_share_plugin.ts
EE_QM = $$OUT_PWD/harbour-qr-share-plugin-eng_en.qm

ts.commands += lupdate . -ts $$TS_FILE
ts.CONFIG += no_check_exist no_link
ts.output = $$TS_FILE
ts.input = ..

ts_install.files = $$TS_FILE
ts_install.path = /usr/share/translations/source
ts_install.CONFIG += no_check_exist

# should add -markuntranslated "-" when proper translations are in place (or for testing)
engineering_english.commands += lrelease -idbased $$TS_FILE -qm $$EE_QM
engineering_english.CONFIG += no_check_exist no_link
engineering_english.depends = ts
engineering_english.input = $$TS_FILE
engineering_english.output = $$EE_QM

engineering_english_install.path = /usr/share/translations/nemotransferengine
engineering_english_install.files = $$EE_QM
engineering_english_install.CONFIG += no_check_exist

TS_FI_FILE = translations/harbour_qr_share_plugin_fi.ts
QM_FI_FILE = harbour-qr-share-plugin-fi.qm

finnish.commands += lrelease -idbased $$TS_FI_FILE -qm $$QM_FI_FILE
finnish.CONFIG += no_check_exist no_link
finnish.depends = ts
finnish.input = $$TS_FI_FILE
finnish.output = $$QM_FI_FILE

finnish_install.path = /usr/share/translations/nemotransferengine
finnish_install.files = $$QM_FI_FILE
finnish_install.CONFIG += no_check_exist

TS_EN_FILE = translations/harbour_qr_share_plugin_en_GB.ts
QM_EN_FILE = harbour-qr-share-plugin-en_GB.qm

english.commands += lrelease -idbased $$TS_EN_FILE -qm $$QM_EN_FILE
english.CONFIG += no_check_exist no_link
english.depends = ts
english.input = $$TS_EN_FILE
english.output = $$QM_EN_FILE

english_install.path = /usr/share/translations/nemotransferengine
english_install.files = $$QM_EN_FILE
english_install.CONFIG += no_check_exist

QMAKE_EXTRA_TARGETS += ts engineering_english finnish english

PRE_TARGETDEPS += ts engineering_english finnish english

INSTALLS += ts_install engineering_english_install english_install

OTHER_FILES += \
    rpm/* \
    translations/*
