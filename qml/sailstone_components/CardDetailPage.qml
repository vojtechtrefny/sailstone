import QtQuick 2.2
import Sailfish.Silica 1.0

Page {

  property string cardName : ""
  property bool inFavourites: false

  SilicaListView {
    id: detailPage

    anchors.fill: parent

    header: Column {
      width: parent.width
      height: header.height + mainColumn.height + Theme.paddingLarge

      PageHeader {
        id: header
        title: cardName
      }

      Column {
        id: mainColumn
        width: parent.width
        spacing: Theme.paddingLarge

        Image {
          id: cardImage

          horizontalAlignment: Image.AlignHCenter
          anchors.horizontalCenter: parent.horizontalCenter

          BusyIndicator {
            size: BusyIndicatorSize.Medium
            anchors.centerIn: cardImage
            running: cardImage.status != Image.Ready
          }
        }

        SectionHeader { text: "Text" }

        Label {
          id: labelText

          font.pixelSize: Theme.fontSizeSmall
          wrapMode: Text.Wrap
          color: Theme.secondaryColor

          anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
          }
        }

        SectionHeader { text: "Stats" }

        Label {
          id: labelStats

          font.pixelSize: Theme.fontSizeSmall
          wrapMode: Text.Wrap
          color: Theme.secondaryColor

          anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
          }
        }

        SectionHeader { text: "Type" }

        Label {
          id: labelType

          font.pixelSize: Theme.fontSizeSmall
          wrapMode: Text.Wrap
          color: Theme.secondaryColor

          anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
          }
        }

        VerticalScrollDecorator {}

        function getCardDetails(cardName) {
          mainWindow.python.call ('main.get_card', [cardName], function(result) {
            cardImage.source = mainWindow.python.getattr(result, "image");

            labelText.text = mainWindow.python.getattr(result, "text");
            labelStats.text = mainWindow.python.getattr(result, "stats");
            labelType.text = mainWindow.python.getattr(result, "type");
            })
        }

        function isInFavourites(cardName) {
          mainWindow.python.call ('main.is_in_favourites', [cardName], function(result) {
            inFavourites = result
            })
        }

        Component.onCompleted: {
            isInFavourites(cardName);
            getCardDetails(cardName);
        }
      }
    }

    anchors.horizontalCenter: parent.horizontalCenter

    PullDownMenu {
      MenuItem {
        text: "Add to Favourites"
        onClicked: addToFavourites(cardName)
        visible: !inFavourites

        function addToFavourites(cardName) {
          mainWindow.python.call ('main.add_to_favourites', [cardName], function() {});
          inFavourites = true;
        }
      }

      MenuItem {
        text: "Remove from Favourites"
        onClicked:  Remorse.popupAction (detailPage, "Removing...", removeFromFavourites(cardName), 5000)
        visible: inFavourites

        function removeFromFavourites(cardName) {
          mainWindow.python.call ('main.remove_from_favourites', [cardName], function() {});
          inFavourites = false;
        }
      }
    }
  }
}
