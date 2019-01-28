import QtQuick 2.2
import Sailfish.Silica 1.0

import io.thp.pyotherside 1.4

Page {
  SilicaListView {
    id: searchPage

    property bool searching: false

    anchors.fill: parent

    header: SearchField {
      id: searchField
      width: parent.width
      placeholderText: "Search"

      EnterKey.onClicked: {
        listModel.clear();
        searchPage.searchCard(text);
      }
    }

    BusyIndicator {
      size: BusyIndicatorSize.Large
      anchors.centerIn: parent
      running: searchPage.searching
    }

    // prevent newly added list delegates from stealing focus away from the search field
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
      mainWindow.python.setHandler('searching_finished', function (cards) {
          searchPage.searching = false;
          for (var i = 0; i < cards.length; i++) {
            var cardName = mainWindow.python.getattr(cards[i], "name");
            listModel.append({"name": cardName});
          }
      });
    }

    function searchCard(cardName) {
      searchPage.searching = true
      mainWindow.python.call ('main.search_card', [cardName], function() {

      });
    }
  }
}
