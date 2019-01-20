import QtQuick 2.2
import Sailfish.Silica 1.0

import io.thp.pyotherside 1.4

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

            MouseArea {
              anchors.fill: parent
              onClicked: {
                  pageStack.push(Qt.resolvedUrl("./CardDetailPage.qml"))
              }
            }
          }

          Label {
            id: randomLabel
          }
        }

        SectionHeader { text: "Classes" }

        SectionHeader { text: "Sets" }
      }

      Component.onCompleted: {
          getRandomCard();
      }

      function getRandomCard() {
        mainWindow.python.call ('main.get_random_card', [], function(result) {
          randomLabel.text = mainWindow.python.getattr(result, "name");
          randomImage.source = mainWindow.python.getattr(result, "image");
        });
      }
    }

    SailstoneComponents.PullDownMenu {}

  }
}
