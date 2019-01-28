import QtQuick 2.2
import Sailfish.Silica 1.0

Page {

  property string cardName : ""

  SilicaListView {
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

        Component.onCompleted: {
            getCardDetails(cardName);
        }
      }
    }

    anchors.horizontalCenter: parent.horizontalCenter
  }
}
