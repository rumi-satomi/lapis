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
		
		console.log("phoneMode:", DeviceState.phoneMode)
		console.log("vertical auto", Settings.autoKeyboardVertical)
		console.log("horizontal auto:", Settings.autoKeyboardHorizontal)
		console.log("effective autoEnabled:", root.autoEnabled)

		if (root.autoEnabled) args.push("--auto")
		
		console.log("Starting wvkbd with:", JSON.stringify(args))

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
