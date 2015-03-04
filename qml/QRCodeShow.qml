import QtQuick 2.0
import Sailfish.Silica 1.0

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

        width: 320
        height: 320

        value: switch(root.content.type)
               {
               case "text/vcard":
                 return root.content.data.replace(/^(PHOTO| ).*$[\r\n]*/gm, "");
               case "text/x-url":
                 return root.content.status;
               default:
                 return ""
               }

        Component.onCompleted: {
          testArea.text = code.value;
        }
      }


      TextArea {
        id: testArea
        width: parent.width

      }
    }

    Component.onCompleted: {

      console.log(code.value)
      console.log(content.data)
      console.log(JSON.stringify(Qt.locale()))
    }
  }
}

