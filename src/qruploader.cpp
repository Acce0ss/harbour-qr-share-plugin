/******************************************************************************
Copyright (c) <2014>, Jolla Ltd.
Contact: Marko Mattila <marko.mattila@jolla.com>

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer. Redistributions in binary
    form must reproduce the above copyright notice, this list of conditions and
    the following disclaimer in the documentation and/or other materials
    provided with the distribution. Neither the name of the Jolla Ltd. nor
    the names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
******************************************************************************/

#include "exampleuploader.h"
#include "mediaitem.h"

ExampleUploader::ExampleUploader(QObject *parent):
    MediaTransferInterface(parent)
{

}

ExampleUploader::~ExampleUploader()
{
}

QString ExampleUploader::displayName() const
{
    return tr("Example");
}

QUrl ExampleUploader::serviceIcon() const
{
    // Url to the icon which should be shown in the transfer UI
    return QUrl("image://theme/icon-s-message");
}

bool ExampleUploader::cancelEnabled() const
{
    // Return true if cancelling ongoing upload is supported
    // Return false if cancelling ongoing upload is not supported
    return false;
}

bool ExampleUploader::restartEnabled() const
{
    // Return true, if restart is  supported.
    // Return false, if restart is not supported
    return false;
}


void ExampleUploader::start()
{
    // This is called by the sharing framework to start sharing

    // TODO: Add your code here to start uploading
}

void ExampleUploader::cancel()
{
    // This is called by the sharing framework to cancel on going transfer

    // TODO: Add your code here to cancel ongoing upload
}

