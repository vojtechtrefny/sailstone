import QtQuick 2.2
import Sailfish.Silica 1.0

PullDownMenu {
    MenuItem {
        text: "Search cards"
    }

    MenuItem {
        text: "Favourites"
    }

    MenuItem {
        text: "About"
        onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
    }
}
