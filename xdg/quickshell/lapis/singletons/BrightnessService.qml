pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property int brightness: 50
	property int maximum: 1
	property bool available: false

	property int pendingBrightness: -1
	property int activeBrightness: -1

	function refresh() {
		if (!readMax.running && !readCurrent.running) readMax.running = true
	}

	function setBrightness(percent) {
		if (!available) return

		brightness = Math.max(1, Math.min(100, Math.round(percent)))

		if (writeBrightness.running && activeBrightness === brightness) {
			pendingBrightness = -1
			return
		}

		pendingBrightness = brightness

		flushPending()
	}

	function flushPending() {
		if (!available) return
		if (writeBrightness.running) return
		if (pendingBrightness < 0) return

		activeBrightness = pendingBrightness
		pendingBrightness = -1

		writeBrightness.command = [
			"brightnessctl",
			"-c", "backlight",
			"set", activeBrightness + "%"
		]

		writeBrightness.running = true
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

	Process {
		id: writeBrightness
		running: false

		onRunningChanged: {
			if (!running) {
				root.activeBrightness = -1
				if (root.pendingBrightness >= 0) root.flushPending()
			}
		}

		onExited: (exitCode, exitStatus) => {
			if (exitCode !== 0) {
				console.warn("brightnessctl failed:", exitCode, exitStatus)
			}
		}

		stderr: StdioCollector {
			onStreamFinished: {
				const message = text.trim()
				if (message.length > 0) console.warn("brightnessctl:", message)
			}
		}
	}

	Component.onCompleted: refresh()
}
