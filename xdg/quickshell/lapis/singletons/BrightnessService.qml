pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property int brightness: 50
	property int maximum: 1
	property bool available: false

	function refresh() {
		if (!readMax.running && !readCurrent.running) readMax.running = true
	}

	function setBrightness(percent) {
		if (!available) return

		brightness = Math.max(1, Math.min(100, Math.round(percent)))
		applyDelay.restart()
	}

	Process {
		id: readMax

		command: ["brightnessctl", "-c", "backlight", "max"]

		stdout: StdioCollector {
				onStreamFinished: {
				const value = Number(text.trim())

				if (value > 0) {
					root.maximum = value
					readCurrent.running = true
				} else {
					root.available = false
				}
			}
		}
	}

	Process {
		id: readCurrent

		command: ["brightnessctl", "-c", "backlight", "get"]

		stdout: StdioCollector {
			onStreamFinished: {
				const value = Number(text.trim())

				if (Number.isFinite(value)) {
					root.brightness = Math.round(value / root.maximum * 100)
					root.available = true
				}
			}
		}
	}

	Timer {
		id: applyDelay

		interval: 30
		repeat: false

		onTriggered: {
			if (!root.available) return

			writeBrightness.command = ["brightnessctl", "-c", "backlight", "set", root.brightness + "%"]
			writeBrightness.running = true
		}
	}

	Process {
		id: writeBrightness
		running: false
	}

	Component.onCompleted: {
		refresh()
	}
}
