#include "qrshareplugin.h"
#include "qruploader.h"
#include "qrplugininfo.h"
#include <QtPlugin>

QRSharePlugin::QRSharePlugin()
{
}

QRSharePlugin::~QRSharePlugin()
{
}

MediaTransferInterface * QRSharePlugin::transferObject()
{
    return new QRUploader;
}

TransferPluginInfo *QRSharePlugin::infoObject()
{
    return new QRPluginInfo;
}

QString QRSharePlugin::pluginId() const
{
    return "harbour-qr-share-plugin";
}

bool QRSharePlugin::enabled() const
{
    return true;
}

