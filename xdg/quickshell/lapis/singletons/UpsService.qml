pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property real percentage: 0
	property bool charging: false
	property bool available: false

	property var history: []
	property bool historyReady: false

	readonly property int retentionDays: 30
	readonly property int retentionSeconds: retentionDays * 86400

	FileView {
		id: historyFile

		path: Quickshell.dataDir + "/battery_history.json"

		atomicWrites: true

		onLoaded: {
			try {
				const data = JSON.parse(text())
				root.history = Array.isArray(data.history) ? data.history : []
				root.historyReady = true
			} catch (e) {
				console.warn("Invalid battery history:", e)
			}
		}

		onLoadFailed: error => {
			console.warn("Battery history not loaded:", error)
			root.history = []
			root.historyReady = true
		}

		onSaveFailed: error => {
			console.warn("Failed to save battery history:", error)
		}
	}

	function recordBattery(level) {
		if (!historyReady) return

		const now = Math.floor(Date.now() / 1000)
		const cutoff = now - retentionSeconds

		let points = history.slice()

		let baseline = null

		for (const point of points) {
			if (point.timestamp < cutoff) {
				baseline = point
			} else {
				break
			}
		}

		points = points.filter(p => p.timestamp >= cutoff)

		if (baseline !== null) points.unshift(baseline)

		const last = points.length > 0 ? points[points.length - 1] : null

		const changed = last === null || last.level !== level

		if (changed) {
			points.push({timestamp: now, level: level})
		}

		if (changed || points.length !== history.length) {
			history = points

			historyFile.setText(JSON.stringify({history: history}))
		}
	}

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

					root.recordBattery(root.percentage)
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
