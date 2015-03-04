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

import Sailfish.TransferEngine 1.0
import fi.lahdemaki.QQRCode 1.0

Page {
  id: root

  allowedOrientations: Orientation.Portrait

  property string source
  property variant content

  property bool appActive: Qt.application.active

  onAppActiveChanged: {
    if(appActive)
    {
      code.requestPaint();
    }
  }

  SilicaFlickable {

    anchors.fill: parent

    contentHeight: columnContent.height

    PullDownMenu {
      MenuItem {
        //: Generate with edited data
        //% "Regenerate with edited data"
        text: qsTrId("harbour-qr-share-plugin-regenerate-id")
        onClicked: {
          code.value = testArea.text;
        }

      }

      MenuItem {
        //: Save function text
        //% "Save in pictures"
        text: qsTrId("harbour-qr-share-plugin-save-pic-id")
        onClicked: {

          code.save(StandardPaths.pictures + "/QR-" + new Date().toLocaleTimeString() + ".png");
        }
      }
    }

    Column {
      id: columnContent
      anchors.centerIn: parent
      width: parent.width
      spacing: Theme.paddingLarge

      PageHeader {
        //: Header for QR-code plugin
        //% "QR-code share"
        title: qsTrId("harbour-qr-share-plugin-header-id")
      }

      QRCode {
        id: code
        anchors.horizontalCenter: parent.horizontalCenter

        width: 420
        height: 420
      }

      TextArea {
        id: testArea
        width: parent.width

      }
    }

    Component.onCompleted: {

      switch(content.type)
      {

      case "text/vcard":
        code.value = content.data.replace(/^(PHOTO| ).*$[\r\n]*/gm, "");
        break;
      case "text/x-url":
        code.value = content.status;
        break;
      default:
        break;
      }

      testArea.text = code.value;
    }


  }
}

