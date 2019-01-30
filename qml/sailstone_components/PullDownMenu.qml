import QtQuick 2.2
import Sailfish.Silica 1.0

PullDownMenu {
    MenuItem {
        text: "About"
        onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
    }

    MenuItem {
        text: "Favourites"
        onClicked: pageStack.push(Qt.resolvedUrl("FavouritesPage.qml"))
    }

    MenuItem {
        text: "Search"
        onClicked: pageStack.push(Qt.resolvedUrl("SearchPage.qml"))
    }
}
