pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	Process {
		id: gestures

		command: [Paths.lisgd]

		running: Settings.gesturesEnabled
	}

	readonly property bool running: gestures.running
}
