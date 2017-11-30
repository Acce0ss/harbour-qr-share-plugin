import QtQuick 2.0
import QtSensors 5.2

import Sailfish.Silica 1.0

import fi.lahdemaki.QQRCode 1.0

Page {
  id: root

  property string source
  property variant content

  property bool appActive: Qt.application.active

  onAppActiveChanged: {
    if(appActive)
    {
      code.requestPaint();
    }
  }

  RotationSensor {
    id: sensor

    active: appActive

    property bool upsideDown: false
    property int hysteresis: 10

    function getReading() {
        switch(orientation) {
        case Orientation.Portrait:
            return reading.x;
        case Orientation.Landscape:
            return reading.y;
        case Orientation.PortraitInverted:
            return -reading.x;
        case Orientation.LandscapeInverted:
            return -reading.y;
        default:
            return 5;
        }
    }

    onReadingChanged: {

      if(getReading() > hysteresis)
      {
        upsideDown = true;
        hysteresis = 2;
      }
      else
      {
        upsideDown = false;
        hysteresis = 10;
      }
    }
  }

  SilicaFlickable {

    anchors.fill: parent

    contentHeight: !sensor.upsideDown ? columnContent.height : parent.height

    PullDownMenu {

      id: functionMenu

      opacity: sensor.upsideDown ? 0.0 : 1.0

      Behavior on opacity {
        NumberAnimation {
          duration: 300
          onRunningChanged: {
            if(!running)
            {
              functionMenu.visible = !sensor.upsideDown;
            }
            else if(running && !functionMenu.visible)
            {
              functionMenu.visible = !sensor.upsideDown;
            }
          }
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

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      width: parent.width - 2*Theme.paddingSmall
      spacing: Theme.paddingLarge

      PageHeader {
        id: header
        opacity: sensor.upsideDown ? 0.0 : 1.0

        Behavior on opacity {
          NumberAnimation {
            duration: 300
          }
        }

        //: Header for QR-code plugin
        //% "QR-code share"
        title: qsTrId("harbour-qr-share-plugin-header-id")
      }


      Item {
        id: spacer
        height: sensor.upsideDown ? (root.height/2
                                     - header.height
                                     - codeContainer.height / 2
                                     - 2*Theme.paddingLarge ) : 5

        Behavior on height {
          SmoothedAnimation {
            duration: 500
          }
        }

        width: parent.width
      }

      Rectangle{
        id: codeContainer
        anchors.horizontalCenter: parent.horizontalCenter

        width: 420+10
        height: width

        radius: 15

        transformOrigin: Item.Center

        QRCode {
          id: code
          anchors.centerIn: parent

          width: 420
          height: width

          border: 1

          value: switch(root.content.type)
                 {
                 case "text/vcard":
                   //remove photo from contact data
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

        rotation: sensor.upsideDown ? 180 : 0

        Behavior on rotation {
          SmoothedAnimation {
            duration: 800
            easing {
              type: Easing.OutElastic
              amplitude: 0.2
              period: 1.5
            }
          }
        }
      }

      TextArea {
        id: testArea

        opacity: sensor.upsideDown ? 0.0 : 1.0

        Behavior on opacity {
          NumberAnimation {
            duration: 300
          }
        }

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
      }
    }
  }
}


