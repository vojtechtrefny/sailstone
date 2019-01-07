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

      Python {
        id: py

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl("../../py"));

            importModule('main', function () {});

            getRandomCard();
        }

        function getRandomCard() {
          py.call ('main.get_random_card', [], function(result) {
            randomLabel.text = py.getattr(result, "name");
            randomImage.source = py.getattr(result, "image");
          });
        }

        onError: {
          console.log('python error: ' + traceback);
        }

        onReceived: {
          console.log('got message from python: ' + data);
        }
      }
    }

    SailstoneComponents.PullDownMenu {}

  }
}
