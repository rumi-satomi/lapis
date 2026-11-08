import QtQuick
import QtQuick.Layouts

import "../singletons"
import "../components"

LapisPopupWindow {
	id: root

	property int selectedRange: 24

	readonly property var history: UpsService.history
	property real nowSeconds: Date.now() / 1000
	readonly property real windowStart: nowSeconds - selectedRange * 3600

	Timer {
		interval: 60000
		running: true
		repeat: true

		onTriggered: root.nowSeconds = Date.now() / 1000
	}

	body: ColumnLayout {
		spacing: Theme.spacing
		
		Text {
			id: heading
			text: "UPS Battery - Last " + root.selectedRange + " hours"
			color: Theme.surfaceForeground
			font.pixelSize: Theme.fontSize
			font.family: Theme.fontFamily
		}

		Row {
			spacing: 4

			Repeater {
				model: [
					{ label: "6h", hours: 6},
					{ label: "12h", hours: 12},
					{ label: "24h", hours: 24},
					{ label: "7d", hours: 168},
				]

				delegate: Rectangle {
					required property var modelData

					width: 64
					height: 28
					radius: 6

					readonly property bool selected: selectedRange === modelData.hours

					color: selected ? Theme.primary : Theme.surface3

					Text {
						anchors.centerIn: parent
						text: modelData.label
						color: selected ? Theme.primaryForeground : Theme.surfaceForeground
					}

					MouseArea {
						anchors.fill: parent
						onClicked: selectedRange = modelData.hours
					}
				}
			}
		}

		Canvas {
			id: chart

			implicitWidth: 400
			implicitHeight: 300

			onWidthChanged: requestPaint()
			onHeightChanged: requestPaint()

			Connections {
				target: root

				function onHistoryChanged() {
					chart.requestPaint()
				}

				function onNowSecondsChanged() {
					chart.requestPaint()
				}

				function onSelectedRangeChanged() {
					chart.requestPaint()
				}

				function onVisibleChanged() {
					if (root.visible) {
						root.nowSeconds = Date.now() / 1000
						chart.requestPaint()
					}
				}
			}

			onPaint: {
				const ctx = getContext("2d")
				ctx.clearRect(0, 0, width, height)

				const left = 35
				const right = width - 10
				const top = 10
				const bottom = height - 25

				const start = root.windowStart
				const end = root.nowSeconds

				function x(t) {
					return left + (t - start) / (end - start) * (right - left)
				}

				function y(level) {
					return bottom - level / 100 * (bottom - top)
				}

				ctx.strokeStyle = Theme.surfaceForeground
				ctx.lineWidth = 1
				ctx.fillStyle = Theme.surfaceForeground
				ctx.font = "11px sans-serif"

				for (let pct = 0; pct <= 100; pct += 25) {
					const py = y(pct)

					ctx.beginPath()
					ctx.moveTo(left, py)
					ctx.lineTo(right, py)
					ctx.stroke()

					ctx.fillText(pct + "%", 0, py + 4)
				}

				for (let h = 0; h <= root.selectedRange; h += root.selectedRange / 6) {
					const px = x(start + h * 3600)

					ctx.beginPath()
					ctx.moveTo(px, top)
					ctx.lineTo(px, bottom)
					ctx.stroke()

					const label = h === root.selectedRange ? "Now" : "-" + (root.selectedRange - h) + "h"
					ctx.fillText(label, px - 10, height - 5)
				}

				const points = root.history
				if (points.length === 0) return

				let level = null

				for (const p of points) {
					if (p.timestamp <= start) {
						level = p.level
					} else {
						break
					}
				}

				ctx.beginPath()
				ctx.strokeStyle = Theme.primary
				ctx.lineWidth = 2

				let hasStarted = false

				if (level !== null) {
					ctx.moveTo(x(start), y(level))
					hasStarted = true
				}

				for (const p of points) {
					if (p.timestamp < start || p.timestamp > end) continue

					const px = x(p.timestamp)
					const py = y(p.level)

					if (!hasStarted) {
						ctx.moveTo(px, py)
						hasStarted = true
					} else {
						ctx.lineTo(px, y(level))
						ctx.lineTo(px, py)
					}

					level = p.level
				}

				if (hasStarted && level !== null) {
					ctx.lineTo(x(end), y(level))
					ctx.stroke()
				}
			}
		}
	}
}

