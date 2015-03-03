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

import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.thumbnailer 1.0
import Sailfish.TransferEngine 1.0

ShareDialog {
    id: root

    property int viewWidth: root.isPortrait ? Screen.width : Screen.width / 2

    onAccepted: {
        shareItem.start()
    }

    Thumbnail {
        id: thumbnail
        width: viewWidth
        height: parent.height / 2
        source: root.source
        sourceSize.width: Screen.width
        sourceSize.height: Screen.height / 2
    }

    Item {
        anchors {
            top: root.isPortrait ? thumbnail.bottom : parent.top
            left: root.isPortrait ? parent.left: thumbnail.right
            right: parent.right
            bottom: parent.bottom
        }

        Label {
            anchors.centerIn:parent
            width: viewWidth
            //: Label for example share UI
            //% "Example Test Share UI"
            text: qsTrId("example-test-share-ui-la-id")
            horizontalAlignment: Text.AlignHCenter
        }
    }

    SailfishShare {
        id: shareItem
        source: root.source
        metadataStripped: true
        serviceId: root.methodId
        userData: {"description": "Random Text which can be what ever",
                   "accountId": root.accountId,
                   "scalePercent": root.scalePercent}
    }

    DialogHeader {
        //: Header for example share plugin
        //% "Example Share"
        acceptText: qsTrId("example-share-he-id")
    }
}

