#include <QDebug>
#include <QLocale>
#include "qrplugininfo.h"

QRPluginInfo::QRPluginInfo()
    : m_ready(false)
{

}

QRPluginInfo::~QRPluginInfo()
{

}

QList<TransferMethodInfo> QRPluginInfo::info() const
{
    return m_infoList;
}

void QRPluginInfo::query()
{
    TransferMethodInfo info;
    QStringList capabilities;

    // Capabilites ie. what mimetypes this plugin supports
    capabilities << QLatin1String("text/x-url")
                 << QLatin1String("text/vcard");

    // TODO: Translations for 3rd party plugins is not yet supported by Sailfish OS.
    //       Adding support there later, but for now just use what ever non-translated
    //       string here. This string will be visible in the share method list.
    //: Display name for QR share plugin
    //% "Share as QR-code"
    info.displayName     = qtTrId("harbour-qr-share-plugin-id");

    // Method ID is a unique identifier for this plugin. It is used to identify which share plugin should be
    // used for starting the sharing.
    info.methodId        = QLatin1String("harbour-qr-share-plugin");

    // Path to the Sharing UI which this plugin provides.
    info.shareUIPath     = QLatin1String("/usr/share/nemo-transferengine/plugins/QRCodeShow.qml");

    // Pass information about capabilities. This info is used for filtering share plugins
    // which don't support defined types. For QR, this plugin won't appear in the
    // share method list, if someone tries to share content which isn't image or vcard type,
    info.capabilitities  = capabilities;

    m_infoList << info;

    // Let the world know that this plugin is ready
    m_ready = true;
    emit infoReady();

    qDebug() << QLocale().name();
}


bool QRPluginInfo::ready() const
{
    return m_ready;
}
