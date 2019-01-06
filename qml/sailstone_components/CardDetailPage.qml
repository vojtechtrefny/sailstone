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
        title: "Lightwarden"
      }

      Column {
        id: mainColumn
        width: parent.width
        spacing: Theme.paddingLarge

        Image {
          source: "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/EX1_001.png"
          horizontalAlignment: Image.AlignHCenter
        }

        SectionHeader { text: "Name" }

        Label {
          text: "Lightwarden"

          anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
          }
        }
      }
    }
  }
}
