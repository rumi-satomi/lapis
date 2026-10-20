pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	FileView {
		id: file

		path: Quickshell.stateDir + "/settings.json"
		blockLoading: true

		onAdapterUpdated: writeAdapter()

		JsonAdapter {
			id: settings

			property bool autoKeyboardVertical: true
			property bool autoKeyboardHorizontal: false
			property bool gesturesEnabled: true
		}
	}

	property alias autoKeyboardVertical: settings.autoKeyboardVertical
	property alias autoKeyboardHorizontal: settings.autoKeyboardHorizontal
	property alias gesturesEnabled: settings.gesturesEnabled
}
