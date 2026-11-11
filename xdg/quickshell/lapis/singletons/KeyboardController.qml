pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	readonly property bool autoEnabled: DeviceState.phoneMode ? Settings.autoKeyboardVertical : Settings.autoKeyboardHorizontal

	Process {
		id: keyboard
	}

	function command() {
		const args = [
			Paths.wvkbd, "--hidden", "--no-popup",
			"--bg", Theme.backgroundWVKBD,
			"--fg", Theme.surfaceTintWVKBD,
			"--fg-sp", Theme.surfaceTintWVKBD,
			"--press", Theme.primary.toString().slice(1),
			"--press-sp", Theme.primary.toString().slice(1),
			"--text", Theme.backgroundForeground.toString().slice(1)
		]
		if (root.autoEnabled) args.push("--auto")
		return args
	}

	function restart() {
		keyboard.exec(command())
	}

	Component.onCompleted: restart()

	onAutoEnabledChanged: {
		restart()
	}
}
