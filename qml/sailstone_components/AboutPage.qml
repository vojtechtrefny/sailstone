import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
  SilicaListView {
    anchors.fill: parent

    header: Column {
      width: parent.width
      height: header.height + mainColumn.height + Theme.paddingLarge

      PageHeader {
        id: header
        title: "About Sailstone"
      }

      Column {
        id: mainColumn
        width: parent.width
        spacing: Theme.paddingLarge

        Label {
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: Theme.fontSizeSmall
          horizontalAlignment: Text.AlignHCenter

          text: "Unofficial Hearthstone cards application"
        }

        LinkedLabel {
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: Theme.fontSizeExtraSmall
          color: Theme.secondaryColor

          text: "Uses Hearthstone API http://hearthstoneapi.com/"
        }

        Label {
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: Theme.fontSizeExtraSmall
          color: Theme.secondaryColor

          text: "Copyright © 2019 Vojtěch Trefný <mail@vojtechtrefny.cz>"
        }

        Label {
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: Theme.fontSizeExtraSmall
          color: Theme.secondaryColor

          text: "Sailstone is licensed under MIT Licence"
        }

        LinkedLabel {
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: Theme.fontSizeSmall
          horizontalAlignment: Text.AlignHCenter

          text: "https://github.com/vojtechtrefny/sailstone"
        }
      }
    }
  }
}
