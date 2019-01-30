import QtQuick 2.2
import Sailfish.Silica 1.0

import io.thp.pyotherside 1.4

Page {
  SilicaListView {
    id: favouritesPage

    property bool searching: false

    anchors.fill: parent

    header: Column {
      width: parent.width
      height: header.height + Theme.paddingLarge

      PageHeader {
        id: header
        title: "Favourites"
      }
    }

    BusyIndicator {
      size: BusyIndicatorSize.Large
      anchors.centerIn: parent
      running: favouritesPage.searching
    }

    currentIndex: -1

    model: ListModel {
      id: listModel
    }

    delegate: ListItem {
        Label {
          anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
          }
          text: name

          MouseArea {
            anchors.fill: parent
            onClicked: {
                pageStack.push(Qt.resolvedUrl("./CardDetailPage.qml"),
                               { cardName : name })
            }
          }
        }
     }

    Component.onCompleted: {
      mainWindow.python.setHandler('favourites_finished', function (cards) {
          favouritesPage.searching = false;
          for (var i = 0; i < cards.length; i++) {
            var cardName = mainWindow.python.getattr(cards[i], "name");
            listModel.append({"name": cardName});
          }
      });

      listModel.clear();
      favouritesPage.getFavourites();
    }

    function getFavourites(cardName) {
      favouritesPage.searching = true
      mainWindow.python.call ('main.get_favourites', [], function() {

      });
    }
  }
}
