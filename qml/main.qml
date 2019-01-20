import QtQuick 2.2
import Sailfish.Silica 1.0

import io.thp.pyotherside 1.4

import "./sailstone_components" as SailstoneComponents

ApplicationWindow {
    id : mainWindow
    initialPage: Component { SailstoneComponents.MainPage {} }

    property alias python : python

    Python {
      id: python

      Component.onCompleted: {
          addImportPath(Qt.resolvedUrl("../py"));
          importModule('main', function () {});
      }

      onError: {
        console.log('python error: ' + traceback);
      }

      onReceived: {
        console.log('got message from python: ' + data);
      }
    }
}
