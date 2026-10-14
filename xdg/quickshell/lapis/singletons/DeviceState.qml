pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property var activeScreen: Quickshell.screens.length > 0 ? Quickshell.screens[0] : null

	readonly property bool phoneMode: activeScreen !== null && activeScreen.height > activeScreen.width
	readonly property bool handheldMode: activeScreen !== null && activeScreen.height < activeScreen.width
}
