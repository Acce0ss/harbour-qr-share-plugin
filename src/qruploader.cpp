#include "qruploader.h"
#include "mediaitem.h"

QRUploader::QRUploader(QObject *parent):
    MediaTransferInterface(parent)
{

}

QRUploader::~QRUploader()
{
}

QString QRUploader::displayName() const
{
    return qtTrId("harbour-qr-share-plugin-id");
}

QUrl QRUploader::serviceIcon() const
{
    // Url to the icon which should be shown in the transfer UI
    return QUrl("image://theme/icon-s-message");
}

bool QRUploader::cancelEnabled() const
{
    // Return true if cancelling ongoing upload is supported
    // Return false if cancelling ongoing upload is not supported
    return false;
}

bool QRUploader::restartEnabled() const
{
    // Return true, if restart is  supported.
    // Return false, if restart is not supported
    return false;
}


void QRUploader::start()
{
    // This is called by the sharing framework to start sharing

    // TODO: Add your code here to start uploading
}

void QRUploader::cancel()
{
    // This is called by the sharing framework to cancel on going transfer

    // TODO: Add your code here to cancel ongoing upload
}

