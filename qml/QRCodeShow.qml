import QtQuick 2.0
import Sailfish.Silica 1.0

import fi.lahdemaki.QQRCode 1.0

Page {
  id: root

  allowedOrientations: Orientation.Portrait | Orientation.PortraitInverted

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

    contentHeight: (root.orientation === Orientation.Portrait) ? columnContent.height : parent.height

    PullDownMenu {

      visible: root.orientation === Orientation.Portrait

      MenuItem {
        //: Save function text
        //% "Save in pictures"
        text: qsTrId("harbour-qr-share-plugin-save-pic-id")
        onClicked: {

          code.save(StandardPaths.pictures + "/QR-" + new Date().toLocaleTimeString() + ".png");
        }
      }

      MenuItem {
        //: Save and open function text
        //% "Save and open in gallery"
        text: qsTrId("harbour-qr-share-plugin-save-open-gallery-id")
        onClicked: {

          var filepath = StandardPaths.pictures + "/QR-" + new Date().toLocaleTimeString() + ".png";
          code.save(filepath);
          Qt.openUrlExternally(filepath);
        }
      }
      MenuItem {
        //: Generate with edited data
        //% "Regenerate with edited data"
        text: qsTrId("harbour-qr-share-plugin-regenerate-id")
        onClicked: {
          code.value = testArea.text;
        }

      }
    }

    Column {
      id: columnContent
      anchors.centerIn: parent
      width: parent.width - 2*Theme.paddingSmall
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
        height: width

        value: switch(root.content.type)
               {
               case "text/vcard":
                 return root.content.data.replace(/^(PHOTO| ).*$[\r\n]*/gm, "");
               case "text/x-url":
                 return root.content.status;
               default:
                 return "Sorry for the error...";
               }

        Component.onCompleted: {
          testArea.text = code.value;
        }
      }

      TextArea {
        id: testArea

        visible: root.orientation === Orientation.Portrait

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
      }
    }
  }
}


