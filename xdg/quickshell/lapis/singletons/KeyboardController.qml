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
		const args = [Paths.wvkbd, "--hidden"]
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
