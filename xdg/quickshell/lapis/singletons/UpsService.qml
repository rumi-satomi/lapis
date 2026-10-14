pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property real percentage: 0
	property bool charging: false
	property bool available: false

	Process {
		id: upsProcess
		command: ["/usr/local/bin/ups-status-qs"]

		stdout: StdioCollector {
			onStreamFinished: {
				try {
					const data = JSON.parse(text)
					const value = Number(data.percentage)

					if (!Number.isFinite(value)) throw new Error("Invalid percentage")

					root.percentage = Math.max(0, Math.min(100, value))
					root.charging = data.charging === true
					root.available = true
				} catch (error) {
					console.warn("Invalid UPS status:", error)
					root.available = false
				}
			}
		}
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		triggeredOnStart: true

		onTriggered: {
			if (!upsProcess.running) upsProcess.running = true
		}
	}
}
