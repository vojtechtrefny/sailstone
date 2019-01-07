import QtQuick 2.2
import Sailfish.Silica 1.0

import "." as SailstoneComponents

Page {
  SilicaListView {
    anchors.fill: parent

    header: Column {
      width: parent.width
      height: header.height + mainColumn.height + Theme.paddingLarge

      PageHeader {
        id: header
        title: "Sailstone"
      }

      Column {
        id: mainColumn
        width: parent.width
        spacing: Theme.paddingLarge

        SectionHeader { text: "Random card" }

        // "random" card
        Grid {
          id: grid
          columns: 2
          spacing: 32
          anchors.horizontalCenter: parent.horizontalCenter
          horizontalItemAlignment: Grid.AlignHCenter
          verticalItemAlignment: Grid.AlignVCenter

          Image {
            id: randomImage

            source: "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/EX1_001.png"

            MouseArea {
              anchors.fill: parent
              onClicked: {
                  pageStack.push(Qt.resolvedUrl("./CardDetailPage.qml"))
              }
            }
          }

          Label {
            id: randomLabel
            text: "name: Lightwarden\nrarity: RARE\ntype: MINION\ncost: 1"
          }
        }

        SectionHeader { text: "Classes" }

        SectionHeader { text: "Sets" }
      }
    }

    SailstoneComponents.PullDownMenu {}

  }
}
